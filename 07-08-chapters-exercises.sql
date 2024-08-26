USE AP;
GO

--chap.7 Exercises
--1.
SELECT *
	INTO VendorCopy
	FROM Vendors;

SELECT *
	INTO InvoiceCopy
	FROM Invoices;

--2.
INSERT INTO InvoiceCopy
		(VendorID, InvoiceTotal, TermsID, InvoiceNumber, PaymentTotal, InvoiceDueDate, InvoiceDate, CreditTotal, PaymentDate)
	VALUES
		(32, 434.58, 2, 'AX-014-027', 0.00, '2023-05-08', '2023-04-21', 0.00, NULL);

--3.
INSERT INTO VendorCopy
SELECT VendorName, VendorAddress1, VendorAddress2, 
		VendorCity, VendorState, VendorZipCode, 
		VendorPhone, VendorContactLName, VendorContactFName, 
		DefaultTermsID, DefaultAccountNo
	FROM Vendors
	WHERE VendorState <> 'CA';

--4.
UPDATE VendorCopy
	SET DefaultAccountNo = 403
	WHERE DefaultAccountNo = 400;

--5. 
UPDATE InvoiceCopy
	SET PaymentDate = GETDATE(),
		PaymentTotal = InvoiceTotal - CreditTotal
	WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0; 


SELECT *
	FROM InvoiceCopy;

SELECT *
	FROM VendorCopy;

--6.
UPDATE InvoiceCopy
	SET TermsID = 2
	FROM InvoiceCopy ic
	JOIN Vendors v
		ON ic.VendorID = v.VendorID
	WHERE v.DefaultTermsID = 2

/*--answer from the book 
UPDATE InvoiceCopy
SET TermsID = 2
WHERE VendorID IN
    (SELECT VendorID
     FROM VendorCopy
     WHERE DefaultTermsID = 2);
*/

--7.
UPDATE InvoiceCopy
	SET TermsID = 2
	FROM InvoiceCopy ic
	JOIN Vendors v
		ON ic.VendorID = v.VendorID
	WHERE v.DefaultTermsID = 2

--8.
DELETE VendorCopy
	WHERE VendorState = 'MN';

--9.
DELETE VendorCopy
	WHERE VendorState NOT IN
		(SELECT DISTINCT VendorState
			FROM Vendors v
			JOIN Invoices i
				ON i.VendorID = v.VendorID);

--chap.8 Exercises
--1.
SELECT InvoiceTotal,
	CAST(InvoiceTotal AS decimal(17,2)),
	CAST(InvoiceTotal AS varchar),
	CONVERT(decimal(17,2), InvoiceTotal),
	CONVERT(varchar, InvoiceTotal, 1)
	FROM Invoices;
	
--2.
SELECT InvoiceDate,
	CAST(InvoiceDate AS varchar),
	TRY_CONVERT(varchar, InvoiceDate, 1),
	TRY_CONVERT(varchar, InvoiceDate, 10)
	FROM Invoices;
