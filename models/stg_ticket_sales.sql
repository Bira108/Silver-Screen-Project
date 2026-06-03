with source_invoices as (
    -- 1. Point dynamically to the INVOICES table in sources.yml
    select * from {{ source('raw_movie_data', 'INVOICES') }}
),

renamed_and_cleaned as (
    -- 2. Map only the verified, existing Snowflake columns
    select
        invoice_id as ticket_id,
        location_id as location_id,
        movie_id as movie_id,
        
        -- Explicitly format your real price and date columns
        cast(total_invoice_sum as decimal(10,2)) as ticket_price_usd,
        cast(release_date as timestamp) as sold_at
        
    from source_invoices
)

-- 3. Output the pristine data view
select * from renamed_and_cleaned