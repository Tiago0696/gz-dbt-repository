WITH source AS (
    SELECT * FROM {{ source('raw', 'raw_gz_product') }}
),

renamed AS (
    SELECT
        products_id,
        CAST(purchSE_PRICE AS FLOAT64) AS purchase_price
    FROM source
)

SELECT * FROM renamed
