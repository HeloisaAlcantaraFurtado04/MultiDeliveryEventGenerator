
import sqlite3
import os

def setup_database():
    db_path = "database/multidelivery.db"

    if os.path.exists(db_path):
        print("Database already exists")
        return

    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()

    with open("database/create.sql", "r") as file:
        sql = file.read()

    cursor.executescript(sql)

    conn.commit()
    conn.close()

    print("Database created successfully")


if __name__ == "__main__":
    setup_database()
