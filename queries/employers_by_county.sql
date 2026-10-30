-- Find all employers in a given county (in the example below, 'Fictional County')
SELECT
    el.employer_id AS employer_id,
    e.name,
    el.county,
    COUNT(DISTINCT(el.postcode)) AS number_of_addresses_in_county
FROM employer_locations AS el
LEFT JOIN employers AS e
    USING (employer_id)
WHERE el.county = 'Fictional County'
GROUP BY
    el.employer_id,
    e.name,
    el.county;
