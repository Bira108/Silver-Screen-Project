with staging_sales as (
    -- Points directly to stg_daily_movie_sales as defined in your schema.yml
    select * from {{ ref('stg_daily_movie_sales') }}
),

monthly_aggregation as (
    select
        movie_id,
        'Theater 2' as location_name,
        cast(date_trunc('month', sales_date) as date) as reporting_month,
        
        sum(daily_tickets_sold) as total_tickets_sold,
        sum(daily_revenue_usd) as total_revenue_usd
        
    from staging_sales
    group by 
        movie_id,
        location_name,
        reporting_month
)

select * from monthly_aggregation
