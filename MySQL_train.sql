CREATE DATABASE hello_world_db;
# Also you can delete a database: DROP DATABASE <name>
DROP DATABASE sys;

#To use the database
CREATE DATABASE dog_walking_app;
USE dog_walking_app;

SELECT database() #To see which database I am currently using
SHOW DATABASES;

#--------------------------------------------------------------------------------------------------------------------------------

#Database is just a bunch of TABLES
#For example:

#THE CATS TABLE!
# Must be Text    Must be Text      Must be Integer
#l NAME            BREED             AGE   I<-- HEADERS
#l Blue             Persian           1    I<--    ROWS
#l Rocket           Scottish          3    I<--    ROWS
#l Monty            Tabby             10   I<--    ROWS

#CREATE TABLE <table name>
# (
      #column_name data_type,
      #column_name data_type
#)

CREATE DATABASE cate_app
USE cate_app

CREATE TABLE cats(
      first_name VARCHAR(15),
      age INT 
)

#We create a cats table but how do we know it worked?
SHOW TABLES
SHOW COLUMNS FROM cats

#Deleting Tables
DROP TABLE cats;
#--------------------------------------------------------------------------------------------------------------------------------
#ACTIVITY:  CREATE A PASTRIES TABLE WHICH HAS TWO COLUMNS NAMED QUANTITY AND NAME.

SHOW DATABASES
USE db_sql_tutorial
CREATE TABLE Pastries(
      f_name VARCHAR(50),
      quantity VARCHAR(50)
)
DESC Pastries
DROP TABLE Pastries
#---------------------------------------------------------------------------------------------------------------------------------

#INSERT

SHOW TABLES

CREATE TABLE cats(
      f_name VARCHAR(50) NOT NULL,
      age INT DEFAULT 99 #Default value 
)

INSERT INTO cats(f_name,age)
VALUES('Bıdık',7)

INSERT INTO cats(f_name,age)
VALUES ('Saru',5),
      ('Taylor',4)

#So, how do we know it worked?
SELECT * FROM cats

#------------------------------------------------------------------------------------------------------------------------------

#Imagine you have three values which has the exact same name and age. How do we know who is who?

INSERT INTO cats(f_name,age)
VALUES('Bıdık',7)
INSERT INTO cats(f_name,age)
VALUES('Bıdık',7)
INSERT INTO cats(f_name,age)
VALUES('Bıdık',7)

#You have to assingn an ID for each row in the table. PRIMARY KEY provide to assing an ID (An unique identifier)

CREATE TABLE unique_cats1(
      cat_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
      f_name VARCHAR(50),
      age INT
)
DESC unique_cats1

INSERT INTO unique_cats1(f_name,age)
VALUES('Bıdık',7)

INSERT INTO unique_cats1(f_name,age)
VALUES('Amanda',7)

SELECT * FROM unique_cats1

#-----------------------------------------------------------------------------------------------------------------------------

#THE BASICS OF CRUD CREATE-READ-UPDATE-DELETE
      #You already know what is CREATE. Insert Into...

SHOW TABLES
CREATE TABLE cats(
      cat_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
      f_name VARCHAR(100),
      breed VARCHAR(100),
      age INT
)
DESC cats

INSERT INTO cats(f_name,breed,age)
VALUES("Ringo","Tabby",4),
      ("Cindy","Maine Coon",10),
      ("Dumbledore","Maine Coon",11),
      ("Egg","Persian",4),
      ("Misty","Tabby",13),
      ("George","Ragdoll",9),
      ("Jackson","Sphynx",7)

SELECT * FROM cats
#You can select more spesific column that you want
SELECT age FROM cats

#The WHERE clauses. Let's get specifical
SELECT * FROM cats
WHERE age > 5

SELECT * FROM cats
WHERE age > 3 AND breed = "Tabby"

#UPDATE: You learnt what is READ, another section is UPDATE. The question is how do we alter existing data?

            #List of change you want to
UPDATE cats SET breed = 'Shorthair' #Set --> Replace A with B
WHERE breed = 'Tabby'  #Replace Tabby with shorthair

UPDATE cats SET age = 14
WHERE f_name = "Misty"

UPDATE cats SET f_name = "Jack"
WHERE f_name = "Jackson"

UPDATE cats SET breed = "Biritish Shorthair"
WHERE f_name = "Ringo"

UPDATE cats SET age = 12
WHERE breed = "Maine Coon"

#DELETE: Time to learn to... delete things

