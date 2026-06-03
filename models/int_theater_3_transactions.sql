with staging_sales as (
    -- Pulling directly from your freshly built Theater 3 staging layer
    select * from {{ ref('stg_theater_3_sales') }}
),

monthly_aggregation as (
    select
        -- Grouping Dimensions
        movie_id,
        'Theater 3' as location_name,
        
        -- Truncating individual ticket dates to the first day of the month
        cast(date_trunc('month', sales_date) as date) as reporting_month,
        
        -- Aggregating individual transaction quantities into monthly totals
        sum(daily_tickets_sold) as total_tickets_sold,
        sum(daily_revenue_usd) as total_revenue_usd
        
    from staging_sales
    group by 
        movie_id,
        location_name,
        reporting_month
)

select * from monthly_aggregation