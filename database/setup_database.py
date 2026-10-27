import os
import sqlite3


def build_database(db_filename="multidelivery.db"):
    # Remove existing database file to start fresh
    if os.path.exists(db_filename):
        os.remove(db_filename)

    conn = sqlite3.connect(db_filename)
    cursor = conn.cursor()

    # Enable foreign key enforcement
    cursor.execute("PRAGMA foreign_keys = ON;")

    # 1. CREATE TABLES
    cursor.executescript("""
    CREATE TABLE users (
        user_id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        role TEXT CHECK(role IN ('student', 'driver')),
        email TEXT NOT NULL,
        phone TEXT
    );

    CREATE TABLE sellers (
        seller_id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        category TEXT NOT NULL,
        location TEXT NOT NULL
    );

    CREATE TABLE items (
        item_id INTEGER PRIMARY KEY,
        seller_id INTEGER REFERENCES sellers(seller_id),
        name TEXT NOT NULL,
        price REAL NOT NULL,
        is_available BOOLEAN DEFAULT 1
    );

    CREATE TABLE orders (
        order_id INTEGER PRIMARY KEY,
        student_id INTEGER REFERENCES users(user_id),
        driver_id INTEGER REFERENCES users(user_id),
        delivery_location TEXT NOT NULL,
        estimated_delivery_time INTEGER NOT NULL,
        created_at INTEGER NOT NULL
    );

    CREATE TABLE order_items (
        order_item_id INTEGER PRIMARY KEY,
        order_id INTEGER REFERENCES orders(order_id),
        item_id INTEGER REFERENCES items(item_id),
        seller_id INTEGER REFERENCES sellers(seller_id),
        quantity INTEGER NOT NULL CHECK (quantity > 0)
    );

    CREATE TABLE events (
        event_id INTEGER PRIMARY KEY,
        event_type TEXT NOT NULL,
        event_time INTEGER NOT NULL,
        ingest_time INTEGER NOT NULL,
        order_id INTEGER REFERENCES orders(order_id),
        student_id INTEGER REFERENCES users(user_id),
        seller_id INTEGER REFERENCES sellers(seller_id),
        driver_id INTEGER REFERENCES users(user_id),
        order_item_id INTEGER REFERENCES order_items(order_item_id),
        item_id INTEGER REFERENCES items(item_id),
        delivery_location TEXT,
        estimated_delivery_time INTEGER,
        created_at INTEGER,
        is_available BOOLEAN
    );
    """)

    # 2. SEED ENTITY DATA
    users_data = [
        (1, "Alex Rivera", "student", "arivera@campus.edu", "555-0101"),
        (2, "Jordan Lee", "student", "jlee@campus.edu", "555-0102"),
        (3, "Taylor Swift", "student", "tswift@campus.edu", "555-0103"),
        (4, "Morgan Morgan", "student", "mmorgan@campus.edu", "555-0104"),
        (101, "Marcus Vance", "driver", "mvance@delivery.com", "555-0201"),
        (102, "Elena Rostova", "driver", "erostova@delivery.com", "555-0202"),
        (103, "Sam Wilson", "driver", "swilson@delivery.com", "555-0203"),
    ]
    cursor.executemany("INSERT INTO users VALUES (?, ?, ?, ?, ?);", users_data)

    sellers_data = [
        (10, "Campus Bookstore", "Supplies", "Student Center Hall A"),
        (20, "Pardall Dining Hall", "Food", "North Campus Quad"),
        (30, "UC Espresso & Bakery", "Food", "Library Plaza"),
    ]
    cursor.executemany("INSERT INTO sellers VALUES (?, ?, ?, ?);", sellers_data)

    items_data = [
        (501, 10, "Graphing Notebook", 4.50, 1),
        (502, 10, "Blue Pen 3-Pack", 2.99, 1),
        (503, 20, "Chicken Teriyaki Bowl", 11.99, 1),
        (504, 20, "Fountain Soda", 2.49, 1),
        (505, 30, "Iced Oat Latte", 5.75, 1),
        (506, 30, "Blueberry Muffin", 3.50, 1),
    ]
    cursor.executemany("INSERT INTO items VALUES (?, ?, ?, ?, ?);", items_data)

    orders_data = [
        (1001, 1, 101, "Library Study Room 3B", 75, 25),
        (1002, 2, 102, "Pardall Residence Hall Rm 112", 320, 260),
        (1003, 3, None, "Engineering Science Bldg Desk 4", 555, 510),
        (1004, 4, 103, "Student Union Lounge B", 695, 640),
    ]
    cursor.executemany("INSERT INTO orders VALUES (?, ?, ?, ?, ?, ?);", orders_data)

    order_items_data = [
        (1, 1001, 503, 20, 1),
        (2, 1001, 505, 30, 2),
        (3, 1002, 501, 10, 2),
        (4, 1002, 502, 10, 1),
        (5, 1003, 506, 30, 3),
        (6, 1004, 502, 10, 1),
        (7, 1004, 503, 20, 2),
        (8, 1004, 505, 30, 1),
    ]
    cursor.executemany("INSERT INTO order_items VALUES (?, ?, ?, ?, ?);", order_items_data)

    # 3. SEED SIMULATION EVENTS (Placeholder for your custom event sequence)
    events_data = [
        # Populate your fixed tuples here:
        # (event_id, event_type, event_time, ingest_time, order_id, student_id, seller_id, driver_id, order_item_id, item_id, delivery_location, estimated_delivery_time, created_at, is_available)
    ]

    if events_data:
        cursor.executemany(
            """INSERT INTO events VALUES 
            (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);""",
            events_data,
        )

    conn.commit()

    print(f"Database successfully generated at '{db_filename}'!\n")
    print("Table Record Summary:")
    print("-" * 25)
    tables = [
        "users",
        "sellers",
        "items",
        "orders",
        "order_items",
        "events",
    ]
    for table in tables:
        cursor.execute(f"SELECT COUNT(*) FROM {table};")
        count = cursor.fetchone()[0]
        print(f"  {table:<15}: {count} records")

    conn.close()


if __name__ == "__main__":
    build_database()