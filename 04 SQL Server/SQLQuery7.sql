CREATE TABLE sales.promotions (
    promotion_id INT PRIMARY KEY IDENTITY (1, 1),
    promotion_name VARCHAR (255) NOT NULL,
    discount NUMERIC (3, 2) DEFAULT 0,
    start_date DATE NOT NULL,
    expired_date DATE NOT NULL
); 

-- Insertion into table
INSERT INTO sales.promotions(
	promotion_name,
	discount,
	start_date,
	expired_date
	)
VALUES
	(
        '2018 Summer Promotion',
        0.15,
        '20180601',
        '20180901'
    );

SELECT * FROM sales.promotions;

INSERT INTO sales.promotions (
	promotion_name,
	discount,
	start_date,
	expired_date
	) OUTPUT inserted.promotion_id
VALUES
	(
        '2018 Fall Promotion',
        0.15,
        '20181001',
        '20181101'
    );


INSERT INTO 
	sales.promotions ( 
		promotion_name, discount, start_date, expired_date
	)
OUTPUT inserted.promotion_id
VALUES
	('2020 Summer Promotion',0.25,'20200601','20200901'),
	('2020 Fall Promotion',0.10,'20201001','20201101'),
	('2020 Winter Promotion', 0.25,'20201201','20210101');


CREATE TABLE sales.addresses (
    address_id INT IDENTITY PRIMARY KEY,
    street VARCHAR (255) NOT NULL,
    city VARCHAR (50),
    state VARCHAR (25),
    zip_code VARCHAR (5)
);   


INSERT INTO sales.addresses (street, city, state, zip_code) 
SELECT TOP 10
    street,
    city,
    state,
    zip_code
FROM
    sales.customers
ORDER BY
    first_name,
    last_name; 

SELECT * FROM sales.addresses;


INSERT INTO sales.addresses (street, city, state, zip_code) 
SELECT TOP (10) PERCENT
    street,
    city,
    state,
    zip_code
FROM
    sales.customers
ORDER BY
    first_name,
    last_name;


CREATE TABLE sales.taxes (
	tax_id INT PRIMARY KEY IDENTITY (1, 1),
	state VARCHAR (50) NOT NULL UNIQUE,
	state_tax_rate DEC (3, 2),
	avg_local_tax_rate DEC (3, 2),
	combined_rate AS state_tax_rate + avg_local_tax_rate,
	max_local_tax_rate DEC (3, 2),
	updated_at datetime
);

UPDATE sales.taxes
SET updated_at = GETDATE();

select * from sales.taxes;

UPDATE sales.taxes
SET max_local_tax_rate += 0.02,
    avg_local_tax_rate += 0.01
WHERE
    max_local_tax_rate = 0.01;

-- Upadate Joining
DROP TABLE IF EXISTS sales.targets;

CREATE TABLE sales.targets
(
    target_id  INT	PRIMARY KEY, 
    percentage DECIMAL(4, 2) 
        NOT NULL DEFAULT 0
);

INSERT INTO 
    sales.targets(target_id, percentage)
VALUES
    (1,0.2),
    (2,0.3),
    (3,0.5),
    (4,0.6),
    (5,0.8);


CREATE TABLE sales.commissions
(
    staff_id    INT PRIMARY KEY, 
    target_id   INT, 
    base_amount DECIMAL(10, 2) 
        NOT NULL DEFAULT 0, 
    commission  DECIMAL(10, 2) 
        NOT NULL DEFAULT 0, 
    FOREIGN KEY(target_id) 
        REFERENCES sales.targets(target_id), 
    FOREIGN KEY(staff_id) 
        REFERENCES sales.staffs(staff_id),
);

INSERT INTO 
    sales.commissions(staff_id, base_amount, target_id)
VALUES
    (1,100000,2),
    (2,120000,1),
    (3,80000,3),
    (4,900000,4),
    (5,950000,5);

select * from sales.commissions;

UPDATE
    sales.commissions
SET
    sales.commissions.commission = 
        c.base_amount * t.percentage
FROM 
    sales.commissions c
    INNER JOIN sales.targets t
        ON c.target_id = t.target_id;

select * from sales.commissions;

DELETE TOP (10) PERCENT FROM sales.taxes;


CREATE TABLE sales.category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL,
    amount DECIMAL(10 , 2 )
);

INSERT INTO sales.category(category_id, category_name, amount)
VALUES(1,'Children Bicycles',15000),
    (2,'Comfort Bicycles',25000),
    (3,'Cruisers Bicycles',13000),
    (4,'Cyclocross Bicycles',10000);


CREATE TABLE sales.category_staging (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL,
    amount DECIMAL(10 , 2 )
);


INSERT INTO sales.category_staging(category_id, category_name, amount)
VALUES(1,'Children Bicycles',15000),
    (3,'Cruisers Bicycles',13000),
    (4,'Cyclocross Bicycles',20000),
    (5,'Electric Bikes',10000),
    (6,'Mountain Bikes',10000);

select * from sales.category;
select * from sales.category_staging;

MERGE sales.category t
USING sales.category_staging s
	ON t.category_id = s.category_id
WHEN MATCHED
	THEN UPDATE SET t.category_id = s.category_id, t.category_name = s.category_name, t.amount = s.amount
WHEN NOT MATCHED BY TARGET
	THEN INSERT (category_id, category_name, amount)
	VALUES (s.category_id, s.category_name, s.amount)
WHEN NOT MATCHED BY SOURCE
	THEN DELETE;


select * from sales.category;

alter table sales.category
add discount INT;


alter table sales.category
ALTER COLUMN discount VARCHAR(20);

INSERT INTO sales.category (category_id, category_name, amount, discount)
values(7, 'category_na', 1200, '10%');

ALTER TABLE sales.category 
DROP COLUMN discount;

TRUNCATE TABLE sales.category_staging;

