# Airbnb Clone Database Requirements

## Overview
This document defines the database entities, attributes, and relationships for the Airbnb Clone project. The database is designed to manage users, properties, bookings, payments, reviews, and messaging between users while ensuring data integrity and efficient querying.

## Entities and Attributes

### 1. User
Represents individuals using the platform as guests, hosts, or admins.
- `user_id` (PK, UUID, Indexed)
- `first_name` (VARCHAR, NOT NULL)
- `last_name` (VARCHAR, NOT NULL)
- `email` (VARCHAR, UNIQUE, NOT NULL)
- `password_hash` (VARCHAR, NOT NULL)
- `phone_number` (VARCHAR, NULL)
- `role` (ENUM: guest, host, admin, NOT NULL)
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

### 2. Property
Represents listings available for booking.
- `property_id` (PK, UUID, Indexed)
- `host_id` (FK → User.user_id)
- `name` (VARCHAR, NOT NULL)
- `description` (TEXT, NOT NULL)
- `location` (VARCHAR, NOT NULL)
- `pricepernight` (DECIMAL, NOT NULL)
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- `updated_at` (TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP)

### 3. Booking
Represents reservations made by users for properties.
- `booking_id` (PK, UUID, Indexed)
- `property_id` (FK → Property.property_id)
- `user_id` (FK → User.user_id)
- `start_date` (DATE, NOT NULL)
- `end_date` (DATE, NOT NULL)
- `total_price` (DECIMAL, NOT NULL)
- `status` (ENUM: pending, confirmed, canceled, NOT NULL)
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

### 4. Payment
Tracks transactions for bookings.
- `payment_id` (PK, UUID, Indexed)
- `booking_id` (FK → Booking.booking_id)
- `amount` (DECIMAL, NOT NULL)
- `payment_date` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- `payment_method` (ENUM: credit_card, paypal, stripe, NOT NULL)

### 5. Review
Stores feedback from users for properties.
- `review_id` (PK, UUID, Indexed)
- `property_id` (FK → Property.property_id)
- `user_id` (FK → User.user_id)
- `rating` (INTEGER, 1–5, NOT NULL)
- `comment` (TEXT, NOT NULL)
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

### 6. Message
Manages messages exchanged between users.
- `message_id` (PK, UUID, Indexed)
- `sender_id` (FK → User.user_id)
- `recipient_id` (FK → User.user_id)
- `message_body` (TEXT, NOT NULL)
- `sent_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

## Relationships
- **User → Property:** One-to-Many (A host can have multiple properties)  
- **User → Booking:** One-to-Many (A guest can make multiple bookings)  
- **User → Review:** One-to-Many (A user can leave multiple reviews)  
- **User → Message:** One-to-Many (A user can send and receive multiple messages)  
- **Property → Booking:** One-to-Many (A property can have multiple bookings)  
- **Property → Review:** One-to-Many (A property can have multiple reviews)  
- **Booking → Payment:** One-to-One (Each booking has one payment)  

## Indexing and Constraints
- Primary keys are automatically indexed.  
- Additional indexes: `email` (User), `property_id` (Property, Booking), `booking_id` (Booking, Payment).  
- Foreign keys enforce valid relationships.  
- ENUM constraints for `role`, `status`, and `payment_method`.  
- Check constraint ensures `rating` is between 1 and 5.  
- Non-null constraints on essential attributes maintain data integrity.