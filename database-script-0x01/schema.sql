-- Airbnb Clone Database Schema
-- File: schema.sql
-- Directory: database-script-0x01

-- ========================================
-- 1. User Table
-- ========================================
CREATE TABLE IF NOT EXISTS Users (
    user_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role VARCHAR(10) NOT NULL CHECK (role IN ('guest', 'host', 'admin')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_user_email ON Users(email);

-- ========================================
-- 2. Property Table
-- ========================================
CREATE TABLE IF NOT EXISTS Properties (
    property_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    host_id UUID NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(150) NOT NULL,
    pricepernight DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (host_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  -- Whenever a row changes, set 'updated_at' to the current time
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create a trigger that runs the function before any update
CREATE TRIGGER set_timestamp
BEFORE UPDATE ON Properties
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

CREATE INDEX idx_host_id ON Properties(host_id);
CREATE INDEX idx_location ON Properties(location);

-- ========================================
-- 3. Booking Table
-- ========================================
CREATE TABLE IF NOT EXISTS Bookings (
    booking_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status VARCHAR(10) NOT NULL CHECK (status IN ('pending', 'confirmed', 'canceled')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Properties(property_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE INDEX idx_booking_property_id ON Bookings(property_id);
CREATE INDEX idx_booking_user_id ON Bookings(user_id);
CREATE INDEX idx_booking_status ON Bookings(status);

-- ========================================
-- 4. Payment Table
-- ========================================
CREATE TABLE IF NOT EXISTS Payments (
    payment_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    booking_id UUID NOT NULL UNIQUE,
    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(20) NOT NULL CHECK (payment_method IN ('credit_card', 'paypal', 'stripe')),
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id) ON DELETE CASCADE
);

CREATE INDEX idx_payment_booking_id ON Payments(booking_id);
CREATE INDEX idx_payment_method ON Payments(payment_method);

-- ========================================
-- 5. Review Table
-- ========================================
CREATE TABLE IF NOT EXISTS Reviews (
    review_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Properties(property_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE INDEX idx_review_property_id ON Reviews(property_id);
CREATE INDEX idx_review_user_id ON Reviews(user_id);
CREATE INDEX idx_rating ON Reviews(rating);

-- ========================================
-- 6. Message Table
-- ========================================
CREATE TABLE IF NOT EXISTS Messages (
    message_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    sender_id UUID NOT NULL,
    recipient_id UUID NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (recipient_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE INDEX idx_message_sender_id ON Messages(sender_id);
CREATE INDEX idx_message_recipient_id ON Messages(recipient_id);