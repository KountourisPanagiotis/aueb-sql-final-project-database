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