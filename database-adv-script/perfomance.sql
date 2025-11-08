-- Write an initial query that retrieves all bookings along with the user details, property details, 
-- and payment details and save it on perfomance.sql

SELECT
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    b.user_id,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.status,
    pty.name AS property_name,
    pty.location,
    p.payment_id,
    p.amount,
    p.payment_method,
    p.payment_date
FROM Users u
JOIN Bookings b ON u.user_id = b.user_id
JOIN Properties pty ON b.property_id = pty.property_id
JOIN Payments p ON b.booking_id = p.booking_id;


-- Refactored query to reduce execution time.
EXPLAIN ANALYZE
SELECT
    u.first_name,
    u.last_name,
    b.booking_id,
    pty.name AS property_name,
    p.amount,
    p.payment_method
FROM Users u
JOIN Bookings b ON u.user_id = b.user_id
JOIN Properties pty ON b.property_id = pty.property_id
JOIN Payments p ON b.booking_id = p.booking_id
WHERE b.status = 'confirmed';
