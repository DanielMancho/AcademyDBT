{{ config(
    materialized='table'
) }}

SELECT
    c_custkey     AS customer_key,
    c_name        AS customer_name,
    c_address     AS address,
    c_nationkey   AS nation_key,
    c_phone       AS phone,
    c_acctbal     AS account_balance,
    c_mktsegment  AS market_segment,
    c_comment     AS comment
FROM {{ source('TPCH_SF1', 'customer') }}
