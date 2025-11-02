# Complex SQL Queries 

---

## **1. Joins: Objective**
This task demonstrates mastery of SQL joins in the **Airbnb Database Schema**, using different join types to retrieve relational data between users, properties, bookings, and reviews.

### i. INNER JOIN — Bookings with Users
**Description:**  
Retrieves all bookings along with details of the users who made them.

**Query:**
```sql
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
```

### ii. LEFT JOIN — Properties with Reviews
**Description:**
Retrieves all properties, including those without reviews.

**Query:**
```sql
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
```

### iii. FULL OUTER JOIN — All Users and All Bookings
**Description:**
Retrieves all users and all bookings, including:

- Users with no bookings

- Bookings not linked to a user

Since MySQL/MariaDB does not support FULL OUTER JOIN natively, we simulate it using a UNION of LEFT and RIGHT joins.

**Query:**
```sql
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
```

### Files Included

- `joins_queries.sql` — Contains the SQL join queries.

### Directory Structure
```pgsql
alx-airbnb-database/
└── database-adv-script/
    ├── joins_queries.sql
    └── README.md
```

---

## **2. Subqueries: Objective**
The goal of this task is to practice writing **correlated and non-correlated subqueries** using the Airbnb clone database schema.

### i. Non-Correlated Subquery
**Description:** 

   - Finds all properties where the **average rating** is greater than 4.0.  
   - This query uses a subquery that does **not** reference the outer query.

**Query**
```sql
SELECT *
FROM Property
WHERE property_id IN (
    SELECT property_id
    FROM Review
    GROUP BY property_id
    HAVING AVG(rating) > 4.0
);
```

### ii. Correlated Subquery  
**Description:** 

   - Finds all users who have made **more than 3 bookings**.  
   - This query uses a subquery that **references the outer query**.

**Query**
```sql
SELECT *
FROM User u
WHERE (
    SELECT COUNT(*)
    FROM Booking b
    WHERE b.user_id = u.user_id
) > 3;
```

### Files Included
- The SQL queries are stored in the file:  
`subqueries.sql`

### Directory Structure
```pgsql
alx-airbnb-database/
└── database-adv-script/
    ├── subqueries.sql
    └── README.md
```

---

## 3. Aggregations and Window Functions: Objective
Here, SQL aggregation and window functions are used to analyze the Airbnb clone data.

### i. Total Bookings per User
**Description:**
   - Use `COUNT()` and `GROUP BY` to find the total number of bookings made by each user.

**Query**
```sql
SELECT u.user_id, u.first_name, u.last_name, COUNT(b.booking_id) AS total_bookings
FROM User u
LEFT JOIN Booking b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY total_bookings DESC;
```

### ii. Rank Properties by Bookings
**Description:**
   - Use a window function (`RANK()`, `ROW_NUMBER()`) to rank properties based on the total bookings they have received.

**Query**
```sql
SELECT p.property_id, p.name, COUNT(b.booking_id) AS total_bookings,
       RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM Property p
LEFT JOIN Booking b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name
ORDER BY booking_rank;
```

### Files Included
- The SQL queries are stored in the file: `aggregations_and_window_functions.sql`

### Directory Structure
```pgsql
alx-airbnb-database/
└── database-adv-script/
    ├── subqueries.sql
    └── README.md
```

---