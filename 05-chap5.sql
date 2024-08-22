-- Chap 5
-- p137
--count of unpaid invoices, calcualte total due
SELECT COUNT(*) AS NumberOfInvoices, SUM(InvoiceTotal - (PaymentTotal + CreditTotal)) AS TotalDue
--SELECT InvoiceTotal - (PaymentTotal + CreditTotal) AS TotalDue
	FROM Invoices
	WHERE InvoiceTotal - (PaymentTotal + CreditTotal) >0;

--P139
--AFTER 7/1/22 # of invoices, avg inv amt, tot inv amt
SELECT 'After 7/1/2022' AS SelectionDate,
		COUNT(*) AS NumberOfInvoices,
		AVG(InvoiceTotal) AS AverageInvoiceAmount,
		SUM(InvoiceTotal) AS TotalInvoiceAmount
	FROM Invoices
	WHERE InvoiceDate > '2022-07-01';

-- using the DISTINCT keyword 
-- Total # of vendors, total invoices, avg amount, total amt, since 7/1/2022
SELECT COUNT(DISTINCT VendorID) AS NumberOfVendors,
		COUNT(VendorID) AS NumberOfInvoices,
		AVG(InvoiceTotal) AS AverageInvoiceAmount,
		SUM(InvoiceTotal) AS TotalInvoiceAmount
	FROM Invoices
	WHERE InvoiceDate > '2022-07-01';

--p141 Goup by and Having clauses
--Avg income amt by vendor
-- Return vendorID, Avg invoice total
-- return only those greater than 2000
SELECT VendorID, AVG(InvoiceTotal) as AvgInvoiceTotal
	FROM Invoices	
	GROUP BY VendorID
	HAVING AVG(InvoiceTotal) > 2000
	ORDER BY AvgInvoiceTotal DESC;

--143
--SUMMARY QUERY COUNTING THE NUMBER OF INVOICES BY VENDOR
--GROUP BY VENDOR, COUNT THE INVOICES
SELECT VendorID, COUNT(*) AS InvoiceQty
	FROM	Invoices
	GROUP BY VendorID;

-- how about only showing the counts greater than 1? (vendors w/ mote than one invoice)
SELECT VendorID, COUNT(*) AS InvoiceQty
	FROM	Invoices
	GROUP BY VendorID
	HAVING COUNT(*) > 1;

-- A Join w/ a group by, order by
-- # of invoices and the avg inv amt for vendors in each state and city
SELECT VendorState, VendorCity, COUNT(*) AS InvoiceQty, AVG(InvoiceTotal) AS InvoiceAVG
	FROM Invoices i
	JOIN Vendors v
		ON i.VendorID = v.VendorID
	GROUP BY VendorState, VendorCity
	--ORDER BY VendorState, VendorCity;

--145 SUMMARY QUERY W/ A SEARCH CONDITION IN THE HAVING CLAUSE
SELECT VendorName, COUNT(*) AS InvoiceQty, AVG(InvoiceTotal) AS InvoiceAVG
	FROM Vendors v
	JOIN Invoices i 
		ON v.VendorID = i.VendorID
	GROUP BY VendorName
	HAVING AVG(InvoiceTotal) > 500
	ORDER BY InvoiceQty DESC;

SELECT VendorName, COUNT(*) AS InvoiceQty, AVG(InvoiceTotal) AS InvoiceAVG
	FROM Vendors v
	JOIN Invoices i 
		ON v.VendorID = i.VendorID
	WHERE InvoiceTotal > 500
	GROUP BY VendorName
	ORDER BY InvoiceQty DESC;

