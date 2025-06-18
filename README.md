## Contents 📋:

0. [Intro](#intro)
1. [Database contains](#cont)
2. [Entity–Relationship Diagrams](#erd)
3. [Data Manipulations: Queries, Functions, Procedures, and Views (a few examples)](#manipulation)

<a name="intro"></a>
## 0. Intro 👁️👁️:
The Sneakers shop is a demo version of a database. I use Microsoft SQL Server for data storage, and the query language is Transact-SQL. In this project, I demonstrate my skills in database creation, data population, writing queries, and using Functions, Procedures, and Views. This project was completed in 2021 as part of the "Introduction to Databases" course.

<a name="cont"></a>
## 1. Database contains 🗃️: 
- 13 tables (+1 operation performed using the INTO keyword for copying data):
  - Clients
  - Earnings
  - Employees
  - CategoriesShoes
  - Gender
  - SizeForWomen
  - SizeForMen
  - Colours
  - Shoes
  - Solds
  - SalesDates
  - Prices
  - Positions
  - CopyEmployees
- 12 queries,
- 3 views,
- 3 procedures,
- 3 functions.

<a name="erd"></a>
## 2. Entity–Relationship Diagrams 📊:
Here are the database diagrams below

![image](https://github.com/user-attachments/assets/b4309326-60b6-47ab-959d-a7a2b9843a49)

![image](https://github.com/user-attachments/assets/c1b85903-febe-4fdb-af21-5b0515f87901)

<a name="manipulation"></a>
## 3. Data Manipulations: Queries, Functions, Procedures, and Views (a few examples) 📈:

  ### 3.0 (Queries)
This query will display a table containing information about shoe models sold in these years, additionally providing details on the number of units sold for each model and the average shoe price.

![image](https://github.com/user-attachments/assets/0babed45-3b7d-44e9-ac43-933bd829e65e)

This query will show the name of the "Puma" shoes, their models, and the number of units sold.

![image](https://github.com/user-attachments/assets/8547abcd-210f-4bd3-ae3a-7b998467fe8a)

### 3.1 (View)

This view will provide information about Buyers and Sellers (their First and Last Names),
Shoes (the "Adidas" brand and its models),
along with the shoe price and the purchase date made by the buyer.

![image](https://github.com/user-attachments/assets/69b33422-d59a-49ca-a310-2d8089ec1591)

### 3.2 (Procedure)

The procedure will display a table with the company name, shoe models, collaboration,
gender (male, female), color, size (EU, UK, cm), price, and the quantity of these shoes.

![image](https://github.com/user-attachments/assets/6da09c3a-79f9-485f-9de3-6e2ea6f7be4d)

![image](https://github.com/user-attachments/assets/e3eb2a69-c4d6-432c-88a5-5cc452247a14)

### 3.3 (Function)

The function allows entering a price of "100" and displays the client's full name, email, phone number, the employee's full name, phone number, company name, full shoe model, price, discount, and sale date

![image](https://github.com/user-attachments/assets/b6b525a2-c5c2-4860-a89e-3c8d3b91ea33)

![image](https://github.com/user-attachments/assets/82e477f4-4dc7-4eef-9f83-0900a66e78e9)








