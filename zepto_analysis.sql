-- =========================================
-- STEP 1: INITIAL DATA EXPLORATION
-- =========================================

-- View complete dataset
select * from zepto_v1;

-- View table schema and column information
select * from information_schema.columns
where table_name='zepto_v1';


-- =========================================
-- STEP 2: DUPLICATE RECORD ANALYSIS
-- =========================================

-- Detect duplicate product records
select count(*),
Category,
name,
discountPercent,
weightInGms,
discountedSellingPrice,
mrp,
availableQuantity,
quantity

from zepto_v1

group by Category,
name,
discountPercent,
weightInGms,
discountedSellingPrice,
mrp,
availableQuantity,
quantity

having count(*) > 1;


-- =========================================
-- STEP 3: PRODUCT CATEGORY CONSISTENCY
-- =========================================

-- Calculate percentage of products
-- appearing in multiple categories
SELECT
    ROUND(
        COUNT(*) * 100.0 /
        (
            SELECT COUNT(DISTINCT name, weightInGms)
            FROM zepto_v1
        ),
        2
    ) AS percentage_of_multi_category_products

FROM
(
    SELECT name, weightInGms
    FROM zepto_v1
    GROUP BY name, weightInGms
    HAVING COUNT(DISTINCT Category) > 1
) t;


-- Count total unique products
select count(distinct name)
from zepto_v1;


-- =========================================
-- STEP 4: OUT-OF-STOCK ANALYSIS
-- =========================================

-- Calculate overall out-of-stock percentage
select
(
cast(count(*) as decimal(10,2)) /
(select count(*) from zepto_v1)
) * 100

from zepto_v1
where outOfStock='TRUE';


-- Category-wise out-of-stock percentage
with category_outofstock as
(
    select Category,
    count(outOfStock) as outofstock_count
    
    from zepto_v1
    where outOfStock='TRUE'
    group by Category
)

select
co.Category,
(
cast(outofstock_count as decimal(10,2)) /
count_of_totalstock
) * 100 as outofstock_percentage

from category_outofstock co

inner join
(
    select Category,
    count(*) as count_of_totalstock
    from zepto_v1
    group by Category
) t

on co.Category = t.Category

order by 2 desc;


-- Find highly discounted products
-- that are currently out of stock
select
name,
discountPercent,
outOfStock,
quantity

from zepto_v1
where outOfStock='TRUE'
order by discountPercent desc;


-- =========================================
-- STEP 5: DISCOUNT VS STOCK ANALYSIS
-- =========================================

-- Analyze relationship between average discount
-- and out-of-stock percentage by category
select
Category,

round(avg(discountPercent),2) as avg_discount,

round(
sum(case when outOfStock='TRUE' then 1 else 0 end)
/ count(*) * 100,
2
) as outofstock_percentage

from zepto_v1

group by Category
order by avg_discount desc;


-- =========================================
-- STEP 6: INVENTORY VALUE ANALYSIS
-- =========================================

-- Identify top 5 products with highest inventory value
select
name as product,

sum(discountedSellingPrice * availableQuantity)
as inventory_price

from zepto_v1

group by name
order by inventory_price desc
limit 5;


-- =========================================
-- STEP 7: DATA CLEANING & TABLE CREATION
-- =========================================

-- Drop table if already exists
DROP TABLE IF EXISTS zepto;


-- Create cleaned inventory table
create table zepto
(
id int auto_increment primary key,
category varchar(50),
product_name varchar(50),
mrp int,
discount_percentage int,
available_quantity int,
selling_price int,
weight_grm int,
outofstock varchar(10),
quantity int
);


-- Insert cleaned data into new table
insert into zepto
(
category,
product_name,
mrp,
discount_percentage,
available_quantity,
selling_price,
weight_grm,
outofstock,
quantity
)

select * from zepto_v1;


-- =========================================
-- STEP 8: DUPLICATE REMOVAL
-- =========================================

-- Disable safe update mode
set sql_safe_updates=0;


-- Remove duplicate rows using ROW_NUMBER()
delete from zepto
where id in
(
    select id from
    (
        select
        id,

        row_number() over
        (
            partition by category,
            product_name,
            mrp,
            discount_percentage,
            available_quantity,
            selling_price,
            weight_grm,
            outofstock,
            quantity
            order by id
        ) as rn

        from zepto
    ) t

    where rn > 1
);


-- =========================================
-- STEP 9: PRODUCT DEMAND SEGMENTATION
-- =========================================

-- Segment products based on inventory value
-- and stock availability

select
product_name,
inventory_value,
demand_segment

from
(
    SELECT
    product_name,

    selling_price * available_quantity
    AS inventory_value,

    CASE
        WHEN selling_price * available_quantity >
             (
             SELECT AVG(selling_price * available_quantity)
             FROM zepto
             )
             AND outofstock = 'TRUE'
        THEN 'High Demand'
             
        WHEN selling_price * available_quantity >
             (
             SELECT AVG(selling_price * available_quantity)
             FROM zepto
             )
             AND outofstock = 'FALSE'
        THEN 'Overstock'
             
        WHEN selling_price * available_quantity <=
             (
             SELECT AVG(selling_price * available_quantity)
             FROM zepto
             )
             AND outofstock = 'FALSE'
        THEN 'Balanced'
             
        ELSE 'Low Priority'
    END AS demand_segment

    FROM zepto

) t

where demand_segment='High Demand';