--P147 COMPARE having and where clause
SELECT InvoiceDate, COUNT(*) AS InvoiceQty, SUM(InvoiceTotal) AS InvoiceSum 	FROM Invoices 	GROUP BY InvoiceDate	HAVING InvoiceDate BETWEEN '2023-01-01' 		AND '2023-01-31' 		AND COUNT(*) > 1		AND SUM(InvoiceTotal) > 100 	ORDER BY InvoiceDate DESC;-- same thing using whereSELECT InvoiceDate, COUNT(*) AS InvoiceQty, SUM(InvoiceTotal) AS InvoiceSum 	FROM Invoices 		WHERE InvoiceDate BETWEEN '2023-01-01' AND '2023-01-31' 			GROUP BY InvoiceDate	HAVING  COUNT(*) > 1		AND SUM(InvoiceTotal) > 100 	ORDER BY InvoiceDate DESC;--P148 SQL server extensions - won't see these in MySQL-- ROLLUP operator - add summary rowas at the bottom of result sets--p149SELECT VendorID, COUNT(*) AS InvoiceCount, SUM(InvoiceTotal) AS InvoiceTotal	FROM Invoices 	GROUP BY ROLLUP(VendorID);--p150 CUBE operator--151SELECT VendorID, COUNT(*) AS InvoiceCount, SUM(InvoiceTotal) AS InvoiceTotal	FROM Invoices 	GROUP BY CUBE(VendorID);SELECT VendorState, VendorCity, COUNT(*) AS QtyVendors 	FROM Vendors	WHERE VendorState IN ('IA', 'NJ') 	GROUP BY CUBE (VendorState, VendorCity) 	ORDER BY VendorState DESC, VendorCity DESC;--p156. Exercises--1. two columns from the Invoices table: VendorID and PaymentSum, -- where PaymentSum is the sum of the PaymentTotal column. Group the result set by VendorIDSELECT VendorID, SUM(PaymentTotal) AS PaymentSum	FROM Invoices	GROUP BY VendorID;--2.  SELECT statement that returns two columns: VendorName and PaymentSum, --where PaymentSum is the sum of the PaymentTotal column--Group the result set by VendorName. Return only 10 rows, --corresponding to the 10 vendors who¡¯ve been paid the mostSELECT TOP 10 VendorName, SUM(PaymentTotal) AS PaymentSum	FROM Invoices i	JOIN Vendors v		ON i.VendorID = v.VendorID	GROUP BY VendorName	ORDER BY PaymentSum DESC;-- 3.  Write a SELECT statement that returns three columns: VendorName, InvoiceCount, and InvoiceSum. --InvoiceCount is the count of the number of invoices, and InvoiceSum is the sum of the InvoiceTotal column. --Group the result set by vendor. --Sort the result set so the vendor with the highest number of invoices appears first.SELECT VendorName, COUNT(InvoiceTotal) AS InvoiceCount, SUM(InvoiceTotal) AS InvoiceSum	FROM Invoices i	JOIN Vendors v		ON i.VendorID = v.VendorID	GROUP BY v.VendorID	ORDER BY InvoiceCount DESC;----------------------------------------------------4. SELECT g.AccountDescription, COUNT(*) AS LineItemCount, SUM(il.InvoiceLineItemAmount) AS LineItemSum	FROM GLAccounts g	JOIN InvoiceLineItems il		ON g.AccountNo = il.AccountNo	GROUP BY g.AccountDescription	HAVING COUNT(*) > 1	ORDER BY LineItemCount DESC;--5. Modify the solution to exercise 4 to filter for invoices dated from October 1, 2022 to December 31, 2022.SELECT g.AccountDescription, COUNT(il.AccountNo) AS LineItemCount, SUM(il.InvoiceLineItemAmount) AS LineItemSum	FROM GLAccounts g	JOIN InvoiceLineItems il		ON g.AccountNo = il.AccountNo	JOIN Invoices i		ON i.InvoiceID = il.InvoiceID	WHERE i.InvoiceDate BETWEEN '2022-10-01' AND '2022-12-31'	GROUP BY g.AccountDescription	HAVING COUNT(il.AccountNo) > 1	ORDER BY LineItemCount DESC;--6. What is the total amount invoiced for each AccountNo? -- Use the ROLLUP operator to include a row that gives the grand total.SELECT SUM(InvoiceLineItemAmount) as TotalAmountInvoiced, g.AccountNo	FROM InvoiceLineItems il		JOIN GLAccounts g			ON il.AccountNo = g.AccountNo	GROUP BY ROLLUP (g.AccountNo);--7. Write a SELECT statement four columns: VendorName, Account-Description, LineItemCount, and LineItemSum.--LineItemCount is the row count, and LineItemSum is the sum of the InvoiceLineItemAmount column.--For each vendor and account, return the number and sum of line items, sorted first by vendor, then by account description.SELECT VendorName, Account-Description, COUNT(LineItemCount) AS LineItemCount, SUM(InvoiceLineItemAmount) AS LineItemSum	FROM Vendors v	JOIN  		ON --CHAPTER 6. p160 Subqueries-- Invoices w/ a total greater than the avg InvoiceTotalSELECT InvoiceNumber, InvoiceDate, InvoiceTotal	FROM Invoices	WHERE InvoiceTotal > (		SELECT AVG(InvoiceTotal)			FROM Invoices	)		ORDER BY InvoiceTotal;--p163. Inner jion and a subquery which does the same-- Join invoice and vendors, display the inv#, date, and total for invoices for vendors in CASELECT InvoiceNumber, InvoiceDate, InvoiceTotal 	FROM Invoices i	JOIN Vendors v		ON v.VendorID = i.VendorID	WHERE VendorState = 'CA'	ORDER BY InvoiceDate;-- the same thing with subqueurySELECT InvoiceNumber, InvoiceDate, InvoiceTotal 	FROM Invoices 	WHERE VendorID IN (		SELECT VendorID			FROM Vendors			WHERE VendorState = 'CA'	)	ORDER BY InvoiceDate;