SELECT 
    genre,
    COUNT(DISTINCT movie_title) AS unique_movies_shown,
    SUM(revenue) AS genre_total_revenue,
    SUM(rental_cost) AS genre_total_cost,
    SUM(revenue) - SUM(rental_cost) AS genre_net_profit,
    ROUND(
        ((SUM(revenue) - SUM(rental_cost)) / NULLIF(SUM(revenue), 0)) * 100, 
        2
    ) AS genre_margin_percent
FROM {{ ref('mart_network_movie_profitability') }}
GROUP BY genre
ORDER BY genre_margin_percent DESC