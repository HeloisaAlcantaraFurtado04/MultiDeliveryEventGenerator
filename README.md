# MultiDeliveryEventGenerator

## Overview

The Multi-Delivery App is an application where students can order food, books, and other supplies from different stores and restaurants around campus. 

Students can look at items without signing in, but they need to log in when placing an order. They can also order items from multiple stores in the same order.
## Constraints

### 1. Ordering
An order must be placed before it can be processed

### 2. Payment
Payment must be completed before the sellers start preparing the items. If payment fails, the order is cancelled.

### 3. Availability
Items must be available for the seller to prepare the order.

### 4. Preparation
Food needs to be prepared, while books and supplies need to be collected before pickup.

### 5. Pickup
A driver must be assigned before picking up the items.

### 6. Delivery Sequence
An order cannot be delivered before all items have been picked up.

### 7. Timing
An order should be delivered within the estimated time, but delays can happen.

### 8. Location
The order must be delivered to the location selected by the student.

### 9. Student Identity
Students need to sign in before placing an order, and each order must be linked to the correct student.

### 10. Correct Items
The student should receive the same items and quantities they ordered.

### 11. Completeness
An order should only be marked as delivered when all items have been delivered.

### 12. Multiple Sellers
An order can have items from different stores. Each seller prepares their own items, and the driver needs to pick up everything before delivery.

### 13. Event Reference
Each event must be linked to the correct order. Events involving sellers should also have the correct seller ID.

---

## Event Sequence

These are the main events that can happen during an order.

| Event | Description |
|---|---|
| `OrderStarted` | The student starts a new order |
| `AddItem` | Items are added to the order |
| `OrderPlaced` | The student places an order |
| `PaymentCompleted` | The payment goes through |
| `PaymentFailed` | The payment does not go through |
| `OrderCancelled` | The order is cancelled |
| `ItemsPreparing` | The seller starts preparing the items |
| `ItemsReady` | The items are ready for pickup |
| `DriverAssigned` | A driver is assigned to the order |
| `ItemsPickedUp` | The driver picks up the items from a seller |
| `OrderDelivered` | The order is delivered to the student |

---

## Overall Process

The process starts when a student selects items from one or more stores. The student then signs in, chooses a delivery location, and places the order.

1. OrderStarted — The student starts a new order.

2. AddItem — The items selected by the student are recorded in the order.

3. OrderPlaced — The student places the order.

4. PaymentCompleted — The payment is completed.

5. ItemsPreparing — The sellers start preparing their items.

6. ItemsReady — The items are ready to be picked up.

7. DriverAssigned — A driver is assigned to pick up the order.

8. ItemsPickedUp — The driver picks up the items from the different sellers.

9. OrderDelivered — The driver delivers the complete order to the student.

If the payment fails, the order is cancelled and the process stops.

Also, when an order has items from different stores, the sellers might finish preparing their items at different times. The driver needs to pick up the items from all the stores before completing the delivery.


### Process Flow

```text
OrderStarted
     |
     v
AddItem (one or more)
     |
     v
OrderPlaced
     |
     v
Payment
     |
     |---- PaymentFailed ---> OrderCancelled
     |
     v
PaymentCompleted
     |
     v
ItemsPreparing (per seller)
     |
     v
ItemsReady (per seller)
     |
     v
DriverAssigned
     |
     v
ItemsPickedUp (per seller)
     |
     v
OrderDelivered
```

The `ItemsPreparing`, `ItemsReady`, and `ItemsPickedUp` events can happen multiple times if the order includes items from different sellers.

---
## Database

The database contains information about students, drivers, sellers, items, orders, and events.

We use six tables:

| Table | Attributes | Description |
|---|---|---|
| `users` | `user_id`, `name`, `role` | Stores students and drivers |
| `sellers` | `seller_id`, `store_name`, `category` | Stores information about the different stores and restaurants |
| `items` | `item_id`, `seller_id`, `name`, `price`, `is_available` | Stores the items sold by each seller and their availability |
| `orders` | `order_id`, `student_id`, `driver_id`, `delivery_location`, `order_status`, `estimated_delivery_time`, `created_at` | Stores information about each order, including its status, delivery location, and assigned driver |
| `order_items` | `order_item_id`, `order_id`, `item_id`, `quantity` | Stores the items and quantities included in each order |
| `events` | `event_id`, `order_id`, `seller_id`, `event_type`, `timestamp` | Stores the events generated during the ordering and delivery process |

The `order_items` table connects items to an order, while the `items` table identifies which seller each item belongs to.

Each order is associated with a student, and a driver can be assigned during the delivery process. The `events` table records the events associated with each order, including seller-specific events when applicable.

An order can contain items from multiple sellers, and each seller prepares their own items before pickup.

link: (https://docs.google.com/spreadsheets/d/1u-LX9lzAdv4MZYq0FdlmohyunyQ-Uek2qdgAu1zaqhY/edit?usp=sharing)




