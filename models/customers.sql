with customers as (

    select
        customer_key,
        customer_name,
        phone,
        account_balance,
        market_segment,
        nation_key
    from {{ ref('stg_customers') }}

),

customer_orders as (

    select
        customer_key,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_key) as number_of_orders
    from {{ ref('stg_orders') }}
    group by customer_key

),

final as (

    select
        c.customer_key,
        c.customer_name,
        c.phone,
        c.account_balance,
        c.market_segment,
        co.first_order_date,
        co.most_recent_order_date,
        coalesce(co.number_of_orders, 0) as number_of_orders
    from customers c
    left join customer_orders co
        on c.customer_key = co.customer_key

)

select * from final
