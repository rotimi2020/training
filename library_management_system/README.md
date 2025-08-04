# 📚 Library Management System Using SQL

## 🔍 Project Overview

This project explores the design and analysis of a **Library Management System (LMS)** using SQL. It’s based on a real-world scenario where a local library manager provided access to their database and shared 30 business questions ranging from basic lookups to complex insights.

The main goal is to write and execute SQL queries that help uncover useful information about the library’s operations, book inventory, borrowing trends, member behavior, fines, and supplier performance.

---

## 🎯 Objectives

- **Extract Meaningful Insights**  
  Write SQL queries to retrieve valuable data from the LMS database.

- **Answer Real Business Questions**  
  Tackle specific problems raised by the library owner to understand daily operations and member behavior.

- **Apply Advanced SQL Skills**  
  Use advanced SQL techniques like joins, CTEs, subqueries, window functions, and CASE logic to analyze trends and patterns.

- **Deliver Actionable Reports**  
  Summarize key findings to support data-driven decisions for managing the library more effectively.

---

## 💼 Business Questions

This project was designed to help the library owner answer real business questions through SQL-based analysis:

1. **How do borrowing trends change over time?**  
   Understanding daily and seasonal borrowing patterns helps with staff planning and book availability.

2. **Which book categories and titles hold the most value?**  
   The owner wants to identify high-value books based on usage and cost to improve future purchases.

3. **Who are the most active members, and how do they behave?**  
   Explore member behavior by type (e.g. temporary vs permanent) and region to tailor services.

4. **What’s the relationship between fines and borrowing habits?**  
   Analyze fine categories, delay frequency, and patterns among members who return books late.

5. **Which books are borrowed the most, and how does that relate to supplier performance?**  
   Measure book popularity and link it to supplier performance to guide procurement decisions.

---

## 📌 Problem Statement

The goal of this project is to run a collection of SQL queries—ranging from basic to advanced—to explore and analyze data from a Library Management System (LMS) database.

The analysis focuses on key areas like book borrowing trends, member engagement, fine history, and supplier performance, helping the library owner better understand the system and make smarter decisions.

---

## 📂 Dataset

The dataset used in this project represents a simplified version of a real Library Management System and includes the following core tables:

- 📘 **Book Details**  
  Contains book ID, title, author, category, price, and publication date — everything about the books in stock.

- 👤 **Members**  
  Records each library user with details like member ID, full name, contact info, and registration date.

- 💰 **Fine Details**  
  Shows member fines based on late book returns, categorized by delay range.

- 🚚 **Suppliers**  
  Contains supplier ID, name, and contact details — useful for tracking book sources.

- 📦 **Book Issue**  
  Logs book borrowings with issue and return dates, member ID, book code, and any related fines.

> ⚠️ **Note:** The dataset was shared informally by a data analyst for personal learning and portfolio-building purposes. It’s not from a public domain but reflects structured LMS data typically found in educational and institutional settings.

---

## 🧠 Skills Used

- SQL (JOINs, GROUP BY, CTEs, CASE WHEN, Subqueries, Window Functions)
- Data Cleaning & Exploration
- Logical Query Building
- Database Relationships & Keys
- Business Insight Communication
- Git & GitHub for Version Control

---

## 📊 SQL Queries

### **Basic Queries (1–10)**  
[Click to Expand...]
<details>
<summary>View Queries</summary>

**--------------------------------*Basic Queries (1-10)*-------------------------------------**

- **QUESTIONS 1 :** Write a query to fetch all book titles and their corresponding author names. 
```sql
SELECT
  [BOOK_TITLE],
  ([AUTHOR])
FROM
  [dbo].[LMS_BOOK_DETAILS];
```

- **QUESTIONS 2 :** Write a query to find all books published after the year 2015. 
```sql
SELECT
  *
FROM
  [dbo].[LMS_BOOK_DETAILS]
WHERE
  YEAR([PUBLISH_DATE]) > 2015;
```

- **QUESTIONS 3 :** Write a query to list all members sorted by their registration date in descending order. 
```sql
SELECT
  *
FROM
  [dbo].[LMS_MEMBERS]
ORDER BY
  [DATE_REGISTER] DESC;
```

