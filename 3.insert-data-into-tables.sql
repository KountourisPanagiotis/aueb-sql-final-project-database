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