with source_nj_003 as (
    -- 1. Pull directly from the NJ_003 table in our sources map
    select * from {{ source('raw_movie_data', 'NJ_003') }}
),

renamed_and_cleaned as (
    -- 2. Map and cast the concessions columns using TOTAL_VALUE
    select
        TRANSACTION_ID as transaction_id,
        
        -- Product categorization
        lower(PRODUCT_TYPE) as product_type,     -- e.g., 'food', 'beverage', 'merchandise'
        upper(DETAILS) as product_name,          -- e.g., 'POPCORN LARGE', 'COKE'
        
        -- Quantities and financial metrics
        cast(AMOUNT as integer) as item_quantity,
        cast(PRICE as decimal(10,2)) as unit_price_usd,
        cast(TOTAL_VALUE as decimal(10,2)) as total_paid_usd,
        
        -- Timestamp
        cast(TIMESTAMP as timestamp) as transacted_at
        
    from source_nj_003
)

-- 3. Output the pristine data view
select * from renamed_and_cleaned