with source_nj_001 as (
    -- 1. Pull directly from the NJ_001 table in our sources map
    select * from {{ source('raw_movie_data', 'NJ_001') }}
),

renamed_and_cleaned as (
    -- 2. Map and format the exact columns you just found
    select
        TRANSACTION_ID as transaction_id,
        MOVIE_ID as movie_id,
        
        -- Business quantities and metrics
        cast(TICKET_AMOUNT as integer) as ticket_quantity,
        cast(PRICE as decimal(10,2)) as ticket_price_usd,
        cast(TRANSACTION_TOTAL as decimal(10,2)) as total_paid_usd,
        
        -- Timestamps
        cast(TIMESTAMP as timestamp) as transacted_at,
        
        -- Convert flags to clean Booleans (True/False)
        cast(IS_DISCOUNTED as boolean) as is_discounted,
        cast(IS_3D as boolean) as is_3d
        
    from source_nj_001
)

-- 3. Output the pristine data view
select * from renamed_and_cleaned