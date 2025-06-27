{{ config(
    materialized='incremental',
    unique_key='order_key'
) }}

SELECT
    o_orderkey     AS order_key,
    o_custkey      AS customer_key,
    o_orderstatus  AS order_status,
    o_totalprice   AS total_price,
    o_orderdate    AS order_date,
    o_orderpriority AS order_priority,
    o_clerk        AS clerk,
    o_shippriority AS ship_priority,
    o_comment      AS comment
FROM {{ source('TPCH_SF1', 'orders') }}

{% if is_incremental() %}
WHERE o_orderdate > (SELECT max(order_date) FROM {{ this }})
{% endif %}
