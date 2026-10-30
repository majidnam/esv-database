-- Find all active roles with ongoing (active) shift entries based on shift_dates table
SELECT
    r.role_id AS role_id,
    r.name AS name,
    r.category_id,
    r.charity_id,
    r.urgency,
    r.min_duration,
    r.max_duration,
    r.active,
    r.date_added,
    MIN(sd.start_date) AS earliest_start_date,
    MAX(sd.end_date) AS latest_end_date
FROM roles AS r
INNER JOIN shifts AS s
    USING (role_id)
INNER JOIN shift_dates AS sd
    USING (shift_id)
WHERE (r.active IS NOT FALSE)
    AND ((sd.end_date IS NULL)
        OR (sd.end_date > CURRENT_DATE))
    AND (sd.start_date < CURRENT_DATE)
    AND (sd.ongoing IS NOT FALSE)
GROUP BY
    role_id,
    name,
    r.category_id,
    r.charity_id,
    r.urgency,
    r.min_duration,
    r.max_duration,
    r.active,
    r.date_added;

