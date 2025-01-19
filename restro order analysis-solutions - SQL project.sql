----Menu table analysis

--View the menu table
select * from menu

--find the number of items on the menu
select count(item_name) from menu

--what are the least and most expensive items on the menu

--most expensive :
select max(price) as max_price from menu
--least expensive
select min(price) as min_price from menu

--how many italian dishes are on the menu
select count(item_name) as no_of_items from menu where category = 'italian'

--what are the most and least expensive italian dishes on the menu
select max(price) as max_price from menu where category = 'italian'
select min(price) as min_price from menu where category = 'italian'

--how many dishes are in each category
select category , count(item_name) as no_of_dishes from menu  group by category

--what is the average dish price in each category
select category , avg(price) as average_rate from menu group by category

--Order table analysis

--view the order table
select  * from orders

--what is the date range of the table
select min(order_date) firstday , max(order_date) lastday from orders

--how many orders were made in this range
select count(distinct order_id) as no_of_orders from orders

--how many items were ordered in this range
select count(*) from orders

--which orders had the most number of items
select * from orders
select order_id , count(item_id) as no_of_items 
from orders 
group by order_id 
order by count(item_id) 
desc

--how many orders had more than 12 items
select count(*) from 
(select order_id , count(item_id) as num_items 
from orders 
group by order_id 
having count(item_id) > 12) as num_orders 

--combined analysis of customer behaviour

--combine the menu_items and order_details table into single tables
select * from orders o 
left join menu m
on o.item_id = m.menu_item_id

--what are the least and most ordered items ? what categories are they in ?
select m.item_name , m.category , count(o.order_details_id) as no_of_times_ordered from orders o 
left join menu m
on o.item_id = m.menu_item_id
group by m.item_name , m.category
order by count(o.order_details_id) desc

--max = hamburger : 622 times (american
--min = chicken tacos : 123 (mexican)

--what are the top 5 orders spent the most money ?
select top 5 order_id  , sum(price) as money_spent from orders o 
left join menu m
on o.item_id = m.menu_item_id
group by o.order_id
order by sum(m.price) desc

--view the details of highest spend order
select  category , count(item_id) as num_items   from orders o 
left join menu m
on o.item_id = m.menu_item_id
where o.order_id = 440 
group by category

--View the details of 5 highest spent orders .
select  top 5 order_id ,  category ,  count(item_id) as num_items   from orders o 
left join menu m
on o.item_id = m.menu_item_id
where o.order_id in (440 , 2075 , 1957 , 330 , 2675)
group by order_id , category
order by  count(item_id) desc







