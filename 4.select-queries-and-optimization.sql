SELECT payMethod, COUNT(bookCode) AS total_bookings FROM
payments INNER JOIN bookings ON payments.paycode=bookings.paycode
GROUP BY payMethod;

SELECT TOP 1 staffname, staffsurname, count(bookcode) as book_count
FROM staff INNER JOIN bookings
ON staff.staffNo=bookings.staffno
GROUP BY staffname, staffsurname
ORDER BY count(bookcode) DESC;

SELECT COUNT(bookings.bookCode) AS total_A_bookings
FROM bookings INNER JOIN spotrentals ON bookings.bookCode=spotrentals.bookCode
INNER JOIN emplacements ON spotrentals.campCode=emplacements.campCode
AND spotrentals.empNo=emplacements.empNo
WHERE catCode='A';

SELECT custSurname , custName , count(bookCode) AS bookings_for_year_2000
FROM customers INNER JOIN bookings ON customers.custCode=bookings.custCode
WHERE bookDt BETWEEN '1999-12-31' AND '2001-01-01'
GROUP BY custSurname, custName
ORDER BY custSurname;

CREATE INDEX index_custCode_bookDt ON bookings (bookDt,custCode);