-- Find all active roles using role_dates table 
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
    rd.start_date,
    rd.end_date
FROM roles AS r
INNER JOIN role_dates AS rd
    USING (role_id)
WHERE (r.active IS NOT FALSE)  -- Exclude roles with a value for 'False' in 'active' 
    AND ((rd.end_date IS NULL)
        OR (rd.end_date > CURRENT_DATE))  -- Ensure that 'end_date' is not in the past
    AND (rd.start_date < CURRENT_DATE);  -- Ensure that role has already started

