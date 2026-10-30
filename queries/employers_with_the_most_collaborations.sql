-- Find employers with the most collaborations
SELECT
    e.employer_id,
    e.name,
    COUNT(collab.collab_id) AS number_of_collaborations
FROM employers AS e
INNER JOIN collaborations AS collab
    USING (employer_id)
GROUP BY e.employer_id, e.name
HAVING COUNT(collab.collab_id) >= 1
ORDER BY number_of_collaborations DESC;

