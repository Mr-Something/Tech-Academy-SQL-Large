


/*PROCEDURE #1
*/
GO
CREATE PROC Sharpstown_LostTribe
AS
BEGIN

SELECT Number_of_Copies AS 'Sharpstown Copies of "The Lost Tribe"' 
	FROM Book_Copies 
	WHERE bookID = 1003 AND BranchID = 2;

END



/*PROCEDURE #2
*/
GO
CREATE PROC LostTribe_Copies
AS
BEGIN

SELECT 
	a2.BranchName AS 'Branch Name', a1.Number_of_Copies AS 'Number of Copies'
	FROM Book_Copies a1
	INNER JOIN Library_Branch a2 ON a2.BranchID = a1.BranchID
	WHERE bookID = 1003;

END



/*PROCEDURE #3
*/
GO
CREATE PROC Nothing_CheckedOut
AS
BEGIN

SELECT a1.Name
	FROM Borrower a1
	WHERE a1.CardNo NOT IN
		(SELECT a2.CardNo
		FROM Book_Loans a2)
;

END



/*PROCEDURE #4
*/
GO
CREATE PROC Sharpstown_Due_Today
AS
BEGIN

SELECT a1.Name, a1.Address, a2.Title
	FROM Borrower a1
	INNER JOIN Book_Loans a3 ON a3.CardNo = a1.CardNo
	INNER JOIN Books a2 ON a2.BookID = a3.BookID
	WHERE a3.BranchID = 2 AND a3.DateDue = (select convert(varchar(10), getdate(), 120))
;

END





/*PROCEDURE #5
*/
GO
CREATE PROC books_CheckedOut
AS
BEGIN

SELECT
	COUNT(BookLoans.BranchID) AS 'Books Checked Out',
	Library_Branch.BranchName AS 'Branch Name'
	FROM Book_Loans BookLoans
	INNER JOIN Library_Branch ON Library_Branch.BranchID = BookLoans.BranchID
	GROUP BY BranchName
;

END



/*PROCEDURE #6
*/
GO
CREATE PROC Heavy_Readers
AS
BEGIN

SELECT
	a2.Name, a2.Address,
	COUNT(a1.CardNo) AS 'Books Checked Out'
	FROM Borrower a2
	INNER JOIN Book_Loans a1 ON a1.CardNo = a2.CardNo
	GROUP BY a1.CardNo, a2.Name, a2.Address
	HAVING (COUNT(a1.CardNo) >= 5)
;

END



/*PROCEDURE #7
*/
GO
CREATE PROC King_at_Central
AS
BEGIN

SELECT
	a1.Title, a2.Number_of_Copies
	FROM Books a1
	INNER JOIN Book_Authors a3 ON a3.BookID = a1.BookID
	INNER JOIN Book_Copies a2 ON a2.BookID = a1.BookID
	INNER JOIN Library_Branch a4 ON a4.BranchID = a2.BranchID
	WHERE a3.AuthorName = 'Stephen King' AND a4.BranchID = 1
;

END