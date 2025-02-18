WITH source AS (
    SELECT * FROM {{ source('raw', 'ship') }}
),

filtered AS (
    SELECT *
    FROM source
    WHERE shipping_fee <> shipping_fee_1  -- Exclusion des valeurs identiques
),

renamed AS (
    SELECT
        orders_id,
        shipping_method,
        CAST(ship_cost AS FLOAT64) AS ship_cost
    FROM filtered
)

SELECT * FROM renamed
