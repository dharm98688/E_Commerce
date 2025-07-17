# 🛒 E-Commerce SQL Project

This project simulates a simple e-commerce database system using SQL. It includes key components such as customers, products, orders, and order details — designed to help understand relational database design, normalization, and data querying.

---

## 📁 Project Structure


---

## 🧱 Database Design

The project follows a **normalized structure** (1NF → 2NF → 3NF) and includes the following tables:

### 1. `Customers`
- `customer_id` (PK)
- `name`
- `email`

### 2. `Products`
- `product_id` (PK)
- `product_name`
- `price`

### 3. `Orders`
- `order_id` (PK)
- `customer_id` (FK)
- `order_date`

### 4. `Order_Details`
- `order_detail_id` (PK) *(optional)*
- `order_id` (FK)
- `product_id` (FK)
- `quantity`

---

## 🔎 Sample Queries Included

- 📆 Monthly sales summary
- 💰 Average order value
- 🏆 Top-selling products
- 👥 Customer purchase history
- 🔗 INNER JOINs, GROUP BY, aggregate functions

---

## 🚀 How to Run

1. Open SQL Server Management Studio (SSMS)
2. Run `create_tables.sql` to set up the schema
3. Run `insert_data.sql` to insert sample data
4. Run `queries.sql` to test and explore

---

## 🎯 Learning Objectives

- ✅ Understand relational database structure
- ✅ Practice SQL JOINs, aggregation, filtering
- ✅ Learn normalization and avoid data redundancy
- ✅ Write interview-style SQL queries

---

## 🧠 Concepts Practiced

- SQL Basics: `CREATE`, `INSERT`, `SELECT`
- Relationships: `FOREIGN KEY`, `JOIN`
- Aggregates: `SUM()`, `AVG()`, `COUNT()`
- Formatting: `FORMAT()` for dates
- GROUP BY and HAVING clauses


