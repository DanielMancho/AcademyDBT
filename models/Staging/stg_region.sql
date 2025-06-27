{{ config(materialized='view') }}

select
    r_regionkey as region_key,
    r_name      as region_name,
    r_comment   as comment
from {{ source('TPCH_SF1', 'region') }}
