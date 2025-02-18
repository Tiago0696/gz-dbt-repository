WITH orders_margin AS (
    SELECT *
    FROM {{ ref('int_orders_margin') }}
),

shipping AS (
    SELECT
        orders_id,
        CAST(shipping_fee AS FLOAT64) AS shipping_fee,
        CAST(ship_cost AS FLOAT64) AS ship_cost,
        CAST([VRAI_NOM_DE_logCost] AS FLOAT64) AS logCost  -- Remplace par le bon nom trouvé
    FROM {{ ref('stg_raw_ship') }}
)

SELECT
    orders_margin.orders_id,
    orders_margin.date_date,
    orders_margin.margin + shipping.shipping_fee - shipping.logCost - shipping.ship_cost AS operational_margin
FROM orders_margin
LEFT JOIN shipping ON orders_margin.orders_id = shipping.orders_id;