DELETE FROM cats WHERE f_name = "egg"
DELETE FROM cats WHERE age =4

SELECT * FROM cats WHERE age = cat_id
DELETE FROM cats WHERE age = cat_id

DELETE FROM cats #GoodBye!

#------------------------------------------------------------------------------------------------------------------------

#CRUD EXERCISE / SPRING CLEANING

CREATE DATABASE shirts_db

CREATE TABLE shirts(
      shirt_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
      article VARCHAR(100),
      color VARCHAR(50),
      shirt_size CHAR(1),
      last_worn INT
)

INSERT INTO shirts(article,color,shirt_size,last_worn)
VALUES("t-shirt","white","S",10),
      ("t-shirt","green","S",200),
      ("polo shirt","black","M",10),
      ("tank top","blue","M",10),
      ("t-shirt","pink","S",0),
      ("polo shirt","red","M",5),
      ("tank top","white","S",200),
      ("tank top","blue","M",15)

SELECT * FROM shirts

INSERT INTO shirts(color,article,shirt_size,last_worn)
VALUES("Purple","polo shirt","M",50)

SELECT article,color from shirts

SELECT color,article,last_worn FROM shirts
WHERE shirt_size = "M"

UPDATE shirts SET shirt_size = "L"
WHERE article = "polo shirt"

UPDATE shirts SET last_worn = 0
WHERE last_worn = 15

UPDATE shirts SET shirt_size = "X",color = "Off White"
WHERE article = "t-shirt" AND color="white"

DELETE FROM shirts WHERE last_worn > 199
DELETE FROM shirts WHERE article = "tank top"

DELETE FROM shirts
DROP TABLE shirts

#------------------------------------------------------------------------------------------------------------------------

#MYSQL String Functions

USE book_shop
#CONCAT DATA FOR CELANER OUTPUT

#https://dev.mysql.com/doc/refman/8.0/en/string-functions.html

SELECT author_fname,author_lname FROM books
#CONCAT(x,y,z), CONCAT(column, anothercolumn)
#CHOOSE     CONCAT THE COLUMNS THAT YOU WANT  THE TABLE WHERE COLUMNS STORE IN IT
SELECT CONCAT(author_fname, " " , author_lname) AS "FULL NAME" FROM books;

#SUBSTRING: Working with part of strings
SELECT SUBSTRING("Hello World",1,4)

#REPLACE: Replacing parts of strings
            #   COLUMN   THE STRING YOU WANT TO REPLACE WITH      #THE TITLE
SELECT REPLACE("Hello World", "Hell",                              "£#½#")

#CHAR_LENGTH:
SELECT CONCAT(author_lname, " is ", CHAR_LENGTH(author_lname)," long ") AS "CHAR LENGTH" FROM books;

#-----------------------------------------------------------------------------------------------------------------------------

#Refining Our Selections

USE book_shop

INSERT INTO books
      (title,author_fname,author_lname,released_year,stock_quantity,pages)
      VALUES("10% Happier","Dan","Harris",2014,29,256),
            ("fake_book","Freida","Harris",2001,287,487),
            ("Lincoln In The Bardo","George","Saunders",2017,1000,367)


#DISTINCT: Provide invisibility for duplicate rows
SELECT DISTINCT author_lname FROM books;
SELECT DISTINCT CONCAT(author_fname," ",author_lname) AS "NAME" FROM books;

#OMG! you can use "--" instead of #, this is the best part of this course.

#ORDER BY: Sorting Our Results (For example, you want to learn which book is the best seller in the db?)
SELECT author_lname FROM books ORDER BY author_lname
SELECT author_lname FROM books ORDER BY author_lname DESC #Descreasing..
SELECT title FROM books ORDER BY released_year
SELECT title,author_fname,author_lname FROM books ORDER BY 2; #2 İS author_fname, it's kinda shortcut

#LIMIT
SELECT title FROM books ORDER BY released_year LIMIT 3 #Three title order by released_year

#LIKE: It's a tool to make better searching
#Short Story: There's a book I'm looking for but i can't remember the title, the author name is David or Dan, wait maybe Dave?
SELECT * FROM books 
WHERE author_fname LIKE "%da%"

SELECT * FROM books
WHERE stock_quantity LIKE '____' #A four-length number!
---------------------------------------------------------------------------------------------------------------------------------

#The Magic Of Aggregate Functions(Average-Sum, etc...)