- **QUESTIONS 4 :** Write a query to calculate the total number of books in the library. 
```sql
SELECT
  COUNT(*) AS TOTAL_NUMBER_OF_BOOK
FROM
  [dbo].[LMS_BOOK_DETAILS];
```

- **QUESTIONS 5 :** Write a query to display all book titles and their categories.
```sql
SELECT
  [BOOK_TITLE],
  [CATEGORY]
FROM
  [dbo].[LMS_BOOK_DETAILS]
GROUP BY
  [BOOK_TITLE],
  [CATEGORY]
ORDER BY
  [CATEGORY];
```

- **QUESTION 6 :** Write a query to find the details of a book with the title "Data Science for Beginners." 
```sql
SELECT
  *
FROM
  [dbo].[LMS_BOOK_DETAILS]
WHERE
  [BOOK_TITLE] = 'Data Science for Beginners';
```

- **QUESTION 7 :** Write a query to fetch all members who registered in the last 6 months. 
```sql
SELECT
  MAX([DATE_REGISTER]) AS MAX_DATE
FROM
  [dbo].[LMS_MEMBERS] ---MAX DATE IS '2020-08-02'
  
--------
 
SELECT
  DATEADD(MONTH, -6, '2020-08-02') --Date For Last 6 Month
  
--------
  
SELECT
  *
FROM
  [dbo].[LMS_MEMBERS]
WHERE
  [DATE_REGISTER] BETWEEN '2020-02-02' AND '2020-08-02' 
```  

- **QUESTION 8 :** Write a query to count the number of distinct authors in the library. 
```sql  
SELECT
  [AUTHOR],
  COUNT(DISTINCT([AUTHOR])) AS DISTINCT_COUNT
FROM
  [dbo].[LMS_BOOK_DETAILS]
GROUP BY
  [AUTHOR];
```

- **QUESTION 9 :** Write a query to list all books priced above 1000 INR. 
```sql
SELECT
  *
FROM
  [dbo].[LMS_BOOK_DETAILS]
WHERE
  [PRICE] > 1000;
```

- **QUESTION 10 :** Write a query to display member names and the total fine amount they owe. 
```sql
WITH
  MEMBER_NAME AS (
    SELECT
      A.MEMBER_ID,
      C.MEMBER_NAME,
      B.FINE_AMOUNT
    FROM
      [dbo].[LMS_BOOK_ISSUE] A
      LEFT JOIN [dbo].[LMS_FINE_DETAILS] B ON A.[FINE_RANGE] = B.[FINE_RANGE]
      LEFT JOIN [dbo].[LMS_MEMBERS] C ON A.MEMBER_ID = C.MEMBER_ID
  )
SELECT
  MEMBER_NAME,
  SUM(FINE_AMOUNT) AS TOTAL_FINE_MONEY
FROM
  MEMBER_NAME
group by
  MEMBER_NAME;
```
</details>


### **Intermediate Queries (11–20)**  
[Click to Expand...]
<details>
<summary>View Queries</summary>

**--------------------------------*Intermediate Queries (11-20)*-------------------------------------**
- **QUESTION 11 :** Write a query to display book titles along with their supplier names. 
```sql
SELECT
  A.BOOK_TITLE AS [Book Title],
  B.SUPPLIER_NAME AS [Supplier Name]
FROM
  [dbo].[LMS_BOOK_DETAILS] A
  LEFT JOIN [dbo].[LMS_SUPPLIERS_DETAILS] B ON A.[SUPPLIER_ID] = B.[SUPPLIER_ID]
GROUP BY
  A.BOOK_TITLE,
  B.SUPPLIER_NAME
ORDER BY
  B.SUPPLIER_NAME;
```

- **QUESTION 12 :** Write a query to calculate the total number of books issued per member. 
```sql
SELECT
  A.MEMBER_ID AS [Member id],
  B.MEMBER_NAME AS [Member Name],
  COUNT(*) AS [Total books]
FROM
  [dbo].[LMS_BOOK_ISSUE] A
  LEFT JOIN [dbo].[LMS_MEMBERS] B ON A.[MEMBER_ID] = B.[MEMBER_ID]
GROUP BY
  A.MEMBER_ID,
  B.MEMBER_NAME;
```

