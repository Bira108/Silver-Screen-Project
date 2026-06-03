SELECT 
    movie_title,
    SUM(tickets_sold) AS total_tickets_sold,
    SUM(revenue) AS total_gross_revenue,
    SUM(rental_cost) AS total_studio_cost,
    (SUM(revenue) - SUM(rental_cost)) AS net_profit,
    ROUND(
        ((SUM(revenue) - SUM(rental_cost)) / NULLIF(SUM(revenue), 0)) * 100, 
        2
    ) AS profit_margin_percent
FROM {{ ref('mart_network_movie_profitability') }}
GROUP BY movie_title
HAVING total_gross_revenue > 0
ORDER BY profit_margin_percent ASC