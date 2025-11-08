-- PERFORMANCE ANALYSIS
EXPLAIN ANALYZE
SELECT u.user_id, COUNT(b.booking_id) 
FROM Users u
LEFT JOIN Bookings b ON u.user_id = b.user_id
GROUP BY u.user_id;


-- INDEXES ON USERS TABLE 
CREATE INDEX idx_user_email ON Users(email);

-- INDEXES ON PROPERTIES TABLE 
CREATE INDEX idx_host_id ON Properties(host_id);
CREATE INDEX idx_location ON Properties(location);

-- INDEXES ON BOOKINGS TABLE 
CREATE INDEX idx_booking_property_id ON Bookings(property_id);
CREATE INDEX idx_booking_user_id ON Bookings(user_id);
CREATE INDEX idx_booking_status ON Bookings(status);

-- INDEXES ON PAYMENTS TABLE 
CREATE INDEX idx_payment_booking_id ON Payments(booking_id);
CREATE INDEX idx_payment_method ON Payments(payment_method);

-- INDEXES ON REVIEWS TABLE 
CREATE INDEX idx_review_property_id ON Reviews(property_id);
CREATE INDEX idx_review_user_id ON Reviews(user_id);
CREATE INDEX idx_rating ON Reviews(rating);

-- INDEXES ON MESSAGES TABLE
CREATE INDEX idx_message_sender_id ON Messages(sender_id);
CREATE INDEX idx_message_recipient_id ON Messages(recipient_id);