- **QUESTION 13 :** Write a query to find books where the price is between 500 and 1000. 
```sql
SELECT
  *
FROM
  [dbo].[LMS_BOOK_DETAILS]
WHERE
  [PRICE] BETWEEN 500 AND 1000;
```

- **QUESTION 14 :** Write a query to group books by category and calculate the total number of books in each category. 
```sql
WITH
  Group_Book AS(
    SELECT
      CATEGORY AS [Category],
      COUNT(Category) AS [Total Books]
    FROM
      [dbo].[LMS_BOOK_DETAILS]
    GROUP BY
      CATEGORY
  )
SELECT
  [Category],
  [Total Books]
FROM
  Group_Book
GROUP BY
  [Category],
  [Total Books];
```

- **QUESTION 15 :** Write a query to find suppliers who have supplied more than 20 books. 
```sql
SELECT
  B.SUPPLIER_NAME AS [Supplier Name],
  count(B.SUPPLIER_NAME) AS [Number Of Books]
FROM
  [dbo].[LMS_BOOK_DETAILS] A
  left join [LMS_SUPPLIERS_DETAILS] B on A.SUPPLIER_ID = B.SUPPLIER_ID
group by
  B.SUPPLIER_NAME
having
  count(B.SUPPLIER_NAME) > 20
```

- **QUESTION 16 :** Write a query to fetch the details of the book with the highest price. 
```sql  
SELECT
  TOP 1 *
FROM
  [dbo].[LMS_BOOK_DETAILS]
order by
  PRICE desc;
```

- **QUESTION 17 :** Write a query to list all members who have issued at least one book. 
```sql
SELECT
  B.MEMBER_NAME AS [Member Name],
  count(B.MEMBER_NAME) AS [Number Of Books Issued]
FROM
  [dbo].[LMS_BOOK_ISSUE] A
  left join [LMS_MEMBERS] B on A.[MEMBER_ID] = B.[MEMBER_ID]
group by
  B.MEMBER_NAME
having
  count(B.MEMBER_NAME) = 1 
```  

- **QUESTION 18 :** Write a query to fetch book titles that have been issued more than 5 times. 
```sql  
SELECT
  A.BOOK_TITLE AS [Book Titles],
  count(A.BOOK_TITLE) AS [Number Of Books Issued]
FROM
  [dbo].[LMS_BOOK_DETAILS] A
  left join [LMS_BOOK_ISSUE] B on A.[BOOK_CODE] = B.[BOOK_CODE]
group by
  A.BOOK_TITLE
having
  count(A.BOOK_TITLE) > 5;
```

- **QUESTION 19 :** Write a query to find the name and contact details of members who issued books in the last 30 days. 
```sql
SELECT
  MAX([DATE_ISSUE]) AS MAX_DATE
FROM
  [dbo].[LMS_BOOK_ISSUE] --- Max Day IS 2020-04-16
 
--------
 
SELECT
  DATEADD(DAY, -30, '2020-04-16') AS [Previous Day] -- PREVIOUS 30 DAYS IS 2020-03-17
  
--------

select
  A.MEMBER_NAME,
  A.MEMBERSHIP_STATUS,
  A.CITY,
  B.BOOK_CODE,
  B.DATE_ISSUE
from
  [dbo].[LMS_MEMBERS] A
  left join [dbo].[LMS_BOOK_ISSUE] B on A.MEMBER_ID = B.MEMBER_ID
WHERE
  B.DATE_ISSUE BETWEEN '2020-03-17' AND '2020-04-16' --30 DAYS INTERVAL
```

- **QUESTION 20 :** Write a query to find books that have never been issued. 
```sql  
SELECT
  COUNT(BOOK_ISSUE_NO) AS [Nos Of Book Not Issued]
FROM
  [dbo].[LMS_BOOK_ISSUE]
WHERE
  [BOOK_ISSUE_NO] IS NULL;
```
</details>


