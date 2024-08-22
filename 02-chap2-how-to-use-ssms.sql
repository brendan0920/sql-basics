-- Chapter 2 Basic Statements
SELECT * FROM Vendors;

--Chapter 3p. 65
SELECT *
  FROM Invoices;

-- same query, but only show 3columns and order by invoice total
SELECT InvoiceNumber, InvoiceDate, InvoiceTotal
  FROM Invoices
  ORDER BY InvoiceTotal;

-- two columns and a calculated value FOR A SPECIFIC INVOICE (ID 17)
SELECT InvoiceID, InvoiceTotal, CreditTotal + PaymentTotal AS TotalCredits
  FROM Invoices
  WHERE InvoiceID = 17;

-- A SELECT statement that retrieves all invoices between given dates
SELECT  InvoiceNumber, InvoiceDate, InvoiceTotal
  FROM Invoices
  WHERE InvoiceDate BETWEEN '2023-01-01' and '2023-03-31'
  ORDER BY InvoiceDate;

-- A SELECT statement that returns an empty result set 
SELECT InvoiceNumber, InvoiceDate, InvoiceTotal
  FROM Invoices
  WHERE InvoiceTotal > 50000; 

-- page 69
-- naming columns in the result set;
SELECT InvoiceNumber AS [InoviceNumber], InvoiceDate AS Date, InvoiceTotal AS Total
  FROM Invoices;

--doesn¡¯t provide a name for a calculated column 
SELECT InvoiceNumber, InvoiceDate, InvoiceTotal, InvoiceTotal - PaymentTotal - CreditTotal 
  FROM Invoices;

-- p. 7 coding expressions
--to concatenate string data
SELECT VendorCity, VendorState, VendorCity + VendorState
  FROM Vendors;

-- to concatenate using commas and spaces
SELECT VendorName, (VendorCity+', ' + VendorState + ' ' + VendorZipCode) AS Address 
  FROM Vendors;

