-- Display roles with charity/ volunteer involving organisation name and category name
SELECT
    r.role_id AS role_id,
    r.name AS name,
    c.name AS charity,
    rs.category AS category,
    rc.category AS category, 
    r.urgency,
    r.min_duration,
    r.max_duration,
    r.active AS role_active,
    r.date_added
FROM roles AS r
LEFT JOIN charities AS c
    USING (charity_id) 
LEFT JOIN role_categories AS rs
    USING (category_id)
ORDER BY category;

