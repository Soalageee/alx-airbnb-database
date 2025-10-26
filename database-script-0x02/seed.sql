-- Airbnb Clone Sample Data
-- File: seed.sql
-- Directory: database-script-0x02

-- ========================================
-- 1. Users
-- ========================================
INSERT INTO Users (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
('11111111-1111-1111-1111-111111111111', 'Alice', 'Smith', 'alice@example.com', 'hash1', '08011111111', 'guest'),
('22222222-2222-2222-2222-222222222222', 'Bob', 'Johnson', 'bob@example.com', 'hash2', '08022222222', 'host'),
('33333333-3333-3333-3333-333333333333', 'Charlie', 'Lee', 'charlie@example.com', 'hash3', '08033333333', 'admin');

-- ========================================
-- 2. Properties
-- ========================================
INSERT INTO Properties (property_id, host_id, name, description, location, pricepernight)
VALUES
('aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1', '22222222-2222-2222-2222-222222222222', 'Cozy Apartment', 'A cozy apartment in downtown', 'Lagos', 100.00),
('aaaaaaa2-aaaa-aaaa-aaaa-aaaaaaaaaaa2', '22222222-2222-2222-2222-222222222222', 'Beach House', 'Beautiful beach house with sea view', 'Eko Atlantic', 200.00);

-- ========================================
-- 3. Bookings
-- ========================================
INSERT INTO Bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
('bbbbbbb1-bbbb-bbbb-bbbb-bbbbbbbbbbb1', 'aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1', '11111111-1111-1111-1111-111111111111', '2025-11-25', '2025-11-28', 300.00, 'confirmed'),
('bbbbbbb2-bbbb-bbbb-bbbb-bbbbbbbbbbb2', 'aaaaaaa2-aaaa-aaaa-aaaa-aaaaaaaaaaa2', '11111111-1111-1111-1111-111111111111', '2025-12-05', '2025-12-10', 1000.00, 'pending');

-- ========================================
-- 4. Payments
-- ========================================
INSERT INTO Payments (payment_id, booking_id, amount, payment_method)
VALUES
('ccccccc1-cccc-cccc-cccc-ccccccccccc1', 'bbbbbbb1-bbbb-bbbb-bbbb-bbbbbbbbbbb1', 300.00, 'credit_card');

-- ========================================
-- 5. Reviews
-- ========================================
INSERT INTO Reviews (review_id, property_id, user_id, rating, comment)
VALUES
('ddddddd1-dddd-dddd-dddd-ddddddddddd1', 'aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1', '11111111-1111-1111-1111-111111111111', 5, 'Great stay! Very clean and comfortable.'),
('ddddddd2-dddd-dddd-dddd-ddddddddddd2', 'aaaaaaa2-aaaa-aaaa-aaaa-aaaaaaaaaaa2', '11111111-1111-1111-1111-111111111111', 4, 'Amazing location, but a bit noisy.');

-- ========================================
-- 6. Messages
-- ========================================
INSERT INTO Messages (message_id, sender_id, recipient_id, message_body)
VALUES
('eeeeeee1-eeee-eeee-eeee-eeeeeeeeeee1', '11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222', 'Hi, I am interested in your property.'),
('eeeeeee2-eeee-eeee-eeee-eeeeeeeeeee2', '22222222-2222-2222-2222-222222222222', '11111111-1111-1111-1111-111111111111', 'Sure! It is available for your dates.');