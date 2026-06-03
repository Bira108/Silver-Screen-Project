SELECT 
    location, 
    SUM(revenue) AS location_total_revenue,
    SUM(rental_cost) AS location_total_cost,
    SUM(revenue) - SUM(rental_cost) AS location_net_profit,
    ROUND(
        ((SUM(revenue) - SUM(rental_cost)) / NULLIF(SUM(revenue), 0)) * 100, 
        2
    ) AS location_margin_percent
FROM {{ ref('mart_network_movie_profitability') }}
GROUP BY location
ORDER BY location_net_profit DESC