### **Advanced Queries (21–30)**  
[Click to Expand...]
<details>
<summary>View Queries</summary>

**--------------------------------*Advanced Queries (21-30)*-------------------------------------**
- **QUESTION 1 :** Write a query to list all overdue books along with the member names who borrowed them. 
```sql
SELECT
  B.BOOK_ISSUE_NO,
  A.MEMBER_NAME,
  C.BOOK_TITLE,
  C.CATEGORY,
  B.DATE_ISSUE,
  B.DATE_RETURN,
  B.DATE_RETURNED
FROM
  [dbo].[LMS_MEMBERS] A
  LEFT join [dbo].[LMS_BOOK_ISSUE] B ON A.MEMBER_ID = B.MEMBER_ID
  LEFT JOIN [dbo].[LMS_BOOK_DETAILS] C ON C.BOOK_CODE = B.BOOK_CODE
WHERE
  B.DATE_RETURNED > B.DATE_RETURN;
```

- **QUESTION 22 :** Write a query to rank books based on their price in descending order using window functions. 
```sql
SELECT
  BOOK_CODE,
  BOOK_TITLE,
  CATEGORY,
  RANK() OVER (
    ORDER BY
      PRICE DESC
  ) AS Rank
FROM
  [DBO].LMS_BOOK_DETAILS;
```

- **QUESTION 23 :** Write a query using a CTE to find the total number of books issued per category. 
```sql
WITH
  BOOK_ISSUE AS (
    SELECT
      B.CATEGORY
    FROM
      [dbo].[LMS_BOOK_ISSUE] A
      left join [dbo].[LMS_BOOK_DETAILS] B ON A.BOOK_CODE = B.BOOK_CODE
  )
SELECT
  CATEGORY AS Category,
  COUNT(CATEGORY) AS [Books Issued Per Category]
FROM
  BOOK_ISSUE
GROUP BY
  CATEGORY;
```

- **QUESTION 24 :** Write a query to display book titles and a new column "Price Range" (Low, Medium, High) based on their price. 
```sql
SELECT
  MAX(PRICE) AS [Maximum Price]
FROM
  [dbo].[LMS_BOOK_DETAILS] ---Max Price is 1800.00
  
--------

SELECT
  MIN(PRICE) AS [Miniimum Price]
FROM
  [dbo].[LMS_BOOK_DETAILS] ---Min Price is 375.00
  
--------
  
SELECT
  [BOOK_TITLE],
  PRICE,
  CASE
    WHEN PRICE BETWEEN 0 AND 499 THEN 'Low'
    WHEN PRICE BETWEEN 500 AND 999 THEN 'Medium' --WHEN PRICE >= 1000 THEN 'High'
    ELSE 'High'
  END AS [PRICE RANGE]
FROM
  [dbo].[LMS_BOOK_DETAILS];
```

- **QUESTION 25 :** Write a recursive query to find all books under a specific category and its subcategories. 
```sql
-- Replace 'Data Science' with the target category
WITH
  RECURSIVE Category_Hierarchy AS (
    -- Start with the main category
    SELECT
      DISTINCT CATEGORY,
      PARENT_CATEGORY
    FROM
      [dbo].[LMS_BOOK_DETAILS]
    WHERE
      CATEGORY = 'Data Science'
    UNION ALL
    -- Recursively find subcategories
    SELECT
      b.CATEGORY,
      b.PARENT_CATEGORY
    FROM
      [dbo].[LMS_BOOK_DETAILS] b
      INNER JOIN Category_Hierarchy ch ON b.PARENT_CATEGORY = ch.CATEGORY
  ) 
 
 -- Select all books that fall under this hierarchy
SELECT
  DISTINCT b.BOOK_CODE,
  b.BOOK_TITLE,
  b.CATEGORY,
  b.PRICE
FROM
  [dbo].[LMS_BOOK_DETAILS] b
  INNER JOIN Category_Hierarchy ch ON b.CATEGORY = ch.CATEGORY;
```
- **QUESTION 26 :** Write a query to calculate the total fine amount collected for overdue books. 
```sql
WITH
  OVERDUE_BOOK AS (
    SELECT
      A.BOOK_CODE,
      B.FINE_AMOUNT
    FROM
      [dbo].[LMS_BOOK_ISSUE] A
      LEFT JOIN [dbo].[LMS_FINE_DETAILS] B ON A.FINE_RANGE = B.FINE_RANGE
    WHERE
      A.FINE_RANGE IS NOT NULL
  )
SELECT
  SUM(FINE_AMOUNT) AS [Total Fine Amount]
FROM
  OVERDUE_BOOK;
```

