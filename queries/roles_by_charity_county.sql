-- Find roles where the charity/ volunteer involving organisation has offices in a given county (in the example below, in 'Fictional County')
SELECT
    r.role_id AS role_id,
    r.name AS role_name,
    r.category_id,
    r.min_duration,
    r.max_duration,
    r.active,
    r.date_added,
    c.name AS charity_name,
    cl.county,
    COUNT(DISTINCT(cl.postcode)) AS number_of_addresses_in_county
FROM roles AS r
INNER JOIN charities AS c
    USING (charity_id)
INNER JOIN charity_locations AS cl
    USING (charity_id)
WHERE cl.county = 'Fictional County'
GROUP BY
    role_id,
    role_name,
    r.category_id,
    r.min_duration,
    r.max_duration,
    r.active,
    r.date_added,
    charity_name,
    cl.county;
