-- Sort employers by highest average review rating 
SELECT
    e.name,
    AVG(er.overall_rating) AS average_rating
FROM employer_reviews AS er
LEFT JOIN employers AS e
    USING (employer_id)
GROUP BY e.name
ORDER BY average_rating DESC;
