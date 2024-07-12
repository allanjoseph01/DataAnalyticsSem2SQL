create database Salesdb;
use Salesdb;
create table productlines(
productLine VARCHAR(50) primary key,
textDescription varchar(4000),
htmlDescription mediumtext,
image mediumblob
);

create table products(
productCode varchar(15) primary key,
productName  varchar(70) not null,
productLine VARCHAR(50),
productScale VARCHAR(10) NOT NULL,
productVendor VARCHAR(50) NOT NULL,
productDescription TEXT NOT NULL,
quantityInStock SMALLINT NOT NULL,
buyPrice DECIMAL(10, 2) NOT NULL,
MSRP DECIMAL(10, 2) NOT NULL,
constraint fk1 foreign key (productLine)
			   references productlines(productLine)
);



create table offices(
officeCode VARCHAR(10) PRIMARY KEY,
city VARCHAR(50) NOT NULL,
phone VARCHAR(50) NOT NULL,
addressLine1 VARCHAR(50) NOT NULL,
addressLine2 VARCHAR(50),
state VARCHAR(50),
country VARCHAR(50) NOT NULL,
postalCode VARCHAR(15) NOT NULL,
territory VARCHAR(10) NOT NULL
);

create table employees(
employeeNumber INT PRIMARY KEY,
lastName VARCHAR(50) NOT NULL,
firstName VARCHAR(50) NOT NULL,
extension VARCHAR(10) NOT NULL,
email VARCHAR(100) NOT NULL,
officeCode VARCHAR(10),
reportsTo INT,
jobTitle VARCHAR(50) NOT NULL,
constraint fk2 foreign key (officeCode)
			   references offices(officeCode),
constraint fk3 foreign key (reportsTo)
			   references employees(employeeNumber)
);

create table customers(
customerNumber INT PRIMARY KEY,
customerName VARCHAR(50) NOT NULL,
contactLastName VARCHAR(50) NOT NULL,
contactFirstName VARCHAR(50) NOT NULL,
phone VARCHAR(50) NOT NULL,
addressLine1 VARCHAR(50) NOT NULL,
addressLine2 VARCHAR(50),
city VARCHAR(50) NOT NULL,
state VARCHAR(50),
postalCode VARCHAR(15),
country VARCHAR(50) NOT NULL,
salesRepEmployeeNumber INT,
creditLimit DECIMAL(10, 2),
constraint fk4 foreign key(salesRepEmployeeNumber)
			   references employees(employeeNumber)
);

create table orders(
orderNumber INT PRIMARY KEY,
orderDate DATE NOT NULL,
requiredDate DATE NOT NULL,
shippedDate DATE,
status VARCHAR(15) NOT NULL,
comments TEXT,
customerNumber INT,
constraint fk5 foreign key(customerNumber)
			references customers(customerNumber)
);

create table orderdetails(
orderNumber INT,
productCode VARCHAR(15),
quantityOrdered INT NOT NULL,
priceEach DECIMAL(10, 2) NOT NULL,
orderLineNumber SMALLINT NOT NULL,
constraint fk6 foreign key(orderNumber)
references  orders(orderNumber),
constraint fk7 foreign key(productCode)
references products(productCode),
primary key(orderNumber, productCode)
);

create table payments(
customerNumber INT,
checkNumber VARCHAR(50) PRIMARY KEY,
paymentDate DATE NOT NULL,
amount DECIMAL(10, 2) NOT NULL,
constraint fk8  foreign key(customerNumber)
references customers(customerNumber)
);

select * from productlines;

insert into productlines values 
('Classic Cars', 'Cars from the 1950s and 1960s', null, null),
('Motorcycles', 'A range of motorcycles', null, null);

insert into products values
('S10_1678', '1969 Harley Davidson Ultimate Chopper', 'Motorcycles', '1:10', 'Min Lin Diecast', 'This replica features working kickstand, front suspension, gear-shift lever.', 7933, 48.81, 95.70);

insert into offices values
('1', 'San Francisco', '+1 650 219 4782', '100 Market Street', 'Suite 300', 'CA', 'USA', '94080', 'NA');

insert into employees values 
(1002, 'Murphy', 'Diane', 'x5800', 'dmurphy@classicmodelcars.com', '1', NULL, 'President');

insert into  customers values 
(103, 'Atelier graphique', 'Schmitt', 'Carine', '40.32.2555', '54', 'rue Royale', 'Nantes', 'France', 1370, 21000.00,null,null);

insert into orders values
(10100, '2003-01-06', '2003-01-13', '2003-01-10', 'Shipped', 103,null);

insert into orderdetails values (10100, 'S10_1678', 30, 95.70, 1);

insert into payments values (103, 'HQ336336', '2004-10-19', 6066.78);