
--drop table procurement.vendors;
----select * from procurement.vendors
-- CONSTRAINT fk_group FOREIGN KEY (group_id) REFERENCES procurement.vendor_groups(group_id)

-- FOREIGN KEY (group_id) 
-- REFERENCES procurement.vendor_groups(group_id) 
create schema procurement;
go
CREATE TABLE procurement.vendor_groups (
    group_id INT IDENTITY PRIMARY KEY,
    group_name VARCHAR (100) NOT NULL
);
-- one to many 
drop table procurement.vendors;
drop table procurement.vendor_groups;

CREATE TABLE procurement.vendors (
        vendor_id INT IDENTITY PRIMARY KEY,
        vendor_name VARCHAR(100) NOT NULL,
        group_id INT NOT NULL,
		FOREIGN KEY (group_id) 
		REFERENCES procurement.vendor_groups(group_id)
);

INSERT INTO procurement.vendor_groups(group_name)
VALUES('Third-Party Vendors'),
      ('Interco Vendors'),
      ('One-time Vendors');

select * from procurement.vendor_groups;

insert INTO procurement.vendors(vendor_name,group_id)
	values('UAT',3),
			('ABC',1),
			('XYZ',3)
select * from procurement.vendors;

--delete from  procurement.vendor_groups
--where group_id = 2

delete from  procurement.vendor_groups
where group_id = 3

-- Referential actions
-- delete/ update

-- Delete 

-- 1 No action (default)
drop TABLE procurement.vendors;

CREATE TABLE procurement.vendors (
        vendor_id INT IDENTITY PRIMARY KEY,
        vendor_name VARCHAR(100) NOT NULL,
        group_id INT NOT NULL,
		FOREIGN KEY (group_id) 
		REFERENCES procurement.vendor_groups(group_id)
		On delete No action
);
--2. CASCADE 

drop TABLE procurement.vendors;
CREATE TABLE procurement.vendors (
        vendor_id INT IDENTITY PRIMARY KEY,
        vendor_name VARCHAR(100) NOT NULL,
        group_id INT NOT NULL,
		FOREIGN KEY (group_id) 
		REFERENCES procurement.vendor_groups(group_id)
		On delete CASCADE -- also delete from the child table 
);
delete from  procurement.vendor_groups
where group_id = 3;

select * from procurement.vendors;	


-- 3. ON DELETE SET NULL


drop TABLE procurement.vendors;
CREATE TABLE procurement.vendors (
        vendor_id INT IDENTITY PRIMARY KEY,
        vendor_name VARCHAR(100) NOT NULL,
        group_id INT NULL,
		FOREIGN KEY (group_id) 
		REFERENCES procurement.vendor_groups(group_id)
		On delete Set NULL --  
);
delete from  procurement.vendor_groups
where group_id = 3;

select * from procurement.vendors;	

-- 4. ON DELETE SET Default


CREATE TABLE procurement.vendors (
        vendor_id INT IDENTITY PRIMARY KEY,
        vendor_name VARCHAR(100) NOT NULL,
        group_id INT NULL default 1,
		FOREIGN KEY (group_id) 
		REFERENCES procurement.vendor_groups(group_id)
		ON DELETE SET DEFAULT  --  
);

select * from procurement.vendors;	
delete from  procurement.vendor_groups
where group_id = 3;