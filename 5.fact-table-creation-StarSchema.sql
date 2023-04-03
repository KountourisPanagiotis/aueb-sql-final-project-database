CREATE DATABASE CAMPDW
COLLATE Greek_CI_AS;
GO

USE CAMPDW
GO

SET DATEFORMAT dmy;

CREATE TABLE categories (
    catCode CHAR(1) PRIMARY KEY,
    areaM2 INT NOT NULL,
    unitCost NUMERIC(4, 2) NOT NULL
);

CREATE TABLE campings (
    campCode CHAR(3) PRIMARY KEY,
    campName VARCHAR(50) NOT NULL,
    numOfEmp INT NOT NULL
);

CREATE TABLE customers (
    custCode INT PRIMARY KEY,
    custName VARCHAR(30) NOT NULL,
    custSurname VARCHAR(30) NOT NULL,
    custPhone VARCHAR(30) NOT NULL
);

CREATE TABLE Time (
    startDt DATE PRIMARY KEY,
	startYear INT,
	startMonthnum INT,
	startDaynum INT
);

INSERT INTO CAMPDW.dbo.categories (catCode, areaM2, unitCost)
SELECT DISTINCT catCode, areaM2, unitCost
FROM CAMPDB.dbo.categories

INSERT INTO CAMPDW.dbo.campings (campCode, campName, numOfEmp)
SELECT DISTINCT campCode, campName, numOfEmp
FROM CAMPDB.dbo.campings

INSERT INTO CAMPDW.dbo.customers (custCode, custName, custSurname, custPhone)
SELECT DISTINCT custCode, custName, custSurname, custPhone
FROM CAMPDB.dbo.customers

INSERT INTO CAMPDW.dbo.Time (startDt, startYear, startMonthnum, startDaynum) 
SELECT DISTINCT startDt, YEAR(startDt) AS startYear, MONTH(startDt) AS startMonthnum, 
DAY(startDt) AS startDaynum FROM CAMPDB.dbo.spotrentals WHERE startDt IS NOT NULL;

CREATE TABLE spotrentals (
    bookCode INT NOT NULL,
    campCode CHAR(3) NOT NULL,
    empNo INT NOT NULL,
    startDt DATE NOT NULL,
    catCode CHAR(1) NOT NULL,
    custCode INT NOT NULL,
    noPers INT NOT NULL,
    PRIMARY KEY (bookCode, campCode, empNo, startDt),
    FOREIGN KEY (catCode) REFERENCES categories(catCode),
    FOREIGN KEY (campCode) REFERENCES campings(campCode),
    FOREIGN KEY (custCode) REFERENCES customers(custCode),
    FOREIGN KEY (startDt) REFERENCES Time(startDt)
);

INSERT INTO CAMPDW.dbo.spotrentals
SELECT bookCode, campCode, empNo, startDt, catCode, custCode, noPers
FROM CAMPDB.dbo.campData

