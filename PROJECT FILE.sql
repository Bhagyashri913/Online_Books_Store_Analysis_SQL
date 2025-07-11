-- create Database
create Database OnlineBookstore;
USE OnlineBookstore;
-- Create Table
DROP TABLE IF EXISTS BOOKS;
CREATE TABLE BOOKS(
BOOK_ID serial PRIMARY KEY,
TITLE VARCHAR(100),
AUTHOR varchar(100),
GENDER varchar(50),
PUBLISHED_YEAR INT,
PRICE NUMERIC(10,2),
STOCK INT
);

CREATE TABLE CUSTOMER(
CUSTOMER_ID SERIAL PRIMARY KEY,
NAME varchar(100),
EMAIL varchar(100),
PHONE varchar(15),
CITY varchar(50),
COUNTRY varchar(150)
);

CREATE TABLE ORDERS(
ORDER_ID SERIAL PRIMARY KEY,
CUSTOMER_ID  INT REFERENCES CUSTOMER(CUSTOMER_ID),
BOOK_ID INT REFERENCES BOOKS(BOOKS_ID),
OREDER_DATE DATE,
QUANTITY INT,
TOTAL_AMOUNT NUMERIC(10,2)
);
SELECT * FROM BOOKS;
SELECT * FROM CUSTOMER;
SELECT * FROM ORDERS;

-- 1) RETRIEVE ALL BOOKS IN THE 'FICTION' GENRE:
SELECT * FROM BOOKS WHERE GENDER = "FICTION";

-- 2) FIND BOOKS PUBLISHED AFTER THE YEAR 1950:
SELECT * FROM BOOKS WHERE Published_Year >1950;

-- 3) LIST ALL CUSTOMERS FROMM THE CANADA:
SELECT * FROM Customers
 WHERE Country= "Canada";
 
 -- 4) SHOW ORDERS PLACED IN NOVEMBER 2023:
 SELECT * FROM ORDERS
 WHERE OREDER_DATE BETWEEN '2023-11-01' AND '2023-11-30';
 
 -- 5) RETRIEVE THE TOTAL STOCK OF BOOKS AVAILABEL:
 SELECT SUM(STOCK) AS TOTAL_STOCK FROM BOOKS;
 
 -- 6) FIND THE DETAILS OF THE MOST EXPENSIVE BOOK:
 SELECT * FROM BOOKS ORDER BY PRICE DESC LIMIT 1 ;
 
 -- 7) SHOW ALL CUTOMERS WHO ORDERED MORE THAN 1 QUANTITY OF A BOOK:
 SELECT * FROM ORDERS WHERE QUANTITY >1;
 
 -- 8) RETRIEVE ALL ORDERS WHERE THE TOTAL AMOUNT EXCEEDS $20:
 SELECT * FROM ORDERS WHERE TOTAL_AMOUNT>20;
 
 -- 9) LIST ALL GENRES AVAILABLE IN THE BOOKS TABLE:
 SELECT DISTINCT GENDER FROM BOOKS;
 
 -- 10) FIND THE BOOK WITH THE LOWEST STOCK:
 SELECT * FROM BOOKS ORDER BY STOCK LIMIT 1;
 
 -- 11) CALCULATE THE TOTAL REVENUE GENERATED FROM ALL ORDERS:
 SELECT SUM(TOTAL_AMOUNT) AS REVENUE FROM ORDERS;
 
 -- 12) RETRIEVE THE TOTAL NUMBER OF BOOKS SOLD FOR EACH GENRE:
 SELECT B.GENDER,SUM(O.QUANTITY) AS TOTAL_BOOKS_SOLD FROM ORDERS O 
 JOIN BOOKS B ON O.BOOK_ID = B.BOOK_ID GROUP BY B.GENDER;
 
 -- 13) FIND THE AVERAGE PRICE OF BOOKS IN THE "FANTASY" GENRE:
 SELECT AVG(PRICE) AS AVGERAGE_PRICE FROM BOOKS
 WHERE GENDER = "FANTASY";
 
 -- 14) LIST CUSTOMERS WHO HAVE PLACED AT LEAST 2 ORDERS:
 SELECT CUSTOMER_ID,COUNT(ORDER_ID) AS ORDER_COUNT FROM ORDERS GROUP BY CUSTOMER_ID HAVING
 COUNT(ORDER_ID)>=2;
 
 -- 15)  FIND THE MOST FREQUENTLY ORDERED BOOK:
 SELECT O.BOOK_ID, B.TITLE, COUNT(O.ORDER_ID) AS ORDER_COUNT FROM ORDERS O 
 JOIN BOOKS B ON O.BOOK_ID=B.BOOK_ID
 GROUP BY O.BOOK_ID, B.TITLE
 ORDER BY  ORDER_COUNT DESC LIMIT 1;
 
 -- 16) SHOW THE TOP 3 MOST EXPENSIVE BOOKS OF 'FANTASY' GENRE:
 SELECT * FROM BOOKS
 WHERE GENDER = 'FANTASY' ORDER BY PRICE DESC LIMIT 3;
 
 -- 17) RETRUECE THE TOTAL QUANTITY OF BOOKS SOLD BT EACH AUTHOR:
 SELECT B.AUTHOR,SUM(O.QUANTITY) AS TOTAL_BOOKS_SOLD FROM ORDERS O 
 JOIN BOOKS B ON O.BOOK_ID = B.BOOK_ID
 GROUP BY B.AUTHOR;
 
 -- 18) LIST THE CITITES WHERE CUSTOMERS WHO SPENT OVER $30 ARE LOCATED:
 SELECT DISTINCT C.CITY,TOTAL_AMOUNT
 FROM ORDERS O 
 JOIN CUSTOMER C ON O.CUSTOMER_ID = C.CUSTOMER_ID
 WHERE O.TOTAL_AMOUNT > 30;
 
 -- 19) FIND THE CUSTOMERS WHO SPENT THE MOST ON ORDERS:
 SELECT C.CUSTOMER_ID,C.NAME,SUM(O.TOTAL_AMOUNT) AS TOTAL_SPENT
 FROM ORDERS O 
 JOIN CUSTOMER C ON C.CUSTOMER_ID = C.CUSTOMER_ID
 GROUP BY C.CUSTOMER_ID, C.NAME
 ORDER BY TOTAL_SPENT DESC;
 
 
 -- 20 CALCULATE THE STOCK REMAINING AFTER FULFILLING ALL ORDERS:
 SELECT B.BOOK_ID, B.TITLE, B.STOCK, COALESCE(sum(QUANTITY),0) AS ORDER_QUANTITY,
  B.STOCK, COALESCE(sum(QUANTITY),0) AS REMAINING_QUANTITY
 FROM BOOKS B
 LEFT JOIN ORDERS O ON B.BOOK_ID = O.BOOK_ID 
 GROUP BY B.BOOK_ID;
 
 
 




