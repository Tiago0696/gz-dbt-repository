WITH sales_margin AS (
    SELECT
        orders_id,
        date_date,
        revenue,
        quantity,
        purchase_cost,
        margin
    FROM {{ ref('int_sales_margin') }}
)

SELECT
    orders_id,
    date_date,
    SUM(revenue) AS revenue,
    SUM(quantity) AS quantity,
    SUM(purchase_cost) AS purchase_cost,
    SUM(margin) AS margin
FROM sales_margin
GROUP BY orders_id, date_date
