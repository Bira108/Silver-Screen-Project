with source_nj_002 as (
    -- This matches your sources.yml configuration perfectly!
    select * from {{ source('raw_movie_data', 'NJ_002') }}
),

renamed_and_cleaned as (
    select
        -- Dimensions
        cast(movie_id as varchar) as movie_id,
        cast(date as date) as sales_date,
        
        -- Metrics (Using your standard staging names)
        cast(ticket_amount as integer) as daily_tickets_sold,
        cast(ticket_price as numeric(10,2)) as ticket_price_usd,
        cast(total_earned as numeric(10,2)) as daily_revenue_usd
        
    from source_nj_002
)

select * from renamed_and_cleaned