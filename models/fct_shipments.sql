with lineitems as (

    select
        order_key,
        part_key,
        supplier_key,
        line_number,
        quantity,
        extended_price,
        discount,
        tax,
        return_flag,
        line_status,
        ship_date,
        commit_date,
        receipt_date,
        ship_mode
    from {{ ref('stg_lineitem') }}

),

final as (

    select
        order_key,
        part_key,
        supplier_key,
        line_number,
        quantity,
        extended_price,
        discount,
        tax,
        return_flag,
        line_status,
        ship_date,
        commit_date,
        receipt_date,
        ship_mode,

        extended_price * (1 - discount) as discounted_price,
        (extended_price * (1 - discount)) * (1 + tax) as total_price,
        datediff(day, ship_date, receipt_date) as shipping_days

    from lineitems

)

select * from final
