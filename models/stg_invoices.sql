with source_invoices as (
    select * from {{ source('raw_movie_data', 'INVOICES') }}
),

cleaned_invoices as (
    select
        -- Keys & Dimensions
        cast(movie_id as varchar) as movie_id,
        cast(invoice_id as varchar) as invoice_id,
        cast(month as date) as reporting_month,
        cast(location_id as varchar) as location_name,  -- Fixed identifier!
        cast(studio as varchar) as studio_name,
        
        -- Financial Costs
        cast(weekly_price as numeric(10,2)) as weekly_rental_cost,
        cast(total_invoice_sum as numeric(10,2)) as total_invoice_cost
        
    from source_invoices
)

select * from cleaned_invoices