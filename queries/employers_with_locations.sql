-- Display locations for each employer
SELECT
    e.employer_id,
    e.name,
    e.description,
    e.active,
    el.location_id,
    el.address_line_1,
    el.address_line_2,
    el.address_line_3,
    el.county,
    el.postcode
FROM employers AS e
LEFT JOIN employer_locations AS el
    USING (employer_id)
ORDER BY e.employer_id;
