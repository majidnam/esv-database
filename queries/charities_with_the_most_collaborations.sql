-- Find charities/ volunteer involving organisations with the most collaborations
SELECT
    c.charity_id,
    c.name,
    COUNT(collab.collab_id) AS number_of_collaborations
FROM charities AS c
INNER JOIN collaborations AS collab
    USING (charity_id)
GROUP BY c.charity_id, c.name
HAVING COUNT(collab.collab_id) >= 1
ORDER BY number_of_collaborations DESC;

