import sqlite3

from pathlib import Path

db_path = Path(__file__).resolve().parent.parent / "database" / "multidelivery.db"
conn = sqlite3.connect(db_path)
cursor = conn.cursor()

print("--- TESTING CEPAL EVENT CONSTRAINTS ---")

# Test 1: Validate sequence (OrderPlaced must happen before PaymentCompleted)
cursor.execute("""
    SELECT e1.order_id 
    FROM events e1 
    JOIN events e2 ON e1.order_id = e2.order_id 
    WHERE e1.event_type = 'OrderPlaced' 
      AND e2.event_type = 'PaymentCompleted' 
      AND e1.event_time >= e2.event_time;
""")
violations = cursor.fetchall()
print(
    f"1. OrderPlaced -> PaymentCompleted time violations: {len(violations)}"
)

# Test 2: Ingestion delay constraint (1 <= ingest_time - event_time <= 10)
cursor.execute("""
    SELECT event_id, (ingest_time - event_time) AS delay 
    FROM events 
    WHERE (ingest_time - event_time) < 1 OR (ingest_time - event_time) > 10;
""")
ingest_violations = cursor.fetchall()
print(f"2. Ingestion MAXDELAY (10) violations: {len(ingest_violations)}")

# Test 3: Multi-seller pickup completeness (Delivered only after all sellers picked up)
cursor.execute("""
    SELECT e_del.order_id 
    FROM events e_del
    WHERE e_del.event_type = 'OrderDelivered'
      AND EXISTS (
          SELECT 1 FROM events e_prep
          WHERE e_prep.order_id = e_del.order_id
            AND e_prep.event_type = 'ItemsPreparing'
            AND NOT EXISTS (
                SELECT 1 FROM events e_pick
                WHERE e_pick.order_id = e_del.order_id
                  AND e_pick.seller_id = e_prep.seller_id
                  AND e_pick.event_type = 'ItemsPickedUp'
                  AND e_pick.event_time < e_del.event_time
            )
      );
""")
pickup_violations = cursor.fetchall()
print(f"3. Premature delivery violations: {len(pickup_violations)}")

conn.close()