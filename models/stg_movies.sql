with source_movie_catalogue as (
    -- 1. Pull directly from the MOVIE_CATALOGUE table in our sources map
    select * from {{ source('raw_movie_data', 'MOVIE_CATALOGUE') }}
),

renamed_and_cleaned as (
    -- 2. Map using only the verified, essential Snowflake columns
    select
        MOVIE_ID as movie_id,
        MOVIE_TITLE as movie_title,
        GENRE as genre,
        
        -- Explicitly format your real date column
        cast(RELEASE_DATE as date) as released_on
        
    from source_movie_catalogue
)

-- 3. Output the pristine data view
select * from renamed_and_cleaned