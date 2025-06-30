SELECT *
FROM {{ ref('stg_customers') }}
WHERE market_segment NOT IN ('AUTOMOBILE', 'BUILDING', 'FURNITURE', 'MACHINERY', 'HOUSEHOLD')