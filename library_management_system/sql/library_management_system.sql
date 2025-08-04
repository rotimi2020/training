---------------------------------------------------------------------
/* FILE 1 : VIEW FILE FROM LMS_BOOK_DETAILS */

SELECT
  *
FROM
  [dbo].[LMS_BOOK_DETAILS];

---------------------------------------------------------------------
/* FILE 2 : VIEW FILE FROM LMS_BOOK_ISSUE */

SELECT
  *
FROM
  [dbo].[LMS_BOOK_ISSUE];

---------------------------------------------------------------------
/* FILE 3 : VIEW FILE FROM LMS_FINE_DETAILS */

SELECT
  *
FROM
  [dbo].[LMS_FINE_DETAILS];

---------------------------------------------------------------------
/* FILE 4 : VIEW FILE FROM LMS_MEMBERS */

SELECT
  *
FROM
  [dbo].[LMS_MEMBERS];

---------------------------------------------------------------------
/* FILE 5 : VIEW FILE FROM LMS_SUPPLIERS_DETAILS */

SELECT
  *
FROM
  [dbo].[LMS_SUPPLIERS_DETAILS];

  
--------------------------------*Basic Queries (1-10)*-------------------------------------
/* QUESTIONS 1 : Write a query to fetch all book titles and their corresponding author names. */

SELECT
  [BOOK_TITLE],
  ([AUTHOR])
FROM
  [dbo].[LMS_BOOK_DETAILS]
GROUP BY
  [BOOK_TITLE],
  [AUTHOR];

--------------------------------*Basic Queries (1-10)*------------------------------------- 
/* QUESTIONS 2 : Write a query to find all books published after the year 2015. */

SELECT
  *
FROM
  [dbo].[LMS_BOOK_DETAILS]
WHERE
  YEAR([PUBLISH_DATE]) > 2015;

--------------------------------*Basic Queries (1-10)*-------------------------------------
/* QUESTIONS 3 : Write a query to list all members sorted by their registration date in descending order. */

SELECT
  *
FROM
  [dbo].[LMS_MEMBERS]
ORDER BY
  [DATE_REGISTER] DESC;

--------------------------------*Basic Queries (1-10)*-------------------------------------
/* QUESTIONS 4 : Write a query to calculate the total number of books in the library. */

SELECT
  COUNT(*) AS TOTAL_NUMBER_OF_BOOK
FROM
  [dbo].[LMS_BOOK_DETAILS];

--------------------------------*Basic Queries (1-10)*-------------------------------------
/* QUESTIONS 5 : Write a query to display all book titles and their categories. */

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

--------------------------------*Basic Queries (1-10)*-------------------------------------
/* QUESTION 6 : Write a query to find the details of a book with the title "Data Science for Beginners." */

SELECT
  *
FROM
  [dbo].[LMS_BOOK_DETAILS]
WHERE
  [BOOK_TITLE] = 'Data Science for Beginners';

--------------------------------*Basic Queries (1-10)*-------------------------------------
/* QUESTION 7 : Write a query to fetch all members who registered in the last 6 months. */

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
  
--------------------------------*Basic Queries (1-10)*-------------------------------------
  /* QUESTION 8 : Write a query to count the number of distinct authors in the library. */
  
SELECT
  [AUTHOR],
  COUNT(DISTINCT([AUTHOR])) AS DISTINCT_COUNT
FROM
  [dbo].[LMS_BOOK_DETAILS]
GROUP BY
  [AUTHOR];

--------------------------------*Basic Queries (1-10)*-------------------------------------
/* QUESTION 9 : Write a query to list all books priced above 1000 INR. */

SELECT
  *
FROM
  [dbo].[LMS_BOOK_DETAILS]
WHERE
  [PRICE] > 1000;

--------------------------------*Basic Queries (1-10)*-------------------------------------
/* QUESTION 10 : Write a query to display member names and the total fine amount they owe. */

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

