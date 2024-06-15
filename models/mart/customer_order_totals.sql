-- models/customer_order_totals.sql

with orders as (
    select * from {{ ref('stg_orders') }}
),

order_totals as (
    select
        customer_id,
        sum(order_total) as total_spent
    from orders
    group by customer_id
)

select * from order_totals
