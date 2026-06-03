with network_sales as (
    select * from {{ ref('fct_network_movie_sales') }}
),

movie_catalog as (
    select * from {{ ref('stg_movies') }}
),

studio_invoices as (
    select * from {{ ref('stg_invoices') }}
),

final_joined_reporting as (
    select
        -- 1. movie_id
        sales.movie_id,
        
        -- 2. movie_title & 3. genre (from stg_movies catalog)
        cat.movie_title,
        cat.genre,
        
        -- 4. studio (from stg_invoices cost sheet)
        inv.studio_name as studio,
        
        -- 5. month
        sales.reporting_month as month,
        
        -- 6. location
        sales.location_name as location,
        
        -- 7. rental_cost (bringing in the total invoice sum for that movie/month/location)
        inv.total_invoice_cost as rental_cost,
        
        -- 8. tickets_sold & 9. revenue (from fct_network_movie_sales)
        sales.total_tickets_sold as tickets_sold,
        sales.total_revenue_usd as revenue

    from network_sales as sales
    
    -- Join to get movie titles and genres
    left join movie_catalog as cat
        on sales.movie_id = cat.movie_id
        
    -- Join to get studio names and monthly movie rental costs
    left join studio_invoices as inv
        on sales.movie_id = inv.movie_id
        and sales.reporting_month = inv.reporting_month
)

select * from final_joined_reporting