--------------------------------*Intermediate Queries (11-20)*-------------------------------------
/* QUESTION 11 : Write a query to display book titles along with their supplier names. */

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

--------------------------------*Intermediate Queries (11-20)*-------------------------------------
/* QUESTION 12 : Write a query to calculate the total number of books issued per member. */

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

--------------------------------*Intermediate Queries (11-20)*-------------------------------------
/* QUESTION 13 : Write a query to find books where the price is between 500 and 1000. */

SELECT
  *
FROM
  [dbo].[LMS_BOOK_DETAILS]
WHERE
  [PRICE] BETWEEN 500 AND 1000;

--------------------------------*Intermediate Queries (11-20)*-------------------------------------
/* QUESTION 14 : Write a query to group books by category and calculate the total number of books in each category. */

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

--------------------------------*Intermediate Queries (11-20)*-------------------------------------
/* QUESTION 15 : Write a query to find suppliers who have supplied more than 20 books. */

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
--------------------------------*Intermediate Queries (11-20)*-------------------------------------
/* QUESTION 16 : Write a query to fetch the details of the book with the highest price. */
  
SELECT
  TOP 1 *
FROM
  [dbo].[LMS_BOOK_DETAILS]
order by
  PRICE desc;

--------------------------------*Intermediate Queries (11-20)*-------------------------------------
/* QUESTION 17 : Write a query to list all members who have issued at least one book. */
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
  
--------------------------------*Intermediate Queries (11-20)*-------------------------------------
  /* QUESTION 18 : Write a query to fetch book titles that have been issued more than 5 times. */
  
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

--------------------------------*Intermediate Queries (11-20)*-------------------------------------
/* QUESTION 19 : Write a query to find the name and contact details of members who issued books in the last 30 days. */

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

--------------------------------*Intermediate Queries (11-20)*-------------------------------------
/* QUESTION 20 : Write a query to find books that have never been issued. */
  
SELECT
  COUNT(BOOK_ISSUE_NO) AS [Nos Of Book Not Issued]
FROM
  [dbo].[LMS_BOOK_ISSUE]
WHERE
  [BOOK_ISSUE_NO] IS NULL;

--------------------------------*Advanced Queries (21-30)*-------------------------------------
/* QUESTION 21 : Write a query to list all overdue books along with the member names who borrowed them. */

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

--------------------------------*Advanced Queries (21-30)*-------------------------------------
/* QUESTION 22 : Write a query to rank books based on their price in descending order using window functions. */

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

--------------------------------*Advanced Queries (21-30)*-------------------------------------
/* QUESTION 23 : Write a query using a CTE to find the total number of books issued per category. */

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

--------------------------------*Advanced Queries (21-30)*-------------------------------------
/* QUESTION 24 : Write a query to display book titles and a new column "Price Range" (Low, Medium, High) based on their price. */

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

--------------------------------*Advanced Queries (21-30)*-------------------------------------
/* QUESTION 25 : Write a recursive query to find all books under a specific category and its subcategories. */

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
  
--------------------------------*Advanced Queries (21-30)*-------------------------------------
/* QUESTION 26 : Write a query to calculate the total fine amount collected for overdue books. */

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

--------------------------------*Advanced Queries (21-30)*-------------------------------------
/* QUESTION 27 : Write a query to find the top 3 members who have issued the most books. */

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

--------------------------------*Advanced Queries (21-30)*-------------------------------------
/* QUESTION 28 : Write a query to find suppliers who have supplied books in multiple categories. */

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
  
--------------------------------*Advanced Queries (21-30)*-------------------------------------
  /* QUESTION 29 : Write a query to find members who issued the same book multiple times. */
  
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
  
--------------------------------*Advanced Queries (21-30)*-------------------------------------
/* QUESTION 30 : Write a query to calculate the average price of books per category. */

SELECT
  CATEGORY,
  AVG(PRICE) AS [Average Price]
FROM
  [dbo].[LMS_BOOK_DETAILS]
GROUP BY
  CATEGORY;
