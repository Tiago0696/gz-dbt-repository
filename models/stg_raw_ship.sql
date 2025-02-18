WITH source AS (
    SELECT * FROM {{ source('raw', 'raw_gz_ship') }}
),

filtered AS (
    SELECT *
    FROM source
    WHERE shipping_fee <> shipping_fee_1
),

renamed AS (
    SELECT
        orders_id,
        shipping_fee,
        logCost AS logistic_cost,
        CAST(ship_cost AS FLOAT64) AS ship_cost
    FROM filtered
)

SELECT * FROM renamed
