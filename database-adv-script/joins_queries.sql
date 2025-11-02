-- INNER JOIN
-- Retrieve all bookings and the respective users who made those bookings
SELECT 
    b.id AS booking_id,
    u.id AS user_id,
    u.first_name,
    u.last_name,
    u.email,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price
FROM bookings b
INNER JOIN users u ON b.user_id = u.id;

-- LEFT JOIN
-- Retrieve all properties and their reviews, including properties that have no reviews
SELECT 
    p.id AS property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night,
    r.id AS review_id,
    r.rating,
    r.comment,
    r.created_at
FROM properties p
LEFT JOIN reviews r ON p.id = r.property_id;
ORDER BY created_at ASC

-- FULL OUTER JOIN
-- Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user
SELECT 
    u.id AS user_id,
    u.first_name,
    u.last_name,
    u.email,
    b.id AS booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price
FROM users u
LEFT JOIN bookings b ON u.id = b.user_id

UNION

SELECT 
    u.id AS user_id,
    u.first_name,
    u.last_name,
    u.email,
    b.id AS booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price
FROM users u
RIGHT JOIN bookings b ON u.id = b.user_id;