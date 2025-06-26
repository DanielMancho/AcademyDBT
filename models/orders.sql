with orders as (

    select
        order_key,
        customer_key,
        order_status,
        total_price,
        order_date,
        order_priority,
        clerk,
        ship_priority,
        comment
    from {{ ref('stg_orders') }}

),

customers as (

    select
        customer_key,
        customer_name,
        nation_key
    from {{ ref('stg_customers') }}

),
final as (

    select
        o.order_key,
        o.order_date,
        o.total_price,
        o.order_status,
        o.order_priority,
        o.ship_priority,
        o.clerk,
        o.comment,

        c.customer_key,
        c.customer_name,

    from orders o
    left join customers c on o.customer_key = c.customer_key

)

select * from final
