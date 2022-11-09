# One to Many                                               
                                                -- EXAMPLE OF DB INTERRELATED
                                                            --reviews
-- Relation Basics                                  order               authors
      --1. One to One Relationship                              BOOKS
      --2. One to Many Relationship                   genres            versions
      --3. Many to Many Relationship                        customers                  

-- 1:MANY RELATIONSHIP
--CUSTOMERS - ORDERS TABLES, ONE CUSTOMER CAN ORDER MULTIPLE THINGS SO 1:MANY

#We Want to Store:
      --A Customer's First and Last Name
      --A Customer's Email 
      --The Date Of The Purchase
      --The Prıce Of The Order

#For Interraleted tables:
#      CUSTOMERS                                 ORDERS
#        customer_id PRIMARY KEY           order_id PRIMARY KEY
#        first_name                        order_date
#        last_name                         amount
#        email                             customer_id FOREIGN KEY 

#                  customers.customer_id = orders.customer_id

--LET'S GET CODING!
CREATE DATABASE Customers_and_orders
USE Customers_and_orders

CREATE TABLE customers
(
      id INT PRIMARY KEY AUTO_INCREMENT,
      first_name VARCHAR(100),
      last_name VARCHAR(100),
      email VARCHAR(100)
)

CREATE TABLE orders
(
      id INT AUTO_INCREMENT PRIMARY KEY,
      order_date DATE,
      amount DECIMAL(8,2),
      customer_id INT,
      FOREIGN KEY(customer_id) REFERENCES customers(id)
     #Association: orders.customer_id references customer.id
      ON DELETE CASCADE #Whenever a customer is deleted, the order of the customer will be deleted.
)


INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016/02/10', 99.99, 1),
       ('2017/11/11', 35.50, 1),
       ('2014/12/12', 800.67, 2),
       ('2015/01/03', 12.50, 2),
       ('1999/04/11', 450.25, 5);

#INSERT INTO orders (order_date,amount,customer_id)
#VALUES("2016/06/06", 33.54, 98) This code will give you an error because "98" id is not exist in customer table

SELECT * FROM orders WHERE customer_id = (
      SELECT id FROM Customers
      WHERE last_name = "George"
)

#JOIN

-- IMPLICIT INNER JOIN
SELECT first_name,last_name,order_date,amount 
FROM customers, orders 
      WHERE customers.id=orders.customer_id

-- EXPLICIT INENR JOIN
SELECT * FROM customers
JOIN orders
      ON customers.id = orders.customer_id


SELECT 
      first_name,
      last_name,
      order_date,
      SUM(amount) AS total_spent
FROM customers
JOIN orders
      ON customers.id = orders.customer_id
GROUP BY orders.customer_id
ORDER BY order_date

# LEFT JOIN

SELECT * FROM customers
LEFT JOIN orders
      on customers.id = orders.customer_id

# Many:Many
# Books <-> Authors
# Blog Post <-> Tags
# Student <-> Classes                                     UNION REVİEWS
#Imagine we're building a tv show reviewing app TV Data <-------> Reviewers Data

#Reviewers                    Series                  Reviewer (UNION)
#     id                          id                      rating
#     first_name                  title                   series_id
#     last_name                   released_year           reviewer_id
#                                 genre  

CREATE DATABASE tv_reviewers_app
USE tv_reviewers_app

CREATE TABLE reviewers
(
      id INT PRIMARY KEY AUTO_INCREMENT,
      first_name VARCHAR(100),
      last_name VARCHAR(100)
)

CREATE TABLE series
(
      id INT PRIMARY KEY AUTO_INCREMENT,
      title VARCHAR(100),
      released_year YEAR(4),
      genre VARCHAR(100)
)

