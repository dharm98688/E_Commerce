
CREATE DATABASE E_COMMERCE;

USE E_COMMERCE;

CREATE TABLE CUSTOMERS
(
	customer_id INT PRIMARY KEY,
	name VARCHAR(50),
	email VARCHAR(100)
)

CREATE TABLE PRODUCTS
(
	product_id INT PRIMARY KEY,
	product_name VARCHAR(100),
	price INT
)

CREATE TABLE ORDERS
(
	order_id INT PRIMARY KEY,
	customer_id INT,
	order_date DATE,
	FOREIGN KEY (customer_id) REFERENCES CUSTOMERS(customer_id)
)

CREATE TABLE ORDER_DETAILS
(
	Order_id INT,
	product_id INT,
	quantity INT,
	FOREIGN KEY (order_id) REFERENCES ORDERS(order_id),
	FOREIGN KEY (product_id) REFERENCES PRODUCTS(product_id)
)


INSERT INTO CUSTOMERS VALUES
(1,'RAJU','raju@gmail.com'),
(2,'Prajwal','prajwal@gmail.com'),
(3,'Neha','Neha@gmail.com'),
(4,'Manisha','manisha@gmail.com'),
(5,'ankit','ankit@gmail.com')

INSERT INTO Products VALUES
(101, 'Laptop', 60000.00),
(102, 'Mouse', 500.00),
(103, 'Keyboard', 800.00),
(104, 'Monitor', 12000.00),
(105, 'Pen Drive', 700.00);

INSERT INTO PRODUCTS VALUES 
(106, 'Smartwatch', 7000),
(107, 'Bluetooth Speaker', 4000);

INSERT INTO Orders VALUES
(1001, 1, '2024-06-10'),
(1002, 2, '2024-06-11'),
(1003, 1, '2024-06-13'),
(1004, 3, '2024-06-14');
INSERT INTO ORDERS VALUES
(1005,4,'2024-06-16'),
(1006,5,'2024-06-19'),
(1007,4,'2024-06-21')

select * from ORDERS
INSERT INTO Order_Details VALUES
(1001, 101, 1),   -- Laptop
(1001, 102, 2),   -- Mouse
(1002, 103, 1),   -- Keyboard
(1003, 104, 1),   -- Monitor
(1003, 105, 2),   -- Pen Drive
(1004, 102, 1);   -- Mouse

INSERT INTO ORDER_DETAILS VALUES
(1004, 103, 3),
(1006, 105, 3),
(1004, 102, 3),
(1007, 106, 3),
(1005, 102, 3);

select * from order_details

select * from PRODUCTS

--1. Show all customers and their ordered products.
SELECT 
C.name,
P.product_name,
OD.quantity
FROM CUSTOMERS C
JOIN ORDERS O ON C.customer_id=O.customer_id
JOIN ORDER_DETAILS OD ON OD.Order_id=O.order_id
JOIN PRODUCTS P ON OD.product_id=P.product_id

--2.Show order totals (price * quantity)
SELECT 
--	P.product_name,
	O.ORDER_ID,
	SUM(P.price * od.quantity) as TOTAL_AMOUNT
FROM ORDERS O
JOIN ORDER_DETAILS OD ON O.order_id=OD.Order_id
JOIN PRODUCTS P ON OD.product_id=P.product_id
GROUP BY O.order_id,P.product_name

--3.SHOW CUSTOMER-WISE TOTAL SPENDING
SELECT 
	C.name,
	SUM(P.price*OD.quantity) AS TOTAL_SPENT
FROM CUSTOMERS C
JOIN ORDERS O ON C.customer_id=O.customer_id
JOIN ORDER_DETAILS OD ON O.order_id=OD.Order_id
JOIN PRODUCTS P ON OD.product_id=P.product_id
GROUP BY C.name
ORDER BY TOTAL_SPENT DESC

