-- Camping database
-- Query Δημιουργίας Βάσης στον MySQL server
CREATE DATABASE CAMPDB CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
  
USE CAMPDB;

CREATE TABLE campings  
(campCode CHAR(3) PRIMARY KEY, campName VARCHAR(50) NOT NULL,  
numOfEmp INT NOT NULL);  
  
CREATE TABLE categories  
(catCode CHAR(1) PRIMARY KEY, areaM2 INT NOT NULL,  
unitCost NUMERIC(4,2) NOT NULL);  
  
CREATE TABLE staff  
(staffNo INT PRIMARY KEY,  
staffName VARCHAR(30) NOT NULL,  
staffSurname VARCHAR(30) NOT NULL);  
  
CREATE TABLE customers  
(custCode INT PRIMARY KEY,  
custName VARCHAR(30) NOT NULL,  
custSurname VARCHAR(30) NOT NULL,  
custPhone VARCHAR(30) NOT NULL);  
  
CREATE TABLE payments  
(payCode INT PRIMARY KEY,  
payMethod CHAR(2) NOT NULL);  
  
CREATE TABLE emplacements  
(campCode CHAR(3) NOT NULL,  
empNo INT NOT NULL,  
catCode CHAR(1) NOT NULL,  
PRIMARY KEY (campCode,empNo),  
FOREIGN KEY (campCode) REFERENCES campings(campCode),  
FOREIGN KEY (catCode) REFERENCES categories(catCode));  
  
CREATE TABLE bookings  
(bookCode INT PRIMARY KEY,  
bookDt DATE NOT NULL,  
payCode INT NOT NULL,  
custCode INT NOT NULL,  
staffNo INT NOT NULL,  
FOREIGN KEY (payCode) REFERENCES payments(payCode),  
FOREIGN KEY (custCode) REFERENCES customers(custCode),  
FOREIGN KEY (staffNo) REFERENCES staff(staffNo));  
  
CREATE TABLE spotrentals  
(bookCode INT NOT NULL,  
campCode CHAR(3) NOT NULL,  
empNo INT NOT NULL,  
startDt DATE NOT NULL,  
endDt DATE NOT NULL,  
noPers INT NOT NULL,  
PRIMARY KEY (bookCode,campCode,empNo,startDt),  
FOREIGN KEY (bookCode) REFERENCES bookings(bookCode),  
FOREIGN KEY (campCode,empNo) REFERENCES emplacements (campCode,empNo));

CREATE INDEX index_custCode_bookDt ON bookings (bookDt,custCode);

-- Δημιουργία User 
CREATE USER 'user1'@'localhost' IDENTIFIED BY 'password1';
GRANT ALL PRIVILEGES ON CAMPDB.* TO 'user1'@'localhost';
FLUSH PRIVILEGES;

-- Επιβεβαιώνουμε ότι έχει τα privileges
SHOW GRANTS FOR 'user1'@'localhost';

-- Δημιουργία campData βοηθητικού πίνακα για φόρτωση διόρθωση δεδομενων
CREATE TABLE campData  
(bookCode INT, bookDt DATE, payCode INT, payMethod CHAR(2), custCode INT, custName VARCHAR(30),  
custSurname VARCHAR(30), custPhone VARCHAR(20),staffNo INT,staffName VARCHAR(30),  
staffSurname VARCHAR(30),totalCost NUMERIC(19,2), campCode CHAR(3), campName VARCHAR(50),  
numOfEmp INT, empNo INT,catCode CHAR(1), areaM2 INT, unitCost NUMERIC(4,2),  
startDt DATE, endDt DATE, noPers INT,costPerRental NUMERIC(19,2));

-- Data Insertion του `campData.txt` από τον allowed για bulk load insertion φάκελο MySQL 
-- τον οποίο βλέπουμε με την εντολή  `SHOW VARIABLES LIKE 'secure_file_priv'`;  (1311108 rows):
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/campData.txt'
INTO TABLE campData
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(bookCode, @varBookDt, payCode, payMethod, custCode, custName, custSurname, custPhone, staffNo, staffName, staffSurname, totalCost, campCode, campName, numOfEmp, empNo, catCode, areaM2, unitCost, @varStartDt, @varEndDt, noPers, costPerRental)
SET bookDt = STR_TO_DATE(@varBookDt, '%d/%m/%Y'),
    startDt = STR_TO_DATE(@varStartDt, '%d/%m/%Y'),
    endDt = STR_TO_DATE(@varEndDt, '%d/%m/%Y');
-- Εδώ τα dates είναι σε μορφή `dd/mm/yy` και τα μετατρέψαμε σε  `yyyy/mm/dd` επιλέγοντας 
-- το κάθε position στo csv κατά το  `LOAD`  με `@varBookDt`  , `@varStartDt` , `@varEndDt`

-- Μοιράζουμε τα data με τα διορθωμένα  `Date` στους αντιστοιχους πίνακες 
INSERT INTO campings  
SELECT DISTINCT campCode,campName,numOfEmp FROM campData;  
  
INSERT INTO categories  
SELECT DISTINCT catCode,areaM2,unitCost FROM campData;  
  
INSERT INTO staff  
SELECT DISTINCT staffNo,staffName,staffSurname FROM campData;  
  
INSERT INTO customers  
SELECT DISTINCT custCode,custName,custSurname,custPhone FROM campData;  
  
INSERT INTO payments  
SELECT DISTINCT payCode,payMethod FROM campData;  
  
INSERT INTO emplacements  
SELECT DISTINCT campCode,empNo,catCode FROM campData;  
  
INSERT INTO bookings  
SELECT DISTINCT bookCode,bookDt,payCode,custCode,staffNo FROM campData;  
  
INSERT INTO spotrentals  
SELECT DISTINCT bookCode,campCode,empNo,startDt,endDt,noPers FROM campData;