with source_nj_003 as (
    select * from {{ source('raw_movie_data', 'NJ_003') }}
),

filtered_and_cleaned as (
    select
        -- Primary Key
        cast(transaction_id as varchar) as transaction_id,
        
        -- Dimensions
        cast(timestamp as date) as sales_date,
        cast(details as varchar) as movie_id,
        
        -- Metrics
        cast(amount as integer) as daily_tickets_sold,
        cast(price as numeric(10,2)) as ticket_price_usd,
        cast(total_value as numeric(10,2)) as daily_revenue_usd
        
    from source_nj_003
    -- Filter out popcorn, snacks, and drinks to isolate only the ticket grain
    where upper(product_type) = 'TICKET'
)

select * from filtered_and_cleaned