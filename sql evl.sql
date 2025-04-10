select * from orders;
select year(orderDate) years,monthname(orderDate) as months,count(orderNumber) from orders group by years,months;

create table emp_udf(emp_id  int primary key,Name varchar(50),DOB date);
INSERT INTO Emp_UDF VALUES (1,"Piyush", "1990-03-30"), (2,"Aman", "1992-08-15"), (3,"Meena", "1998-07-28"), 
(4,"Ketan", "2000-11-21"), (5,"Sanjay", "1995-05-21"); 
select * from emp_udf;
DELIMITER //

CREATE FUNCTION calculate_age(dob DATE) 
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE years INT;
    DECLARE months INT;
    DECLARE age_in_years_months VARCHAR(50);

    SET years = TIMESTAMPDIFF(YEAR, dob, CURDATE());
    SET months = TIMESTAMPDIFF(MONTH, dob, CURDATE()) % 12;

    SET age_in_years_months = CONCAT(years, ' years ', months, ' months');
    RETURN age_in_years_months;
END //

DELIMITER ;

SELECT Name, DOB, calculate_age(DOB) AS Age 
FROM emp_udf;
-- day 13
select customerNumber,customerName from customers where customerNumber not in(select customerNumber from orders);

select c.customerNumber as cn,customerName as ca,count(orderNumber) from customers c left join orders o on c.customerNumber = o.customerNumber group by cn,ca
union all
select ordernumber as an,c.customerNumber as cn,count(orderNumber)  from orders o left join customers c on o.customerNumber = c.customerNumber group by an,cn;

SELECT OrderNumber, MAX(quantityOrdered) AS SecondHighestQuantity
FROM orderdetails
WHERE quantityOrdered < (
    SELECT MAX(quantityOrdered)
    FROM orderdetails AS SubOrders
    WHERE SubOrders.OrderNumber = orderdetails.OrderNumber
)
GROUP BY OrderNumber;

select avg(buyPrice) from products;

select productLine,count(productLine) as pd from products where buyPrice in(select buyPrice from products where buyPrice > 54.395182) group by productLine order by pd desc