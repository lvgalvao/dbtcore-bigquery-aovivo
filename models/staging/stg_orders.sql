WITH

SOURCE AS (

-- Usando a macro dbt_utils.union_relations para combinar as tabelas raw_orders_2016 e raw_orders_2017
    {{ dbt_utils.union_relations(
        relations=[
            source('ecom', 'raw_orders_2023'),
            source('ecom', 'raw_orders_2024')
        ]
    ) }}

),

RENAMED AS (

    SELECT

        ----------  ids
        ID AS ORDER_ID,
        STORE_ID AS LOCATION_ID,
        CUSTOMER AS CUSTOMER_ID,

        ---------- numerics
        SUBTOTAL AS SUBTOTAL_CENTS,
        TAX_PAID AS TAX_PAID_CENTS,
        ORDER_TOTAL AS ORDER_TOTAL_CENTS,
        {{ cents_to_dollars('subtotal') }} AS SUBTOTAL,
        {{ cents_to_dollars('tax_paid') }} AS TAX_PAID,
        {{ cents_to_dollars('order_total') }} AS ORDER_TOTAL,

        ---------- timestamps
        {{ dbt.date_trunc('day','ordered_at') }} AS ORDERED_AT

    FROM SOURCE

)

SELECT * FROM RENAMED