--4.find the customers no orders
SELECT * FROM CUSTOMERS
WHERE CUSTOMER_ID NOT IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS)

--5.LIST ALL ORDERS FROM 13JUNE 2024
SELECT
	c.name,
	o.order_id
FROM ORDERS O
JOIN CUSTOMERS C ON O.customer_id=C.customer_id
WHERE O.order_date='2024-06-13'

--6.Most sold product by quantity
SELECT TOP 1
	P.product_name,
	SUM(OD.quantity) AS TOTAL_SOLD
FROM PRODUCTS P
JOIN ORDER_DETAILS OD ON P.product_id=OD.product_id
GROUP BY P.product_name
ORDER BY TOTAL_SOLD

--7.Top 2 customers by spend
SELECT TOP 2
	C.name,
	SUM(P.price*OD.quantity) AS TOTAL_SPEND
FROM CUSTOMERS C
JOIN ORDERS O ON O.customer_id=C.customer_id
JOIN ORDER_DETAILS OD ON O.order_id=OD.Order_id
JOIN PRODUCTS P ON OD.product_id=P.product_id
GROUP BY C.name
ORDER BY TOTAL_SPEND DESC

--8.Numbers of orders per customer
SELECT 
	C.name,
	COUNT(O.order_id) AS TOTAL_ORDERS
FROM CUSTOMERS C
JOIN ORDERS O ON C.customer_id=O.customer_id
GROUP BY C.name

--9.TOTAL REVENUE GENERATED
SELECT 
	SUM(P.price* quantity) AS TOTAL_REVENUE
FROM ORDER_DETAILS OD
JOIN PRODUCTS P ON OD.product_id=P.product_id

--10.LIST ALL PRODUCTS SOLD IN ORDER ID 1003
SELECT 
	P.product_name,
	OD.quantity
FROM ORDER_DETAILS OD
JOIN PRODUCTS P ON OD.product_id=P.product_id
WHERE OD.Order_id=1003;

--11.LATEST ORDER DATE PER CUSTOMER
SELECT TOP 1
	C.name,
	MAX(O.order_date) AS LAST_ORDER
FROM CUSTOMERS C
JOIN ORDERS O ON C.customer_id=O.customer_id
GROUP BY C.name
ORDER BY LAST_ORDER DESC

--12.ORDER TOTAL WITH CUSTOMER NAME
SELECT 
	O.order_id,
	C.name,
	SUM(P.price*OD.quantity) AS ORDER_TOTAL
FROM CUSTOMERS C
JOIN ORDERS O ON C.customer_id=O.customer_id
JOIN ORDER_DETAILS OD ON O.order_id=OD.Order_id
JOIN PRODUCTS P ON OD.product_id=P.product_id
GROUP BY O.order_id,C.name;

--13.AVERAGE ORDER VALUE
SELECT AVG(order_total) AS avg_order_value
FROM (
  SELECT o.order_id,
         SUM(p.price * od.quantity) AS order_total
  FROM Orders o
  JOIN Order_Details od ON o.order_id = od.order_id
  JOIN Products p ON p.product_id = od.product_id
  GROUP BY o.order_id
) AS order_summary;

--14.Product wise total quantity sold
SELECT  
	P.product_name,
	SUM(OD.quantity) AS TOTAL_QUANTITY
FROM PRODUCTS P
JOIN ORDER_DETAILS OD ON P.product_id=OD.product_id
GROUP BY P.product_name

--15.MONTH-REVENEU REPORT
SELECT
	FORMAT(O.ORDER_dATE,'yyyy-MM') AS month,
	SUM(p.price*od.quantity) as Revenue
FROM ORDERS O
JOIN ORDER_DETAILS OD ON O.order_id=OD.Order_id
JOIN PRODUCTS P ON OD.product_id=P.product_id
GROUP BY FORMAT(O.ORDER_dATE,'yyyy-MM')
ORDER BY FORMAT(O.ORDER_dATE,'yyyy-MM')