CREATE TABLE users(
    user_id INTEGER PRIMARY KEY, 
    name TEXT NOT NULL, 
    role TEXT NOT NULL CHECK (role IN('student','driver')),
    email TEXT NOT NULL, 
    phone TEXT
); 

CREATE TABLE sellers(
    seller_id INTEGER PRIMARY KEY, 
    store_name TEXT NOT NULL,
    category TEXT NOT NULL,
    location TEXT NOT NULL 
); 

CREATE TABLE items(
    item_id INTEGER PRIMARY KEY, 
    seller_id INTEGER REFERENCES sellers(seller_id),
    name TEXT NOT NULL, 
    price REAL NOT NULL, 
    is_available BOOLEAN DEFAULT 1 

); 


CREATE TABLE orders(
    order_id INTEGER PRIMARY KEY,
    order_status TEXT,
    student_id INTEGER REFERENCES users(user_id),
    driver_id  INTEGER REFERENCES users(user_id),
    delivery_location TEXT NOT NULL,
    estimated_delivery_time INTEGER NOT NULL, 
    created_at INTEGER NOT NULL 
); 

CREATE TABLE order_items(
    order_item_id INTEGER PRIMARY KEY, 
    order_id INTEGER REFERENCES orders(order_id),
    item_id INTEGER REFERENCES items(item_id),
    seller_id INTEGER REFERENCES sellers(seller_id),
    quantity INTEGER NOT NULL CHECK (quantity > 0)

); 


CREATE TABLE events(
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

