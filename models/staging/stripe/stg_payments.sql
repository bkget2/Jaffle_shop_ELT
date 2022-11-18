WITH payments AS (
    SELECT
        id AS payment_id,
        orderid as order_id,
        paymentmethod,
        status,
        amount,
        created
     
     FROM {{ source('stripe', 'payment')}}
 )

SELECT * FROM payments