- **QUESTION 27 :** Write a query to find the top 3 members who have issued the most books. 
```sql
SELECT
  TOP 3 B.MEMBER_NAME,
  count(B.MEMBER_ID) AS [Member Who issue Books]
FROM
  [dbo].[LMS_BOOK_ISSUE] A
  left join [dbo].[LMS_MEMBERS] B ON A.MEMBER_ID = B.MEMBER_ID
GROUP BY
  B.MEMBER_NAME
order by
  [Member Who issue Books] desc;
```

- **QUESTION 28 :** Write a query to find suppliers who have supplied books in multiple categories. 
```sql
SELECT
  B.SUPPLIER_NAME,
  COUNT(B.SUPPLIER_NAME) AS [Nos Of Book Supplied]
FROM
  [dbo].[LMS_BOOK_DETAILS] A
  LEFT JOIN [dbo].[LMS_SUPPLIERS_DETAILS] B ON A.SUPPLIER_ID = B.SUPPLIER_ID
GROUP BY
  B.SUPPLIER_NAME
order by
  [Nos Of Book Supplied] desc 
 ``` 

- **QUESTION 29 :** Write a query to find members who issued the same book multiple times. 
```sql  
SELECT
  MEMBER_ID,
  BOOK_CODE,
  COUNT(BOOK_ISSUE_NO) AS [Issued Same Book]
FROM
  [dbo].[LMS_BOOK_ISSUE]
group by
  BOOK_CODE,
  MEMBER_ID
having
  COUNT(BOOK_ISSUE_NO) > 1 
```  

- **QUESTION 30 :** Write a query to calculate the average price of books per category. 
```sql
SELECT
  CATEGORY,
  AVG(PRICE) AS [Average Price]
FROM
  [dbo].[LMS_BOOK_DETAILS]
GROUP BY
  CATEGORY;

```
</details>

## Reports
**Basic Reports:**

- List of all book titles and their corresponding author names.
- Books published after the year 2015.
- Members sorted by their registration date.
- Total number of books in the library.
- Book titles and their categories.
- Details of the book titled "Data Science for Beginners."
- Members who registered in the last 6 months.
- Number of distinct authors.
- Books priced above 1000 INR.
- Member names and the total fine amount they owe.
  
**Intermediate Reports:**

- titles along with their supplier names.
- Total number of books issued per member.
- Books where the price is between 500 and 1000 INR.
- Group books by category and calculate the total number of books in each category.
- Suppliers who have supplied more than 20 books.
- Details of the book with the highest price.
- Members who have issued at least one book.
- Book titles that have been issued more than 5 times.
- Name and contact details of members who issued books in the last 30 days.
- Books that have never been issued.

  
**Advanced Reports:**
- Overdue books along with the member names who borrowed them.
-  books based on their price in descending order using window functions.
- Total number of books issued per category using a CTE.
- Book titles and a new column "Price Range" (Low, Medium, High) based on their price.
- Recursive query to find all books under a specific category and its subcategories.
- Total fine amount collected for overdue books.
- Top 3 members who have issued the most books.
- Suppliers who have supplied books in multiple categories.
- Members who issued the same book multiple times.
- Average price of books per category.


**Conclusion**
The data analysis of the Library Management System will provide valuable insights into user behavior, inventory management, and overall library operations. By addressing the 30 queries provided by the library owner, we can uncover important trends and metrics that can help optimize library services, enhance user satisfaction, and support strategic decision-making. The comprehensive reports generated from the SQL queries will serve as a foundation for ongoing monitoring and improvement of the library's operations.
