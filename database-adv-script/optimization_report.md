# Query Optimization Report
Query Purpose: Retrieve all confirmed bookings along with user details, property details, and payment details.

## 1. Original Query (Before Optimization)

```sql
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
```

### Issues Identified:

- Selected all columns from all tables, increasing I/O and memory usage.

- No filtering (WHERE) was applied; all rows were read.

- Sequential scans (Seq Scan) on small tables were fine, but for larger tables, these would become inefficient.

- Hash joins were used, which are memory-intensive for larger datasets.

---

## 2. Optimization Steps Taken

- Added filtering for confirmed bookings using ``` WHERE b.status = 'confirmed'.``` which reduces the number of rows processed and enables potential use of indexes on status.

- Selected only necessary columns instead of all columns which reduces memory usage and I/O cost.

- Kept essential joins for related tables (Users, Properties, Payments) only.

- Avoided unnecessary joins to tables not required for this report.

- Verified indexes on join columns:

```sql
u.user_id (primary key)

b.user_id (foreign key)

b.property_id (foreign key)

p.booking_id (foreign key, unique)
```

- Used Nested Loop joins where row count is low and filtering reduces the dataset, which is more efficient than building large hash tables.

---

## 3. Optimized Query

```sql 
SELECT
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    b.booking_id,
    b.start_date,
    b.end_date,
    pty.name AS property_name,
    pty.location,
    p.payment_id,
    p.amount,
    p.payment_method,
    p.payment_date
FROM Bookings b
JOIN Users u ON b.user_id = u.user_id
JOIN Properties pty ON b.property_id = pty.property_id
JOIN Payments p ON b.booking_id = p.booking_id
WHERE b.status = 'confirmed';
```

---

## 4. EXPLAIN ANALYZE Result (Optimized Query)
```
Nested Loop  (cost=0.14..11.55 rows=1 width=544) (actual time=0.069..0.082 rows=2 loops=1)
  Join Filter: (b.booking_id = p.booking_id)
  Rows Removed by Join Filter: 1
  -> Nested Loop  (cost=0.14..10.50 rows=1 width=470) (actual time=0.052..0.063 rows=2 loops=1)
        Join Filter: (b.property_id = pty.property_id)
        Rows Removed by Join Filter: 2
        -> Nested Loop  (cost=0.14..9.44 rows=1 width=268) (actual time=0.045..0.052 rows=2 loops=1)
              -> Seq Scan on bookings b  (cost=0.00..1.05 rows=1 width=48) (actual time=0.018..0.020 rows=2 loops=1)
                    Filter: ((status)::text = 'confirmed'::text)
                    Rows Removed by Filter: 2
              -> Index Scan using users_pkey on users u  (cost=0.14..8.16 rows=1 width=252) (actual time=0.013..0.013 rows=1 loops=2)
                    Index Cond: (user_id = b.user_id)
        -> Seq Scan on properties pty  (cost=0.00..1.03 rows=3 width=234) (actual time=0.003..0.003 rows=2 loops=2)
  -> Seq Scan on payments p  (cost=0.00..1.02 rows=2 width=90) (actual time=0.008..0.008 rows=2 loops=2)
Planning Time: 9.815 ms
Execution Time: 0.288 ms
```

---

## 5. Performance Analysis

- Execution Time: 0.288 ms (very fast for small dataset).

- Nested Loop joins efficiently handle the small number of rows.

- Seq Scans on small tables are acceptable; index scans used for users.user_id.

- Filtering on ```status = 'confirmed'``` reduced unnecessary row processing.

- Rows Removed by Filter indicates that non-confirmed bookings were effectively excluded early.

### Observation:

Currently, performance is excellent for the small dataset.

As table sizes grow, Seq Scans on bookings, properties, and payments could become a bottleneck.

Ensuring indexes on bookings.status and all join columns will make the query scale efficiently.

---

## Conclusion:

The query is now optimized for current data size, with minimal unnecessary processing, filtered results, and proper use of indexes. The execution plan shows very low cost and time, and the structure is scalable for future growth with recommended indexing.