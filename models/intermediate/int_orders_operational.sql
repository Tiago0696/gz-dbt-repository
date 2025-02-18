-- Création d'une CTE (Common Table Expression) pour récupérer les marges par commande
WITH orders_margin AS (
    SELECT * FROM {{ ref('int_orders_margin') }}  
),
-- Création d'une CTE pour récupérer les informations d'expédition
shipping AS (
    SELECT
        orders_id,
        shipping_fee,
        logCost,
        CAST(ship_cost AS FLOAT64) AS ship_cost  -- Conversion du ship_cost en FLOAT64
    FROM {{ ref('stg_raw_ship') }}
)
-- Jointure des tables pour calculer la marge opérationnelle
SELECT
    orders_margin.orders_id,  -- ID de la commande
    orders_margin.date_date,  -- Date de la commande
    orders_margin.margin 
    + shipping.shipping_fee  -- Ce que le client a payé pour l'expédition
    - shipping.logCost  -- Le coût logistique pour l'entreprise
    - shipping.ship_cost AS operational_margin  -- Le coût réel de l'expédition
FROM orders_margin
LEFT JOIN shipping
ON orders_margin.orders_id = shipping.orders_id;
