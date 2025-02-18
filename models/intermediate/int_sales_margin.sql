WITH sales AS (
    SELECT *
    FROM {{ ref('stg_raw_sales') }}
),

product AS (
    SELECT *
    FROM {{ ref('stg_raw_product') }}
)

SELECT
    sales.orders_id,
    sales.date_date,
    sales.revenue,
    sales.quantity,
    CAST(product.purchase_price AS FLOAT64) AS purchase_price,  -- S'assurer que le prix est en FLOAT64
    CAST(sales.quantity AS INT64) * CAST(product.purchase_price AS FLOAT64) AS purchase_cost,  -- Calcul du coût d'achat
    sales.revenue - (CAST(sales.quantity AS INT64) * CAST(product.purchase_price AS FLOAT64)) AS margin  -- Calcul de la marge
FROM sales
LEFT JOIN product
ON sales.products_id = product.products_id  -- Liaison entre ventes et produits