INSERT INTO series (title, released_year, genre) VALUES
    ('Archer', 2009, 'Animation'),
    ('Arrested Development', 2003, 'Comedy'),
    ("Bob's Burgers", 2011, 'Animation'),
    ('Bojack Horseman', 2014, 'Animation'),
    ("Breaking Bad", 2008, 'Drama'),
    ('Curb Your Enthusiasm', 2000, 'Comedy'),
    ("Fargo", 2014, 'Drama'),
    ('Freaks and Geeks', 1999, 'Comedy'),
    ('General Hospital', 1963, 'Drama'),
    ('Halt and Catch Fire', 2014, 'Drama'),
    ('Malcolm In The Middle', 2000, 'Comedy'),
    ('Pushing Daisies', 2007, 'Comedy'),
    ('Seinfeld', 1989, 'Comedy'),
    ('Stranger Things', 2016, 'Drama');

INSERT INTO reviewers (first_name, last_name) VALUES
    ('Thomas', 'Stoneman'),
    ('Wyatt', 'Skaggs'),
    ('Kimbra', 'Masters'),
    ('Domingo', 'Cortes'),
    ('Colt', 'Steele'),
    ('Pinkie', 'Petit'),
    ('Marlon', 'Crafford');

CREATE TABLE reviews
(
      id INT AUTO_INCREMENT PRIMARY KEY,
      rating DECIMAL(2,1),
      series_id INT,
      reviewer_id INT,
      FOREIGN KEY(series_id) REFERENCES series(id),
      FOREIGN KEY(reviewer_id) REFERENCES reviewers(id)
)

INSERT INTO reviews(series_id, reviewer_id, rating) VALUES
    (1,1,8.0),(1,2,7.5),(1,3,8.5),(1,4,7.7),(1,5,8.9),
    (2,1,8.1),(2,4,6.0),(2,3,8.0),(2,6,8.4),(2,5,9.9),
    (3,1,7.0),(3,6,7.5),(3,4,8.0),(3,3,7.1),(3,5,8.0),
    (4,1,7.5),(4,3,7.8),(4,4,8.3),(4,2,7.6),(4,5,8.5),
    (5,1,9.5),(5,3,9.0),(5,4,9.1),(5,2,9.3),(5,5,9.9),
    (6,2,6.5),(6,3,7.8),(6,4,8.8),(6,2,8.4),(6,5,9.1),
    (7,2,9.1),(7,5,9.7),
    (8,4,8.5),(8,2,7.8),(8,6,8.8),(8,5,9.3),
    (9,2,5.5),(9,3,6.8),(9,4,5.8),(9,6,4.3),(9,5,4.5),
    (10,5,9.9),
    (13,3,8.0),(13,4,7.2),
    (14,2,8.5),(14,3,8.9),(14,4,8.9);

SELECT * FROM reviews

#Let's do some stuff!


#Challenge 1
SELECT
     title,rating
FROM series
JOIN reviews
      ON reviews.id = series.id

#Challenge 2
SELECT
     title,
     AVG(rating) AS "Average Rating Per Title"
FROM series
JOIN reviews
      ON reviews.id = series.id
GROUP BY title 
ORDER BY rating DESC

#Challenge 3
SELECT 
      first_name,
      last_name,
      rating
FROM reviewers
LEFT JOIN reviews
      ON reviews.reviewer_id = reviewers.id

#Challenge 3
SELECT title,
      rating AS unreviewed_series
FROM series
LEFT JOIN reviews
      ON series.id = reviews.series_id
WHERE rating IS NULL

#CHALLENGE 4
SELECT 
      genre,
      #There are many decimal numbers!!
      ROUND(
      AVG(rating),2 
      )
       AS 'Average Rating Per Genre'
FROM series
JOIN reviews
      ON series_id = reviews.series_id
GROUP BY genre 

#CHALLENGE 5
SELECT 
      first_name AS "First Name",
      last_name AS "Last Name",
      COUNT(rating) AS 'COUNT',
      MIN(rating) AS "MIN",
      MAX(rating) AS 'MAX',
      AVG(rating) as 'AVG',
            CASE 
            WHEN COUNT(rating) = 0 OR rating IS NULL THEN "INACTIVE"
            ELSE 'ACTIVE'
      END AS "STATUS"
FROM reviewers
LEFT JOIN reviews
      ON reviews.reviewer_id = reviewers.id
GROUP BY first_name,last_name

