---1) HIGHEST PURCHASED PRODUCTS
select top 3 a.product_name, count(b.quantity) as highest_purchased_products
from products_dataset$ a
join purchase_history_dataset$ b
on a.product_id = b.product_id
group by a.product_name
order by 2 desc


---2) LOWEST PURCHASED PRODUCTS
select TOP 3  a.product_name, count(b.quantity) as lowest_purchased_products 
from products_dataset$ a
join purchase_history_dataset$ b
on a.product_id = b.product_id
group by a.product_name
order by 2 

---3) WHAT BRAND OF PRODUCT IS BOUGHT THE MOST
select a.brand, count(b.quantity) as total_brand_bought
from products_dataset$ a
join purchase_history_dataset$ b
on a.product_id = b.product_id
group by a.brand
order by 2 desc

---4)the number of signup in each year

select year(signup_date) as signup_year, COUNT(signup_date) as total_amt_of_singnups_each_year
from customer_profile_dataset$
group by year(signup_date)
order by year(signup_date)


 ---5)total amount of purchase made each year
 select year(purchase_date) as purchase_year, sum(total_amount*quantity) as total_amount_of_purchase_each_year
 from purchase_history_dataset$
 group by year(purchase_date)
 order by 1

 ----6) calculating the frquency of visits for each customer since they signed up
 select  a.customer_id, b.signup_date,  b.first_name,  b.last_name,
 count(a.purchase_date) as frequencyofvisit
 from purchase_history_dataset$ a
 join customer_profile_dataset$ b
 on a.customer_id = b.customer_id
 group by a.customer_id, b.first_name, b.last_name, b.signup_date
 order by 1

 ----7) cities with the highest number of customers
 select city, count(city) as highest_number_of_customers
 from customer_profile_dataset$
 group by city
 order by 2

 -----8)first signed up customers and the last time they bought an item
 with first_customers as(
  select a.customer_id, a.purchase_date, b.signup_date
 from purchase_history_dataset$ a
 join customer_profile_dataset$ b
 on a.customer_id = b.customer_id
 where year(signup_date) = 2016
 )
 select distinct(customer_id), signup_date, max(purchase_date)
 over(partition by customer_id)
 from first_customers
 group by customer_id, signup_date, purchase_date

 ----9) the age demography
with age_demo as
(
 select age,
 case when age <= '35' then 'young'
      when age <= '50' then 'middle_aged'
	  when age <= '70' then 'old'
 else null
 end as age_group
 from customer_profile_dataset$
 )
 select age_group, count(age) as CountOfAgeGroup
 from age_demo
 group by age_group
 order by 2 desc

 with tl as
(
select purchase_timeconvert, datepart(hour, purchase_timeconvert) as purchase_hour,
dense_rank () over (partition by datepart(hour, purchase_timeconvert) order by purchase_timeconvert)as busiest_hour
from purchase_history_dataset$
--group by purchase_timeconvert
)



 
 

