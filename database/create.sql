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
-- LLM generated data 
INSERT INTO users (user_id, name, role, email, phone) VALUES 
(1, 'Emma Watson', 'student', 'emma.w@university.edu', '555-0201'),
(2, 'John Boyega', 'student', 'john.b@university.edu', '555-0202'),
(3, 'Zendaya Coleman', 'student', 'zendaya.c@university.edu', '555-0203'),
(4, 'Tom Holland', 'student', 'tom.h@university.edu', '555-0204'),
(5, 'Florence Pugh', 'student', 'florence.p@university.edu', '555-0205'),
(6, 'Timothee Chalamet', 'student', 'timothee.c@university.edu', '555-0206'),
(7, 'Anya Taylor-Joy', 'student', 'anya.t@university.edu', '555-0207'),
(8, 'Dev Patel', 'student', 'dev.p@university.edu', '555-0208'),
(9, 'Saoirse Ronan', 'student', 'saoirse.r@university.edu', '555-0209'),
(10, 'Lucas Hedges', 'student', 'lucas.h@university.edu', '555-0210'),
(11, 'Adam Driver', 'driver', 'adam.d@university.edu', '555-0211'),
(12, 'Daisy Ridley', 'driver', 'daisy.r@university.edu', '555-0212'),
(13, 'Pedro Pascal', 'driver', 'pedro.p@university.edu', '555-0213'),
(14, 'Bella Ramsey', 'driver', 'bella.r@university.edu', '555-0214'),
(15, 'Gwendoline Christie', 'driver', 'gwendoline.c@university.edu', '555-0215');

INSERT INTO sellers (seller_id, store_name, category, location) VALUES 
(1, 'Taco Plaza', 'Restaurant', 'West Campus'),
(2, 'The Daily Grind', 'Coffee', 'Student Center'),
(3, 'Tech & Textbooks', 'Retail', 'North Hall'),
(4, 'Sushi Go', 'Restaurant', 'East Campus Village'),
(5, 'Midnight Munchies', 'Snacks', 'South Dorms');

INSERT INTO items (item_id, seller_id, name, price, is_available) VALUES 
(1, 1, 'Carne Asada Tacos (3)', 8.99, 1),
(2, 1, 'Chicken Burrito', 9.50, 1),
(3, 1, 'Chips and Guacamole', 4.99, 1),
(4, 1, 'Horchata', 3.00, 1),
(5, 2, 'Cold Brew', 4.00, 1),
(6, 2, 'Caramel Macchiato', 4.75, 1),
(7, 2, 'Avocado Toast', 6.50, 1),
(8, 2, 'Matcha Latte', 5.00, 1),
(9, 3, 'Graphing Calculator', 85.00, 1),
(10, 3, 'Mechanical Pencils', 6.99, 1),
(11, 3, 'College Ruled Notebook', 3.50, 1),
(12, 3, 'USB-C Charging Cable', 12.99, 0),
(13, 4, 'Spicy Tuna Roll', 7.99, 1),
(14, 4, 'California Roll', 6.50, 1),
(15, 4, 'Edamame', 3.99, 1),
(16, 4, 'Miso Soup', 2.50, 1),
(17, 5, 'Spicy Potato Chips', 2.00, 1),
(18, 5, 'Gummy Bears', 1.75, 1),
(19, 5, 'Bottled Water', 1.50, 1),
(20, 5, 'Chocolate Chip Cookies', 2.25, 1);
