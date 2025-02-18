WITH sales AS (
    SELECT
        orders_id,
        date_date,
        quantity,
        revenue,
        products_id
    FROM {{ ref('stg_raw_sales') }}
),

product AS (
    SELECT
        products_id,
        CAST(purchase_price AS FLOAT64) AS purchase_price
    FROM {{ ref('stg_raw_product') }}
),

joined AS (
    SELECT
        sales.orders_id,
        sales.date_date,
        sales.quantity,
        sales.revenue,
        product.purchase_price,
        CAST(sales.quantity AS FLOAT64) * product.purchase_price AS purchase_cost,
        sales.revenue - (CAST(sales.quantity AS FLOAT64) * product.purchase_price) AS margin
    FROM sales
    LEFT JOIN product ON sales.products_id = product.products_id
)

SELECT * FROM joined
