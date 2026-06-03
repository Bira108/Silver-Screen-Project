with theater_1 as (
    select * from {{ ref('int_theater_1_transactions') }}
),

theater_2 as (
    select * from {{ ref('int_theater_2_transactions') }}
),

theater_3 as (
    select * from {{ ref('int_theater_3_transactions') }}
),

unified_network_sales as (
    select * from theater_1
    
    union all
    
    select * from theater_2
    
    union all
    
    select * from theater_3
)

select 
    -- Dimensions
    movie_id,
    location_name,
    reporting_month,
    
    -- Metrics
    total_tickets_sold,
    total_revenue_usd
    
from unified_network_sales