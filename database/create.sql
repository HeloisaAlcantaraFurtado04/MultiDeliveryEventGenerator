CREATE TABLE users (
    user_id INTEGER,
    name    VARCHAR(100) NOT NULL,
    role    VARCHAR(10)  NOT NULL,
    email   VARCHAR(255) NOT NULL,
    phone   VARCHAR(20),
    PRIMARY KEY (user_id),
    CHECK (role IN ('student', 'driver'))
);

CREATE TABLE sellers (
    seller_id  INTEGER,
    store_name VARCHAR(100) NOT NULL,
    category   VARCHAR(50)  NOT NULL,
    location   VARCHAR(100) NOT NULL,
    PRIMARY KEY (seller_id)
);

CREATE TABLE items (
    item_id      INTEGER,
    seller_id    INTEGER,
    name         VARCHAR(100) NOT NULL,
    price        REAL         NOT NULL,
    is_available BOOLEAN DEFAULT 1,
    PRIMARY KEY (item_id),
    FOREIGN KEY (seller_id) REFERENCES sellers (seller_id)
);

CREATE TABLE orders (
    order_id                INTEGER,
    order_status            VARCHAR(20),
    student_id              INTEGER,
    driver_id               INTEGER,
    delivery_location       VARCHAR(100) NOT NULL,
    estimated_delivery_time INTEGER      NOT NULL,
    created_at              INTEGER      NOT NULL,
    PRIMARY KEY (order_id),
    FOREIGN KEY (student_id) REFERENCES users (user_id),
    FOREIGN KEY (driver_id)  REFERENCES users (user_id)
);

CREATE TABLE order_items (
    order_item_id INTEGER,
    order_id      INTEGER,
    item_id       INTEGER,
    seller_id     INTEGER,
    quantity      INTEGER NOT NULL,
    PRIMARY KEY (order_item_id),
    CHECK (quantity > 0),
    FOREIGN KEY (order_id)  REFERENCES orders (order_id),
    FOREIGN KEY (item_id)   REFERENCES items (item_id),
    FOREIGN KEY (seller_id) REFERENCES sellers (seller_id)
);

CREATE TABLE events (
    event_id                INTEGER,
    event_type              VARCHAR(50) NOT NULL,
    event_time              INTEGER     NOT NULL,
    ingest_time             INTEGER     NOT NULL,
    order_id                INTEGER,
    student_id              INTEGER,
    seller_id               INTEGER,
    driver_id               INTEGER,
    order_item_id           INTEGER,
    item_id                 INTEGER,
    delivery_location       VARCHAR(100),
    estimated_delivery_time INTEGER,
    created_at              INTEGER,
    is_available            BOOLEAN,
    PRIMARY KEY (event_id),
    FOREIGN KEY (order_id)      REFERENCES orders (order_id),
    FOREIGN KEY (student_id)    REFERENCES users (user_id),
    FOREIGN KEY (seller_id)     REFERENCES sellers (seller_id),
    FOREIGN KEY (driver_id)     REFERENCES users (user_id),
    FOREIGN KEY (order_item_id) REFERENCES order_items (order_item_id),
    FOREIGN KEY (item_id)       REFERENCES items (item_id)
);
