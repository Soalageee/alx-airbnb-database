-- Airbnb Clone Sample Data
-- File: seed.sql
-- Directory: database-script-0x02

-- ========================================
-- 1. Users
-- ========================================
INSERT INTO Users (first_name, last_name, email, password_hash, phone_number, role)
VALUES
('Alice', 'Smith', 'alice@example.com', 'hash1', '08011111111', 'host'),
('Bob', 'Johnson', 'bob@example.com', 'hash2', '08022222222', 'host'),
('Charlie', 'Lee', 'charlie@example.com', 'hash3', '08033333333', 'admin'),
('John', 'Doe', 'john@example.com', 'hash4', '08044444444', 'guest'),
('Jane', 'Doe', 'jane@example.com', 'hash5', '08055555555', 'guest');

-- ========================================
-- 2. Properties
-- ========================================
INSERT INTO Properties (host_id, name, description, location, pricepernight)
VALUES
(
    (SELECT user_id FROM Users WHERE email = 'bob@example.com'),
    'Cozy Apartment',
    'A cozy apartment in downtown',
    'Lagos',
    100.00
),
(
    (SELECT user_id FROM Users WHERE email = 'bob@example.com'),
    'Beach House',
    'Beautiful beach house with sea view',
    'Eko Atlantic',
    200.00
),
(
    (SELECT user_id FROM Users WHERE email = 'alice@example.com'),
    'Loft Inn',
    'Simple loft appartment with lake view',
    'Golf Estate',
    300.00
);

-- ========================================
-- 3. Bookings
-- ========================================
INSERT INTO Bookings (property_id, user_id, start_date, end_date, total_price, status)
VALUES
(
    (SELECT property_id FROM Properties WHERE Name = 'Cozy Apartment'),
    (SELECT user_id FROM Users WHERE email = 'john@example.com'),
    '2025-11-25',
    '2025-11-28',
    300.00,
    'confirmed'
),
(
    (SELECT property_id FROM Properties WHERE Name = 'Cozy Apartment'),
    (SELECT user_id FROM Users WHERE email = 'jane@example.com'),
    '2025-11-28',
    '2025-11-30',
    200.00,
    'pending'
),
(
    (SELECT property_id FROM Properties WHERE Name = 'Loft Inn'),
    (SELECT user_id FROM Users WHERE email = 'jane@example.com'),
    '2025-12-25',
    '2025-12-30',
    1500.00,
    'confirmed'
),
(
    (SELECT property_id FROM Properties WHERE Name = 'Beach House'),
    (SELECT user_id FROM Users WHERE email = 'john@example.com'),
    '2025-12-25',
    '2025-12-30',
    1500.00,
    'canceled'
);

-- ========================================
-- 4. Payments
-- ========================================
INSERT INTO Payments (booking_id, amount, payment_method)
VALUES
( (SELECT booking_id FROM Bookings 
    WHERE property_id = (SELECT property_id FROM Properties WHERE name = 'Cozy Apartment') 
    AND start_date = '2025-11-25'), 
  300.00,
  'credit_card'
),
( (SELECT booking_id FROM Bookings 
    WHERE property_id = (SELECT property_id FROM Properties WHERE name = 'Loft Inn') 
    AND start_date = '2025-12-25'), 
  1500.00,
  'paypal'
);

-- ========================================
-- 5. Reviews
-- ========================================
INSERT INTO Reviews (property_id, user_id, rating, comment)
VALUES
( 
    (SELECT property_id FROM Properties WHERE Name = 'Cozy Apartment'),
    (SELECT user_id FROM Users WHERE email = 'john@example.com'),
    5,
    'Great stay! Very clean and comfortable.'
),
( 
    (SELECT property_id FROM Properties WHERE Name = 'Loft Inn'),
    (SELECT user_id FROM Users WHERE email = 'jane@example.com'),
    4,
    'Amazing location, but a bit noisy.'
);

-- ========================================
-- 6. Messages
-- ========================================
INSERT INTO Messages (sender_id, recipient_id, message_body)
VALUES
(
    (SELECT user_id FROM Users WHERE email = 'jane@example.com'),
    (SELECT user_id FROM Users WHERE email = 'alice@example.com'),
    'Hi, I am interested in your property.'
),
(
    (SELECT user_id FROM Users WHERE email = 'alice@example.com'),
    (SELECT user_id FROM Users WHERE email = 'jane@example.com'),
    'Sure! It is available for your dates.'
);