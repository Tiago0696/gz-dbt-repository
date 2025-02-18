 with

 source as (

     select * from {{ source('raw', 'ship') }}

 ),
renamed AS (
    SELECT
        orders_id,
        shipping_fee,
        logCost,
        CAST(ship_cost AS FLOAT64) AS ship_cost
    FROM source
    WHERE shipping_fee <> shipping_fee_1
)

SELECT * FROM renamed