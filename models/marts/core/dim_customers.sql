WITH customers AS (
    
     SELECT * FROM {{ ref('stg_customer') }}
 ),
 
 orders as (
    SELECT * FROM {{ ref('stg_orders') }}
 ),
 
 customer_order AS (
    SELECT 
        customer_id,
        min(order_date) AS first_order_date,
        max(order_date) AS most_recent_order_date,
        count(order_id) AS number_of_orders
     
     FROM orders
     GROUP BY 1
 ),
 
 final as (
    SELECT 
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_order.first_order_date,
        customer_order.most_recent_order_date,
        coalesce(customer_order.number_of_orders, 0) AS number_of_orders
     
     FROM customers
     LEFT JOIN customer_order USING (customer_id)
 )
 
 SELECT * FROM final