

CREATE DATABASE CAMPDB
COLLATE Greek_CI_AS;
GO 

USE CAMPDB
GO 

CREATE TABLE campData
(bookCode INT, bookDt DATE, payCode INT, payMethod CHAR(2), custCode INT, custName VARCHAR(30),
custSurname VARCHAR(30), custPhone VARCHAR(20),staffNo INT,staffName VARCHAR(30),
staffSurname VARCHAR(30),totalCost NUMERIC(19,2), campCode CHAR(3), campName VARCHAR(50),
numOfEmp INT, empNo INT,catCode CHAR(1), areaM2 INT, unitCost NUMERIC(4,2),
startDt DATE, endDt DATE, noPers INT,costPerRental NUMERIC(19,2)); 

SET DATEFORMAT dmy;
BULK INSERT campData
FROM 'C:\campData\campData.txt'
WITH (FIRSTROW = 2,FIELDTERMINATOR= ',', ROWTERMINATOR = '\n');