-- to include apostrophes in literal values 
SELECT (VendorName + '''s Address: '),
       (VendorCity + ', ' + VendorState + ' ' + VendorZipCode) 
  FROM Vendors;

-- A SELECT statement that calculates the balance due
SELECT InvoiceTotal, PaymentTotal, CreditTotal, InvoiceTotal - PaymentTotal - CreditTotal AS BalanceDue
  FROM Invoices;

--A SELECT statement that uses parentheses to control the sequence of operations
SELECT InvoiceID, InvoiceID + 7 * 3 AS orderOfPrecedence, (InvoiceID + 7) AS AddFirst
  FROM Invoices
  ORDER BY InvoiceID;

-- A SELECT statement that uses the modulo operator 
SELECT InvoiceID, InvoiceID / 10 AS Quotient, InvoiceID % 10 AS Remainder
  FROM Invoices
  ORDER BY InvoiceID;

--  p. 75 SELECT statement that uses the LEFT function 
SELECT VendorContactFName, VendorContactLName, 
       LEFT(VendorContactFName, 1) + LEFT(VendorContactLName, 1) AS Initials
  FROM Vendors;

-- A SELECT statement that uses the CONVERT function 
SELECT 'Invoice: #' + InvoiceNumber
		+ ', dated ' + CONVERT(char(8), PaymentDate, 1) 
		+ ' for $' + CONVERT(varchar(9), PaymentTotal, 1)
  FROM Invoices;

-- SELECT statement that computes the age of an invoice 
SELECT InvoiceDate,
	  GETDATE() AS 'Today''s Date',
	  DATEDIFF(day, InvoiceDate, GETDATE()) AS Age
FROM Invoices;

-- p.77 A SELECT statement that returns all rows
SELECT VendorCity, VendorState 
  FROM Vendors
  ORDER BY VendorCity;

-- A SELECT statement that eliminates duplicate rows 
SELECT DISTINCT VendorCity, VendorState 
  FROM Vendors;

--p79 A SELECT statement with a TOP clause
SELECT TOP 5 VendorID, InvoiceTotal 
  FROM Invoices
  ORDER BY InvoiceTotal DESC;

-- A SELECT statement with a TOP clause and the WITH TIES keyword 
  SELECT TOP 5 WITH TIES VendorID, InvoiceDate 
  FROM Invoices
  ORDER BY InvoiceDate ASC;

-- p99. Exercises
-- 1.
SELECT VendorContactFName, VendorContactLName, VendorName
  FROM Vendors
  ORDER BY VendorContactLName, VendorContactFName;

-- 2.
SELECT InvoiceNumber AS Number, 
       InvoiceTotal AS Total, 
       (PaymentTotal + CreditTotal) AS Credits, 
       (InvoiceTotal - (PaymentTotal + CreditTotal)) AS Balance
  FROM Invoices;

-- 3.
SELECT VendorContactLName + ', ' + VendorContactFName AS 'Full Name'
  FROM Vendors
  ORDER BY VendorContactLName, VendorContactFName;

-- 4.
SELECT InvoiceTotal, InvoiceTotal * 0.1 AS '10%', InvoiceTotal * 1.1 AS 'Plus 10%'  
  FROM Invoices
  WHERE InvoiceTotal - PaymentTotal - CreditTotal > 1000
  ORDER BY InvoiceTotal DESC;

-- 5.
SELECT InvoiceNumber AS Number, 
       InvoiceTotal AS Total, 
       (PaymentTotal + CreditTotal) AS Credits, 
       (InvoiceTotal - (PaymentTotal + CreditTotal)) AS Balance
  FROM Invoices
  WHERE  InvoiceTotal >= 500 AND InvoiceTotal <= 10000;

-- 6.
SELECT VendorContactLName + ', ' + VendorContactFName AS 'Full Name'
  FROM Vendors
  WHERE 
	   VendorContactLName LIKE '[A-C]%'
	   OR VendorContactLName LIKE 'E%'
  ORDER BY VendorContactLName, VendorContactFName;
  
-- 7. PaymentDate, InvoiceTotal - PaymentTotal - CreditTotal AS 'Balance Due'
 SELECT *
    FROM Invoices
	WHERE (InvoiceTotal - PaymentTotal - CreditTotal > 0 AND PaymentDate IS NOT NULL)
		  OR
		  (InvoiceTotal - PaymentTotal - CreditTotal <= 0 AND PaymentDate IS NULL);

-- P. 103 Chapter4
-- A SELECT statement that joins the Vendors and Invoices tables 
SELECT InvoiceNumber, VendorName 
  FROM Vendors
  JOIN Invoices
  ON Vendors.VendorID = Invoices.VendorID; 

--p107 A join with fully-qualified table names 
SELECT VendorName, CustLastName, CustFirstName, VendorState AS State, VendorCity AS City
  FROM AP.dbo.Vendors v 
     JOIN ProductOrders.dbo.Customers c 
        ON v.VendorZipCode = c.CustZip
  ORDER BY State, City;
 
 --The same join with partially-qualified table names 
 SELECT VendorName, CustLastName, CustFirstName, VendorState AS State, VendorCity AS City 
   FROM Vendors v 
      JOIN ProductOrders..Customers c 
	     ON v.VendorZipCode = c.CustZip
  ORDER BY State, City; 

  --p109  An inner join with two conditions 
SELECT InvoiceNumber, InvoiceDate, InvoiceTotal, InvoiceLineItemAmount 
  FROM Invoices i
     JOIN InvoiceLineItems li
        ON i.InvoiceID = li.InvoiceID AND i.InvoiceTotal > li.InvoiceLineItemAmount
  ORDER BY InvoiceNumber;

-- The same join with the second condition coded in a WHERE clause 
SELECT InvoiceNumber, InvoiceDate, InvoiceTotal, InvoiceLineItemAmount 
  FROM Invoices i
     JOIN InvoiceLineItems li 
	    ON i.InvoiceID = li.InvoiceID
  WHERE i.InvoiceTotal > li.InvoiceLineItemAmount 
  ORDER BY InvoiceNumber;

--p111 A self-join that returns vendors from cities in common with other vendors 
SELECT DISTINCT v1.VendorName, v1.VendorCity, v1.VendorState 
  FROM Vendors v1 
     JOIN Vendors v2
	    ON v1.VendorCity = v2.VendorCity AND v1.VendorState = v2.VendorState AND v1.VendorID <> v2.VendorID
ORDER BY v1.VendorState, v1.VendorCity; 

--p113 A SELECT statement that joins four tables 
SELECT VendorName, InvoiceNumber, InvoiceDate, InvoiceLineItemAmount AS LineItemAmount, AccountDescription 
  FROM Vendors v
     JOIN Invoices i
	    ON v.VendorID = i.VendorID 
	 JOIN InvoiceLineItems li
		ON i.InvoiceID = li.InvoiceID 
	 JOIN GLAccounts gla
		ON li.AccountNo = gla.AccountNo
  WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0 
  ORDER BY VendorName, LineItemAmount DESC;

  --p115 A SELECT statement that joins the Vendors and Invoices tables 
  SELECT InvoiceNumber, VendorName 
  FROM Vendors v, Invoices i 
  WHERE v.VendorID = i.VendorID;

  SELECT InvoiceNumber, VendorName
    FROM Vendors v
       JOIN Invoices i
	      ON v.VendorID = i.VendorID

--A statement that joins four tables
SELECT VendorName, InvoiceNumber, InvoiceDate, InvoiceLineItemAmount AS LineItemAmount, AccountDescription 
  FROM Vendors AS v, Invoices AS i, InvoiceLineItems AS li, GLAccounts AS gla 
  WHERE v.VendorID = i.VendorID 
     AND i.InvoiceID = li.InvoiceID 
	 AND li.AccountNo = gla.AccountNo
	 AND InvoiceTotal - PaymentTotal - CreditTotal > 0 
  ORDER BY VendorName, LineItemAmount DESC;

  --p117 A SELECT statement that uses a left outer join 
SELECT VendorName, InvoiceNumber, InvoiceTotal 
  FROM Vendors v
	LEFT JOIN Invoices i 
		ON v.VendorID = i.VendorID 
  ORDER BY VendorName; 

--p119 
--A left outer join
SELECT DeptName, d.DeptNo, LastName 
	FROM Departments d
		LEFT JOIN Employees e 
			ON d.DeptNo = e.DeptNo;

--A right outer join
SELECT DeptName, e.DeptNo, LastName 
	FROM Departments d
		RIGHT JOIN Employees e 
			ON d.DeptNo = e.DeptNo;

--A full outer join
SELECT DeptName, d.DeptNo, e.DeptNo, LastName 
	FROM Departments d
		FULL JOIN Employees e
			ON d.DeptNo = e.DeptNo;

--p121 A SELECT statement that joins the three tables using left outer joins 
SELECT DeptName, LastName, ProjectNo 
	FROM Departments d
		LEFT JOIN Employees e 
			ON d.DeptNo = e.DeptNo 
		LEFT JOIN Projects p
			ON e.EmployeeID = p.EmployeeID 
	ORDER BY DeptName, LastName, ProjectNo;

--A SELECT statement that joins the three tables using full outer joins 
SELECT DeptName, LastName, ProjectNo 
	FROM Departments d
		FULL JOIN Employees e 
			ON d.DeptNo = e.DeptNo 
		FULL JOIN Projects p
			ON e.EmployeeID = p.EmployeeID 
	ORDER BY DeptName;

--A SELECT statement that combines an outer and an inner join 
SELECT DeptName, LastName, ProjectNo 
	FROM Departments d 
		JOIN Employees e
			ON d.DeptNo = e.DeptNo 
		LEFT JOIN Projects p
			ON e.EmployeeID = p.EmployeeID 
	ORDER BY DeptName; 

--p127 A union that combines invoice data from two different tables
	SELECT 'Active' AS Source, InvoiceNumber, InvoiceDate, InvoiceTotal 
		FROM ActiveInvoices
		WHERE InvoiceDate >= '01/01/2023' 
UNION
	SELECT 'Paid' AS Source, InvoiceNumber, InvoiceDate, InvoiceTotal 
		FROM PaidInvoices
		WHERE InvoiceDate >= '01/01/2023' 
		ORDER BY InvoiceTotal DESC;

--p129 A union that combines information from the Invoices table
	SELECT 'Active' AS Source, InvoiceNumber, InvoiceDate, InvoiceTotal 
		FROM Invoices
		WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0 
UNION
	SELECT 'Paid' AS Source, InvoiceNumber, InvoiceDate, InvoiceTotal 
		FROM Invoices
		WHERE InvoiceTotal - PaymentTotal 
		ORDER BY InvoiceTotal DESC;

--p131 A query that excludes rows from the first query if they also occur in the second query
	SELECT CustomerFirst, CustomerLast 
		FROM Customers
EXCEPT
	SELECT FirstName, LastName 
		FROM Employees
		ORDER BY CustomerLast; 

--A query that only includes rows that occur in both queries 
	SELECT CustomerFirst, CustomerLast 
		FROM Customers
INTERSECT
	SELECT FirstName, LastName 
		FROM Employees;

--p132 Exercises
--1.
SELECT *
	FROM Vendors v
	JOIN Invoices i
		ON v.VendorID = i.VendorID;

--2.
SELECT VendorName, InvoiceNumber, InvoiceDate, InvoiceTotal - (PaymentTotal + CreditTotal) AS Balance
	FROM Vendors v
		JOIN Invoices i
			ON v.VendorID = i.VendorID
	WHERE InvoiceTotal - (PaymentTotal + CreditTotal) <> 0
	ORDER BY VendorName ASC;

--3.
SELECT VendorName, DefaultAccountNo, AccountDescription
	FROM Vendors v
		JOIN GLAccounts g
			ON v.DefaultAccountNo = g.AccountNo
	ORDER BY AccountDescription, VendorName
	
--4. 
SELECT VendorName, InvoiceNumber, InvoiceDate, InvoiceTotal - (PaymentTotal + CreditTotal) AS Balance
	FROM Vendors v, Invoices i
	WHERE v.VendorID = i.VendorID
		AND InvoiceTotal - (PaymentTotal + CreditTotal) <> 0
	ORDER BY VendorName ASC;

--5.
SELECT VendorName AS Vendor, InvoiceDate AS Date, InvoiceNumber AS Number, InvoiceSequence AS #, InvoiceLineItemAmount AS LineItem
	FROM Vendors v
		JOIN Invoices i
			ON v.VendorID = i.VendorID
		JOIN InvoiceLineItems Ii
			ON i.InvoiceID = Ii.InvoiceID
	ORDER BY Vendor, Date, Number, #;

--6.
SELECT DISTINCT v1.VendorID, v1.VendorName, CONCAT(v1.VendorContactFName, ' ', v1.VendorContactLName) AS Name
	FROM Vendors v1
		JOIN vendors v2
			ON v1.VendorContactFName = v2.VendorContactFName
			AND v1.VendorID <> v2.VendorID
	ORDER BY Name;
-- a third comparison is included to exclude rows that match a vendor with itself. 
--To do that, this condition uses the not equal operator to compare the VendorID columns in the two tables. 

--7.
SELECT g.AccountNo, g.AccountDescription
	FROM GLAccounts g
		LEFT JOIN InvoiceLineItems Ii
			ON g.AccountNo = Ii.AccountNo
	WHERE Ii.AccountNo IS NULL
	ORDER BY g.AccountNo;

--8.
	SELECT VendorName, 'CA' AS VendorState
		FROM Vendors
		WHERE VendorState = 'CA'
UNION
	SELECT VendorName, 'Outside CA' AS VendorState
		FROM Vendors
		WHERE VendorState <> 'CA'
	ORDER BY VendorName;