WITH

SOURCE AS (

    SELECT * FROM {{ source('ecom', 'raw_stores') }}

),

RENAMED AS (

    SELECT

        ----------  ids
        ID AS LOCATION_ID,

        ---------- text
        NAME AS LOCATION_NAME,






        ---------- numerics
        TAX_RATE,

        ---------- timestamps
        -- Substituição manual do dbt.date_trunc
        DATE_TRUNC(OPENED_AT, DAY) AS OPENED_DATE

    FROM SOURCE

)

SELECT * FROM RENAMED
