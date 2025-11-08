# Airbnb Clone Database — Index Performance Optimization

## Objective
Identify high-usage columns in tables and create indexes to improve query performance.

---

## High-Usage Columns

- **Users:** email (used in login queries), user_id (PK)    
- **Properties:** host_id, location  
- **Bookings:** user_id, property_id, status
- **Payments:** booking_id, payment_method
- **Reviews:** user_id, property_id, rating
- **Messages:** sender_id, recipient_id

---

## Index Creation Commands

```sql
CREATE INDEX idx_user_email ON Users(email);

CREATE INDEX idx_host_id ON Properties(host_id);
CREATE INDEX idx_location ON Properties(location);
 
CREATE INDEX idx_booking_property_id ON Bookings(property_id);
CREATE INDEX idx_booking_user_id ON Bookings(user_id);
CREATE INDEX idx_booking_status ON Bookings(status);

CREATE INDEX idx_payment_booking_id ON Payments(booking_id);
CREATE INDEX idx_payment_method ON Payments(payment_method);

CREATE INDEX idx_review_property_id ON Reviews(property_id);
CREATE INDEX idx_review_user_id ON Reviews(user_id);
CREATE INDEX idx_rating ON Reviews(rating);

CREATE INDEX idx_message_sender_id ON Messages(sender_id);
CREATE INDEX idx_message_recipient_id ON Messages(recipient_id);
