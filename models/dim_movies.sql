with movies_silver as (
    -- Pull directly from your clean Silver staging view
    select * from {{ ref('stg_movies') }}
),

final_dimension as (
    select
        movie_id,
        movie_title,
        genre,
        runtime_minutes,
        
        -- Pulling in our formatted release date from Silver
        released_on,
        
        -- Let's add a useful business category!
        -- If a movie is 120 minutes or longer, mark it as 'Long', otherwise 'Standard'
        case 
            when runtime_minutes >= 120 then 'Long'
            else 'Standard'
        end as duration_category
        
    from movies_silver
)

select * from final_dimension