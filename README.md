# MultiDeliveryEventGenerator


# Multi-Delivery App

## Overview
The Multi-Delivery App allows students to order items from different stores or restaurants and have them delivered to a selected campus location. The system tracks ordering, payment, preparation, pickups, and delivery to ensure that each order is completed correctly.

## Constraints

### 1. Ordering
An order must be placed before it can be processed.

### 2. Payment
Payment must be completed before preparation or dispatch can begin.

### 3. Availability
An item must be available before the seller can fulfill the order.

### 4. Preparation
Food must be prepared, and books or supplies must be collected, before pickup.

### 5. Pickup
The delivery driver must pick up an item before delivering it.

### 6. Delivery Sequence
An order cannot be marked as delivered before it has been picked up.

### 7. Timing
An order should be delivered within the estimated delivery window.

### 8. Location
The delivery must be made to the student's selected campus location.

### 9. Student Identity
Each order must be associated with the correct student account.

### 10. Correct Items
The student must receive the items they actually ordered.

### 11. Completeness
An order should not be marked complete until all required items have been accounted for and delivered.

### 12. Dependency
If an order combines items from different stores or restaurants, the app must account for all required pickups before completing the delivery.

### 13. Event Reference
Each pickup and delivery event must be associated with the correct order.

### 14. Status
An order's status must follow valid transitions:

`Placed → Preparing → Picked Up → Delivered`

An order must not skip required stages or transition to a status that violates the delivery process.

---

## Event Sequence

The following events represent the main actions in the ordering and delivery process.

| Event | Description |
|---|---|
| `PlaceOrder` | The student places an order. |
| `ConfirmOrder` | The app confirms the order. |
| `PrepareItems` | Stores or restaurants prepare the ordered items. |
| `PickupOrder` | The driver picks up the items. |
| `DeliverOrder` | The driver delivers the items to the student. |

---

## Overall Process

The complete delivery process follows these six events:

1. **`OrderPlaced`** — The student submits an order.
2. **`PaymentCompleted`** — The student's payment is completed.
3. **`ItemsPreparing`** — The seller begins preparing the items.
4. **`ItemsReady`** — The items are ready for pickup.
5. **`ItemsPickedUp`** — The driver picks up the items.
6. **`OrderDelivered`** — The order reaches the student, completing the delivery process.

### Process Flow

```text
OrderPlaced
    ↓
PaymentCompleted
    ↓
ItemsPreparing
    ↓
ItemsReady
    ↓
ItemsPickedUp
    ↓
OrderDelivered
```

For orders involving multiple stores or restaurants, the system must track the required pickups and ensure that all items are accounted for before the delivery is marked complete.

---

## Database

The database stores the information needed to manage students, sellers, items, orders, and delivery events.

### Tables

- `users`
- `sellers`
- `items`
- `orders`
- `order_items`
- `events`

### References

- Database schema: *Add database schema reference here.*
- Event definitions: *Add event definitions or CEP query reference here.*
