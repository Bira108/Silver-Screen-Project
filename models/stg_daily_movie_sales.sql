with source_nj_002 as (
    -- 1. Pull directly from the NJ_002 table in our sources map
    select * from {{ source('raw_movie_data', 'NJ_002') }}
),

renamed_and_cleaned as (
    -- 2. Map and cast the daily summary columns
    select
        MOVIE_ID as movie_id,
        
        -- Date dimension
        cast(DATE as date) as sales_date,
        
        -- Quantities and financial metrics
        cast(TICKET_AMOUNT as integer) as daily_tickets_sold,
        cast(TICKET_PRICE as decimal(10,2)) as ticket_price_usd,
        cast(TOTAL_EARNED as decimal(10,2)) as daily_revenue_usd
        
    from source_nj_002
)

-- 3. Output the pristine data view
select * from renamed_and_cleaned