-- 1. Total bookings per user (aggregation)
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    COUNT(b.booking_id) AS total_bookings
FROM User u
LEFT JOIN Booking b
    ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY total_bookings DESC;

-- 2. Rank properties by total bookings using ROW_NUMBER()
SELECT 
    p.property_id,
    p.name,
    COUNT(b.booking_id) AS total_bookings,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS row_num
FROM Property p
LEFT JOIN Booking b
    ON p.property_id = b.property_id
GROUP BY p.property_id, p.name
ORDER BY row_num;

-- 3. Rank properties by total bookings using RANK()
SELECT 
    p.property_id,
    p.name,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS rank_num
FROM Property p
LEFT JOIN Booking b
    ON p.property_id = b.property_id
GROUP BY p.property_id, p.name
ORDER BY rank_num;