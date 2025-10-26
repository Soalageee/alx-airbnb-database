# Airbnb Clone Database Normalization

## Overview
This document explains the normalization steps applied to the Airbnb Clone database schema to ensure it adheres to the Third Normal Form (3NF).

## Normalization Table

| Table     | 1NF (Atomic Values)                       | 2NF (Full Dependency)                                           | 3NF (No Transitive Dependency)                                               |
|-----------|-------------------------------------------|-----------------------------------------------------------------|----------------------------------------------------------------------------|
| User      | All attributes are atomic                 | All non-key attributes depend fully on `user_id`               | No transitive dependencies                                                   |
| Property  | All attributes are atomic                 | All non-key attributes depend fully on `property_id`           | No transitive dependencies                                                   |
| Booking   | All attributes are atomic                 | All non-key attributes depend fully on `booking_id`            | `total_price` could be derived from `Property.pricepernight × duration`, but kept for efficiency |
| Payment   | All attributes are atomic                 | All non-key attributes depend fully on `payment_id`            | No transitive dependencies                                                   |
| Review    | All attributes are atomic                 | All non-key attributes depend fully on `review_id`             | No transitive dependencies                                                   |
| Message   | All attributes are atomic                 | All non-key attributes depend fully on `message_id`            | No transitive dependencies                                                   |

## Summary
- The Airbnb Clone database is normalized up to **3NF**.
- All tables have atomic values, full dependency on primary keys, and no transitive dependencies (except the optional `total_price` in Booking for convenience).
- This ensures minimal redundancy, efficient storage, and reliable data integrity.