#COUNT() FOR EXAMPLE: How many books are in the db?
SELECT COUNT(title) FROM books
SELECT COUNT(DISTINCT(author_fname)) AS "Author's first nane" FROM books #How many author are in the db?
SELECT COUNT(DISTINCT(CONCAT(author_fname,author_lname))) AS "Author's first name and last name"FROM books
SELECT COUNT(*) FROM books --HOW MANY BOOKS CONTAIN "THE"
      WHERE title LIKE '%the%'

#GROUP BY
SELECT title,author_fname FROM books
      GROUP BY author_fname

SELECT title,author_fname,COUNT(*) FROM books
      GROUP BY author_fname

SELECT released_year, COUNT(*) FROM books GROUP BY released_year --How many book(s) released? 2003 - 2017

#MIN AND MAX

-- Find the minimum-maximum year relesead_year
SELECT MIN(released_year),MAX(released_year) FROM books
-- Highest page in the db?
SELECT pages,title FROM books WHERE pages = (SELECT MAX(pages) FROM books) 
-- Find the year each author published their first book
SELECT author_fname,author_lname,MIN(released_year) FROM books
            GROUP BY author_fname,author_lname
-- Find the longest page count for each author 
SELECT author_fname,author_lname,MAX(pages) FROM books GROUP BY author_fname,author_lname

#SUM() Adds things together
SELECT SUM(pages) FROM books
--Sum all pages each author has written
SELECT author_fname,author_lname,SUM(pages) FROM books GROUP BY author_fname,author_lname

#AVG()
SELECT AVG(pages) FROM books
SELECT AVG(released_year) FROM books
--Calculate the average stock quantity for books released in the same year
SELECT AVG(stock_quantity),released_year FROM books GROUP BY released_year

---------------------------------------------------------------------------------------------------------------------------------

#Revisiting Data Types

      -- Total Number Of Digits , Digits After Decimal          
#DECIMAL(5,2) -> 999.99
      --Total Number Of Digits(5), Digits After Decimal(2)

-- DATA TYPE            MEMORY NEEDED           PRECISION ISSUES
-- FLOAT                     4 BYT                    7 DIGITS  1000001
-- DOUBLE                    8 BYT                    15 DIGITS 1100001000011.011000100 GIGANTIC NUMBERS

#DATE: Values with date but no time 
      --FORMAT: YYYY-MM-DD

#TIME: Values with a time but no date
      --FORMAT: HH:MM:SS

#DATETIME: Values with a time and date
      --FORMAT: YYYY-MM-DD HH:MM:SS

#CURDATE(), CURTIME(), NOW(), DAY(), DAYNAME(), DAYOFWEEK(), DAYOFYEAR() are several methods 

----------------------------------------------------------------------------------------------------------------------------------

#LOGICAL OPERATIONS
USE book_shop

# != Not equal
SELECT released_year FROM books WHERE released_year != 2003

# NOT LIKE
SELECT title FROM books WHERE title NOT LIKE 'W%'  #Don't start with "W" letter

# > GREATER THAN or <
SELECT title, released_year FROM books WHERE released_year > 2010 

SELECT title, released_year FROM books 
WHERE released_year < 2010 
ORDER BY released_year 

#LOGICAL AND &&
SELECT * FROM books 
WHERE released_year = 2003 && title = "Coraline"

SELECT title AS "Dave Eggers Books l Released After 2010" FROM books
WHERE CONCAT(author_fname = "Dave" && author_lname = "Eggers") && released_year > 2010

# OR operation 

SELECT title FROM books
WHERE author_fname = "Dave" && released_year > 2010 OR released_year < 2010

# BETWEEN l For example: I want to find ppl who birthday between 2003 - 2010

SELECT title FROM books
WHERE released_year BETWEEN 2004 AND 2015

# IN For Example: Select all books written by...

SELECT title FROM books
WHERE author_lname IN ("Carver","Lahiri","Smith")

# CASE STATEMENTS

 SELECT title, released_year                                      
      CASE -- Condition
            WHEN released_year >= 2000 THEN "Modern Lit"
            ELSE '20th Century Lit'
      END AS GENRE --NEW COLUMN
FROM books

# I'm not sure it's work but probably our code will be like that in python 

--import pandas as pd
--import numpy as np
-- pd.read_csv("book-data.csv")
--values = []
--FOR i in df['released_year'][1:]:
--      IF i >= 2000:
--            values.append('Modern Lit')
--      ELIF i < 2000:
--            values.append('20th Century Lit')
--df["Genre"] = pd.Series(values)
