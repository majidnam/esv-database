-- Functions 

-- Find role with a start date within a given range (e.g. in the future)
CREATE OR REPLACE FUNCTION roles_by_start_date(
	min_date DATE,
       	max_date DATE
)
RETURNS TABLE(
	role_id INT,
	name VARCHAR(50),
	category_id INT,
	charity_id INT,
	urgency VARCHAR(30),
	min_duration VARCHAR(30),
	max_duration VARCHAR(30),
	active BOOLEAN,
	date_added DATE
)
AS
$$
SELECT
    r.role_id AS role_id,
    r.name AS name,
    r.category_id,
    r.charity_id,
    r.urgency,
    r.min_duration,
    r.max_duration,
    r.active,
    r.date_added
FROM roles AS r
INNER JOIN role_dates AS rd
    USING (role_id)
WHERE (r.active IS NOT FALSE)  -- Exclude inactive roles 
    AND (rd.start_date BETWEEN min_date AND max_date);
$$
LANGUAGE SQL;

SELECT * FROM roles_by_start_date('2027-01-01', '2027-05-01');  -- Used to test function


-- Find all volunteer involving organisations in a given county
CREATE OR REPLACE FUNCTION charities_by_county(
    search_county VARCHAR
)
RETURNS TABLE(
    charity_id INT,
    charity_name VARCHAR,
    county VARCHAR,
    number_of_addresses_in_county INT
)
AS
$$
SELECT
    cl.charity_id AS charity_id,
    c.name,
    cl.county,
    COUNT(DISTINCT(postcode)) AS number_of_addresses_in_county
FROM charity_locations AS cl
INNER JOIN charities AS c
    USING (charity_id)
WHERE cl.county = search_county 
GROUP BY (cl.charity_id, c.name, cl.county);
$$
LANGUAGE SQL;

SELECT * FROM charities_by_county('Fictional County');  -- Used to test function
