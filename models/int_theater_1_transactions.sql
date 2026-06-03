with staging_transactions as (
    -- Pull directly from your clean Silver staging layer
    select * from {{ ref('stg_ticket_transactions') }}
),

monthly_aggregation as (
    select
        -- Grouping dimensions
        movie_id,
        'Theater 1' as location_name,
        
        -- Truncating the exact timestamp to the first day of the month
        cast(date_trunc('month', transacted_at) as date) as reporting_month,
        
        -- Aggregated metrics
        sum(ticket_quantity) as total_tickets_sold,
        sum(total_paid_usd) as total_revenue_usd
        
    from staging_transactions
    group by 
        movie_id,
        location_name,
        reporting_month
)

select * from monthly_aggregation