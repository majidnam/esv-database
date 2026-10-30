-- Find collaborations with missing reviews about charity/ volunteer involving organisations
SELECT
    collab.collab_id,
    e.name AS employer_to_provide_review,
    c.name AS charity_name,
    collab.start_date AS collaboration_start_date,
    collab.end_date AS collaboration_end_date,
    collab.ongoing
FROM collaborations as collab
LEFT JOIN charities AS c
    USING (charity_id)
LEFT JOIN employers AS e
    USING (employer_id)
FULL OUTER JOIN charity_reviews AS cr
    USING (collab_id)
WHERE cr.review_id IS NULL;
