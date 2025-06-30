with lineitems as (
    select
        order_key,
        sum(quantity) as total_quantity,
        sum(extended_price) as total_revenue,
        sum(discount) as total_discount
    from {{ ref('stg_lineitem') }}
    group by order_key
),

orders as (
    select
        order_key,
        customer_key,
        order_status,
        order_date,
        ship_priority
    from {{ ref('stg_orders') }}
)

select
    o.order_key,
    o.customer_key,
    o.order_status,
    o.order_date,
    {{ format_date('o.order_date') }} as order_date_str,
    o.ship_priority,
    coalesce(li.total_quantity, 0) as total_quantity,
    coalesce(li.total_revenue, 0) as total_revenue,
    coalesce(li.total_discount, 0) as total_discount
from orders o
left join lineitems li on o.order_key = li.order_key
