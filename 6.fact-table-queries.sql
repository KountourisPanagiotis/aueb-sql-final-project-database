SELECT TOP 100 customers.custCode, customers.custName, customers.custSurname, 
SUM((DATEDIFF(day, spotrentals.startDt, spotrentals.endDt) + 1) * categories.unitCost * spotrentals.noPers) AS totalRentings
FROM customers
INNER JOIN spotrentals ON customers.custCode = spotrentals.custCode
INNER JOIN categories ON spotrentals.catCode = categories.catCode
GROUP BY customers.custCode, customers.custName, customers.custSurname
ORDER BY totalRentings DESC;

SELECT campings.campName, spotrentals.catCode, 
SUM((DATEDIFF(day, spotrentals.startDt, spotrentals.endDt) + 1) * 
categories.unitCost * spotrentals.noPers) AS bookingEarnings
FROM spotrentals 
JOIN categories ON spotrentals.catCode = categories.catCode 
JOIN campings ON spotrentals.campCode = campings.campCode
WHERE YEAR(spotrentals.startDt) = 2000 
GROUP BY campings.campName, spotrentals.catCode;

SELECT campings.campName,Time.startMonthnum AS bookingMonth, 
SUM((DATEDIFF(day, spotrentals.startDt, spotrentals.endDt) + 1) * 
categories.unitCost * spotrentals.noPers) AS bookingValue
FROM spotrentals 
INNER JOIN categories ON spotrentals.catCode = categories.catCode 
INNER JOIN campings ON spotrentals.campCode = campings.campCode
INNER JOIN Time ON spotrentals.startDt = Time.startDt
WHERE Time.startYear = 2018
GROUP BY campings.campName, Time.startMonthnum;

SELECT startYear,campName,catCode, COUNT(custCode) AS number_of_customers
FROM Time INNER JOIN spotrentals ON Time.startDt = spotrentals.startDt
INNER JOIN campings ON spotrentals.campCode = campings.campCode
GROUP BY ROLLUP (startYear,campName,catCode)
ORDER BY startYear,campName,catCode;

SELECT startYear,campName, spotrentals.catCode , SUM(unitCost) AS loans_sum
FROM Time
INNER JOIN spotrentals ON Time.startDt = spotrentals.startDt
INNER JOIN campings ON spotrentals.campCode = campings.campCode
INNER JOIN categories ON spotrentals.catCode = categories.catCode
GROUP BY CUBE (startYear,campName, spotrentals.catCode)
ORDER BY startYear,campName,catCode;