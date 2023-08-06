--1. Which product categories drive the biggest profits? Is this the same across store locations?

SELECT
       P.product_category,
       S.store_location,
       (P.product_cost- P.product_price) AS profit
FROM 
	   products P
JOIN 
       inventory I ON P.product_id = I.product_id
JOIN 
       store S on i.store_id = s.store_id
GROUP BY
       P.product_id,
	   S.store_location
ORDER BY 
       profit DESC
limit 4;


--2. How much money is tied up in inventory at the toy stores? How long will it last?

SELECT
       CEIL(SUM(P.product_cost))AS total_sales,
       CEIL( SUM(I.stock_on_hand * P.product_cost)) AS total_money_tied_up,
       CEIL(SUM(I.stock_on_hand * P.product_cost) / SUM(P.product_cost)) AS inventory_duration_days
FROM
       inventory I
JOIN 
       products P ON I.product_id = P.product_id
JOIN
       store ST ON I.store_id = ST.store_id;
	  
	  
	
--3. Are sales being lost with out-of-stock products at certain locations?
 
 
SELECT 
       I.stock_on_hand,
       p.product_category,
       ST.store_location,
CASE WHEN 
       I.stock_on_hand = 0 or I.stock_on_hand is null THEN 'Out of stock ' ELSE 'Sales Made' END AS SALES_STATUS
FROM 
       Inventory I
JOIN 
       Store ST on I.store_id= ST.store_id
JOIN  
       products P on I.product_id= P.product_id
GROUP BY
       I.stock_on_hand,
	   ST.store_location,
	   P.product_category
HAVING
       STOCK_ON_HAND =0 OR NULL ;
