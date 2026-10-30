-- Find collaborations with missing reviews about employers
SELECT
    collab.collab_id,
    c.name AS organisation_to_provide_review,
    e.name AS employer_name,
    collab.start_date AS collaboration_start_date,
    collab.end_date AS collaboration_end_date,
    collab.ongoing
FROM collaborations AS collab
LEFT JOIN charities AS c
    USING (charity_id)
LEFT JOIN employers AS e
    USING (employer_id)
FULL OUTER JOIN employer_reviews AS er
    USING (collab_id)
WHERE er.review_id IS NULL;
