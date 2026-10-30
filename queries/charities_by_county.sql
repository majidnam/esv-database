-- Find all charity/ volunteer involving organisations in a given county (in the example below, 'Fictional County')
SELECT
    cl.charity_id AS charity_id,
    c.name,
    cl.county,
    COUNT(DISTINCT(cl.postcode)) AS number_of_addresses_in_county
FROM charity_locations AS cl
LEFT JOIN charities AS c
    USING (charity_id)
WHERE cl.county = 'Fictional County'
GROUP BY
    cl.charity_id,
    c.name,
    cl.county;

