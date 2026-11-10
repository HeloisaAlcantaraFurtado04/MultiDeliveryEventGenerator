CREATE TABLE users(
    user_id INTEGER PRIMARY KEY, 
    name TEXT NOT NULL, 
    role TEXT NOT NULL CHECK (role IN('student','driver')),
    email TEXT NOT NULL, 
    phone TEXT
); 

CREATE TABLE sellers(
    seller_id INTEGER PRIMARY KEY, 
    name TEXT NOT NULL,
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
-- LM generated data 
INSERT INTO users (user_id, name, role, email, phone) VALUES 
(1, 'Alice Smith', 'student', 'alice.smith@university.edu', '555-0101'),
(2, 'Bob Jones', 'student', 'bob.jones@university.edu', '555-0102'),
(3, 'Charlie Brown', 'student', 'charlie.b@university.edu', '555-0103'),
(4, 'Diana Prince', 'student', 'diana.p@university.edu', '555-0104'),
(5, 'Evan Wright', 'student', 'evan.w@university.edu', '555-0105'),
(6, 'Fiona Apple', 'student', 'fiona.a@university.edu', '555-0106'),
(7, 'George Miller', 'student', 'george.m@university.edu', '555-0107'),
(8, 'Hannah Abbott', 'student', 'hannah.a@university.edu', '555-0108'),
(9, 'Ian Malcolm', 'student', 'ian.m@university.edu', '555-0109'),
(10, 'Julia Roberts', 'student', 'julia.r@university.edu', '555-0110'),
(11, 'Kevin Hart', 'driver', 'kevin.h@university.edu', '555-0111'),
(12, 'Laura Dern', 'driver', 'laura.d@university.edu', '555-0112'),
(13, 'Mike Meyers', 'driver', 'mike.m@university.edu', '555-0113'),
(14, 'Nina Simone', 'driver', 'nina.s@university.edu', '555-0114'),
(15, 'Oscar Isaac', 'driver', 'oscar.i@university.edu', '555-0115');

INSERT INTO sellers (seller_id, name, category, location) VALUES 
(1, 'Campus Burger', 'Restaurant', 'Student Union'),
(2, 'Library Cafe', 'Coffee', 'Main Library'),
(3, 'Bookstore Supplies', 'Retail', 'South Hall'),
(4, 'Pizza Express', 'Restaurant', 'North Campus'),
(5, 'Late Night Bites', 'Snacks', 'East Dorms');

INSERT INTO items (item_id, seller_id, name, price, is_available) VALUES 
(1, 1, 'Cheeseburger', 5.99, 1),
(2, 1, 'Fries', 2.49, 1),
(3, 1, 'Veggie Burger', 6.49, 1),
(4, 1, 'Milkshake', 3.99, 1),
(5, 2, 'Latte', 4.50, 1),
(6, 2, 'Iced Coffee', 3.50, 1),
(7, 2, 'Blueberry Muffin', 2.99, 1),
(8, 2, 'Espresso', 2.50, 1),
(9, 3, 'Notebook', 4.99, 1),
(10, 3, 'Blue Pens (3-pack)', 3.49, 1),
(11, 3, 'Highlighter Set', 5.99, 1),
(12, 3, 'Scientific Calculator', 15.99, 0),
(13, 4, 'Cheese Slice', 3.00, 1),
(14, 4, 'Pepperoni Slice', 3.50, 1),
(15, 4, 'Whole Margherita Pizza', 14.99, 1),
(16, 4, 'Garlic Knots', 4.99, 1),
(17, 5, 'Nachos', 6.50, 1),
(18, 5, 'Energy Drink', 2.99, 1),
(19, 5, 'Candy Bar', 1.50, 1),
(20, 5, 'Instant Ramen', 1.99, 1);
