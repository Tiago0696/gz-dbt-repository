WITH source AS (
    SELECT * FROM {{ source('raw', 'raw_gz_sales') }}
),

renamed AS (
    SELECT
        date_date,
        orders_id,
        pdt_id AS products_id,  -- Renommage pour cohérence
        revenue,
        quantity
    FROM source
)

SELECT * FROM renamed
