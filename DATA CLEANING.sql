select *
from purchase_history_dataset$

---converting the datetime format to date and time

select purchase_date, convert(date,purchase_date) as purchase_dateconverted
from purchase_history_dataset$

select purchase_date, convert(time, purchase_date) as purchase_time
from purchase_history_dataset$

alter table purchase_history_dataset$
add purchase_dateconverted date

alter table purchase_history_dataset$
add purchase_time time

update  purchase_history_dataset$
set purchase_date =  convert(date,purchase_date)

update  purchase_history_dataset$
set purchase_time =  convert(time, purchase_date)

select CONVERT(time(0), purchase_time) as purchase_time
from purchase_history_dataset$

alter table  purchase_history_dataset$
add purchase_timeconvert time (0)

update purchase_history_dataset$
set purchase_timeconvert = CONVERT(time(0), purchase_time)

alter table  purchase_history_dataset$
drop column purchase_time

---ROUND UP TOTAL AMOUNT TO 2 DECIMAL PLACES

SELECT ROUND( total_amount,2)
FROM purchase_history_dataset$


UPDATE purchase_history_dataset$
SET total_amount = ROUND(total_amount, 2) 

select  total_amount 
from purchase_history_dataset$

---- delete column(s)

alter table purchase_history_dataset$
drop column purchase_date

-- CATEGORIES FOR PRODUCT_NAME IS INCORRECT, SO I AM USING THE CASE STATEMENT CATEGORIZE PROPERLY

select *
from products_dataset$

SELECT DISTINCT(PRODUCT_NAME)
FROM products_dataset$

SELECT DISTINCT(CATEGORY)
FROM products_dataset$

SELECT PRODUCT_NAME, CATEGORY,
CASE 
     WHEN PRODUCT_NAME = 'APPLE' THEN 'FRUITS'
     WHEN PRODUCT_NAME = 'BANANA' THEN 'FRUITS'
     WHEN PRODUCT_NAME = 'BREAD' THEN 'GRAINS'
     WHEN PRODUCT_NAME ='BUTTER' THEN 'DAIRY' 
     WHEN PRODUCT_NAME = 'CHEESE' THEN 'DAIRY' 
     WHEN PRODUCT_NAME = 'CHICKEN' THEN 'MEATS' 
     WHEN PRODUCT_NAME = 'EGGS' THEN 'DAIRY' 
     WHEN PRODUCT_NAME = 'MILK' THEN 'DAIRY' 
     WHEN PRODUCT_NAME = 'PASTA' THEN 'GRAINS' 
     WHEN PRODUCT_NAME = 'RICE' THEN 'GRAINS'
ELSE NULL
END AS CATEGORY_PRODUCT_NAME
FROM products_dataset$


UPDATE products_dataset$
SET category = CASE 
     WHEN PRODUCT_NAME = 'APPLE' THEN 'FRUITS'
     WHEN PRODUCT_NAME = 'BANANA' THEN 'FRUITS'
     WHEN PRODUCT_NAME = 'BREAD' THEN 'GRAINS'
     WHEN PRODUCT_NAME ='BUTTER' THEN 'DAIRY' 
     WHEN PRODUCT_NAME = 'CHEESE' THEN 'DAIRY' 
     WHEN PRODUCT_NAME = 'CHICKEN' THEN 'MEATS' 
     WHEN PRODUCT_NAME = 'EGGS' THEN 'DAIRY' 
     WHEN PRODUCT_NAME = 'MILK' THEN 'DAIRY' 
     WHEN PRODUCT_NAME = 'PASTA' THEN 'GRAINS' 
     WHEN PRODUCT_NAME = 'RICE' THEN 'GRAINS'
ELSE NULL
END 
FROM products_dataset$

-- THE COLUMN BRAND IS A LITTLE FOGGY AND DOES NOT NEED 'BRAND' TO BE REPEATED IN THE ENTIRE CELL

select *
from products_dataset$

select BRAND,
CASE
    WHEN BRAND = 'BRANDA' THEN 'A'
	WHEN BRAND = 'BRANDB' THEN 'B'
	WHEN BRAND = 'BRANDC' THEN 'C'
	WHEN BRAND = 'BRANDD' THEN 'D'
	WHEN BRAND = 'BRANDE' THEN 'E'
ELSE NULL
END
from products_dataset$

UPDATE products_dataset$
SET BRAND = CASE
    WHEN BRAND = 'BRANDA' THEN 'A'
	WHEN BRAND = 'BRANDB' THEN 'B'
	WHEN BRAND = 'BRANDC' THEN 'C'
	WHEN BRAND = 'BRANDD' THEN 'D'
	WHEN BRAND = 'BRANDE' THEN 'E'
ELSE NULL
END
from products_dataset$

alter table products_dataset$
drop column product_description

---cleansing customer_profile_database
-- converting date
select *
from customer_profile_dataset$

select signup_date, convert(date,signup_date) as signup_dateconverted
from customer_profile_dataset$

alter table customer_profile_dataset$
add signup_datecoverted date


update customer_profile_dataset$
set signup_datecoverted =  convert(date,signup_date) 

select date_of_birth, convert(date, date_of_birth) as date_of_birthconverted
from customer_profile_dataset$

alter table customer_profile_dataset$
add date_of_birthconverted date


update customer_profile_dataset$
set date_of_birthconverted = convert(date, date_of_birth)

---adding age column

select *, DATEDIFF(year,date_of_birth, getdate() )  as age 
from customer_profile_dataset$

alter table customer_profile_dataset$
add age int

update customer_profile_dataset$
set age = DATEDIFF(year,date_of_birth, getdate() )

alter table customer_profile_dataset$
drop column date_of_birth, signup_date

