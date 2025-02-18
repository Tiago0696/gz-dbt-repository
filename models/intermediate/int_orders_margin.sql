WITH sales_margin AS (
    SELECT * FROM {{ ref('int_sales_margin') }}  -- On prend les données du modèle précédent
)

SELECT
    orders_id,
    MIN(date_date) AS date_date,  -- Si plusieurs dates par commande, on prend la plus ancienne
    SUM(revenue) AS revenue,  -- Total des revenus par commande
    SUM(quantity) AS quantity,  -- Total des quantités par commande
    SUM(purchase_cost) AS purchase_cost,  -- Total du coût d'achat par commande
    SUM(margin) AS margin  -- Total de la marge par commande
FROM sales_margin
GROUP BY orders_id
