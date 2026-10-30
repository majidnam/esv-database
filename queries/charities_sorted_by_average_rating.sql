-- Sort charity/ volunteer involving organisations by highest average review rating
SELECT
    c.name,
    AVG(cr.overall_rating) AS average_rating
FROM charity_reviews AS cr
LEFT JOIN charities AS c
    USING (charity_id)
GROUP BY c.name
ORDER BY average_rating DESC;

