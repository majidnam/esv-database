-- Display locations for each charity/ volunteer involving organisation
SELECT
    c.charity_id,
    c.name,
    c.description,
    c.active,
    cl.location_id,
    cl.address_line_1,
    cl.address_line_2,
    cl.address_line_3,
    cl.county,
    cl.postcode
FROM charities AS c
LEFT JOIN charity_locations AS cl
    USING (charity_id)
ORDER BY c.charity_id;
