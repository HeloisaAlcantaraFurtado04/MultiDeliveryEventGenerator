# MultiDeliveryEventGenerator

## Overview

The Multi-Delivery App is an application where students can order food, books, and other supplies from different stores and restaurants around campus. They can choose a delivery location and have their items delivered there.

Students can look at items without signing in, but they need to log in when placing an order. They can also order items from multiple stores in the same order.Our goal is to generate event streams that represent how the ordering and delivery process works, including situations where payments fail or deliveries take longer than expected.

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

### 14. Status
An order should follow these status changes:

`Placed → Preparing → Picked Up → Delivered`

If the payment fails, the order can be cancelled instead.

---

## Event Sequence

These are the main events that can happen during an order.

| Event | Description |
|---|---|
| `OrderPlaced` | The student places an order. |
| `AddItem` | Items are added to the order. |
| `PaymentCompleted` | The payment goes through. |
| `PaymentFailed` | The payment does not go through. |
| `OrderCancelled` | The order is cancelled. |
| `ItemsPreparing` | The seller starts preparing the items. |
| `ItemsReady` | The items are ready for pickup. |
| `DriverAssigned` | A driver is assigned to the order. |
| `ItemsPickedUp` | The driver picks up the items from a seller. |
| `OrderDelivered` | The order is delivered to the student. |

---

## Overall Process

The process starts when a student selects items from one or more stores. The student then signs in, chooses a delivery location, and places the order.

1. **OrderPlaced** — The student places the order.
2. **AddItem** — The items selected by the student are recorded in the order.
3. **PaymentCompleted** — The payment is completed.
4. **ItemsPreparing** — The sellers start preparing their items.
5. **ItemsReady** — The items are ready to be picked up.
6. **DriverAssigned** — A driver is assigned to pick up the order.
7. **ItemsPickedUp** — The driver picks up the items from the different sellers.
8. **OrderDelivered** — The driver delivers the complete order to the student.

If the payment fails, the order is cancelled and the process stops.

Also, when an order has items from different stores, the sellers might finish preparing their items at different times. The driver needs to pick up the items from all the stores before completing the delivery.

Some orders might also take longer than expected.

### Process Flow

```text
OrderPlaced
     |
     v
AddItem
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
ItemsPreparing
     |
     v
ItemsReady
     |
     v
DriverAssigned
     |
     v
ItemsPickedUp
     |
     v
OrderDelivered
```

The `ItemsPreparing`, `ItemsReady`, and `ItemsPickedUp` events can happen multiple times if the order includes items from different sellers.

---

## Database

The database contains the information about students, sellers, items, and orders.

We use six tables:

| Table | Description |
|---|---|
| `users` | Stores students and drivers. |
| `sellers` | Stores the different stores and restaurants. |
| `items` | Stores the items sold by each seller. |
| `orders` | Stores information about each order. |
| `order_items` | Stores the items and quantities included in an order. |
| `events` | Stores the events generated during the process. |

The `order_items` table connects the items to an order, while the `items` table identifies which seller each item belongs to.

---

## Event Generation

We are using CEPAL to describe the events and how they are connected.

The simulation generates orders with different numbers of items and sellers. It also uses time distributions so that preparation, pickup, and delivery do not always take the same amount of time.

We also want to include cases where payments fail or deliveries are delayed, instead of having every order follow the exact same process.

Some parts, such as making sure all sellers have been picked up before delivery and choosing between successful and failed payments, still need to be implemented in the generator.



