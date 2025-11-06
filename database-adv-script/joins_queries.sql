-- INNER JOIN
-- Retrieve all bookings and the respective users who made those bookings
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    u.first_name, 
    u.last_name,
    u.email
FROM Bookings b
INNER JOIN Users u
ON b.user_id = u.user_id;

-- LEFT JOIN
-- Retrieve all properties and their reviews, including properties that have no reviews
SELECT 
    P.name AS property_name,
    p.location AS property_address,
    r.rating AS property_rating,
    r.comment AS property_review,
    r.created_at AS date_of_review
FROM Properties P
LEFT JOIN Reviews r ON p.property_id = r.property_id
ORDER BY r.created_at ASC;

-- FULL OUTER JOIN
-- Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user
SELECT 
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    b.start_date,
    b.end_date,
    b.total_price,
    b.booking_id
FROM Users u
FULL JOIN Bookings b
ON u.user_id = b.user_id;