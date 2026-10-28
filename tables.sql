-- Tables

DROP TABLE IF EXISTS employers CASCADE;
DROP TABLE IF EXISTS charities CASCADE;
DROP TABLE IF EXISTS roles CASCADE;
DROP TABLE IF EXISTS open_calls CASCADE;
DROP TABLE IF EXISTS role_categories CASCADE;
DROP TABLE IF EXISTS employer_locations CASCADE;
DROP TABLE IF EXISTS charity_locations CASCADE;
DROP TABLE IF EXISTS employer_reviews CASCADE;
DROP TABLE IF EXISTS charity_reviews CASCADE;
DROP TABLE IF EXISTS collaborations CASCADE;
DROP TABLE IF EXISTS collaboration_roles CASCADE;
DROP TABLE IF EXISTS shifts CASCADE;
DROP TABLE IF EXISTS shift_dates CASCADE;
DROP TABLE IF EXISTS role_dates CASCADE;

DROP DOMAIN IF EXISTS postcode_domain CASCADE;

CREATE DOMAIN postcode_domain AS TEXT NOT NULL CHECK (
    VALUE ~ '^[A-Z]{1,2}[0-9]{1}[0-9A-Z]{0,1} [0-9]{1}[A-Z]{1,2}$'
);


-- This table holds records of employers.
CREATE TABLE employers(
    employer_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(30) NOT NULL,
    description VARCHAR(200),
    active BOOLEAN
);


-- This table holds records of volunteer involving organisations.
CREATE TABLE charities (
    charity_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(30) NOT NULL,
    description VARCHAR(200),
    active BOOLEAN
);

-- Volunteering role categories are listed here.
CREATE TABLE role_categories(
    category_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50) NOT NULL,
    parent_id INT REFERENCES role_categories(category_id)
);

-- This table lists volunteering roles.
CREATE TABLE roles(
    role_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(250),
    category_id INT REFERENCES role_categories(category_id),
    charity_id INT REFERENCES charities(charity_id) NOT NULL,
    urgency VARCHAR(30) 
            CHECK (urgency IN ('non-urgent', 'urgent')),
    min_duration VARCHAR(30)
                 CHECK (min_duration IN ('<1 month', '1 month', '3 months', '6 months')),
    max_duration VARCHAR(30) 
                 CHECK (max_duration IN ('<1 month', '1 month', '3 months', '6 months', '1 year', 'no limit')),
    active BOOLEAN,
    date_added DATE DEFAULT CURRENT_DATE
);

 /* This table lists open calls for volunteers from charity/ volunteer involving organisations.
These records are not associated with specific role dates or shift dates/ times. */ 
CREATE TABLE open_calls(
    open_call_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    charity_id INT REFERENCES charities(charity_id) NOT NULL,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(250) NOT NULL,
    active BOOLEAN,
    date_added DATE DEFAULT CURRENT_DATE
);

/* This table lists shift times and weekdays for roles. One role can have many shift records. */
CREATE TABLE shifts(
    shift_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    role_id INT REFERENCES roles(role_id) NOT NULL,
    weekdays VARCHAR(30)
             CHECK (weekdays IN ('Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun', 'Mon - Fri', 'Weekends', 'All week')),
    times VARCHAR(30) 
          CHECK (times IN ('Morning', 'Afternoon', 'Evening', 'Night', 'All day'))
          CHECK (num_nonnulls(weekdays, times) >= 1)  -- Ensure that at least one of the two fields (weekdays and times) has a non-NULL value for every record
);

/* This table lists the dates of specific shifts (which, in turn, are linked to specific roles).
One shift can have many records in shift_dates. */
CREATE TABLE shift_dates(
    shift_date_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    shift_id INT REFERENCES shifts(shift_id) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    ongoing BOOLEAN
);

/* This table lists dates for roles. Every role should have at least one start date.
One role can have many records in role_dates e.g. roles may be performed on certain dates  multiple times throughout the year. */
CREATE TABLE role_dates(
    role_date_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    role_id INT REFERENCES roles(role_id) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE
);

-- One employer can have many location records (e.g. multiple offices).
CREATE TABLE employer_locations(
    location_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    employer_id INT REFERENCES employers(employer_id) NOT NULL,
    address_line_1 VARCHAR(30) NOT NULL,
    address_line_2 VARCHAR(30),
    address_line_3 VARCHAR(30),
    town_or_city VARCHAR(30) NOT NULL,
    county VARCHAR(30),
    postcode postcode_domain NOT NULL
);

-- One volunteer involving organisation can have many location records (e.g. multiple offices).
CREATE TABLE charity_locations(
    location_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    charity_id INT REFERENCES charities(charity_id) NOT NULL,
    address_line_1 VARCHAR(30) NOT NULL,
    address_line_2 VARCHAR(30),
    address_line_3 VARCHAR(30),
    town_or_city VARCHAR(30) NOT NULL,
    county VARCHAR(30),
    postcode postcode_domain NOT NULL
);

-- This table lists known ESV collaborations between volunteer involving organisations and employers.
CREATE TABLE collaborations(
    collab_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    employer_id INT REFERENCES employers(employer_id) NOT NULL,
    charity_id INT REFERENCES charities(charity_id) NOT NULL, 
    start_date DATE NOT NULL,
    end_date DATE,
    ongoing BOOLEAN
);

/* Some collaborations between employers and volunteer involving organisations are linked to a known and specific role. These roles are listed here. (Other collaborations may be linked to open calls). */
CREATE TABLE collaboration_roles(
    collab_role_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    collab_id INT REFERENCES collaborations(collab_id),
    role_id INT REFERENCES roles(role_id)
);

-- This table stores feedback from charities about ESV collaborations with employers.
CREATE TABLE employer_reviews(
    review_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    employer_id INT REFERENCES employers(employer_id) NOT NULL,
    description VARCHAR(500),
    overall_rating INT 
                   CHECK (overall_rating BETWEEN 1 AND 5),
    collab_id INT REFERENCES collaborations(collab_id) NOT NULL,  -- This field can be used to identify the volunteer involving organisation providing the review
    date_provided DATE NOT NULL
);

-- This table stores feedback from employers about ESV collaborations with volunteer involving organisations.
CREATE TABLE charity_reviews(
    review_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    charity_id INT REFERENCES charities(charity_id),
    description VARCHAR(500),
    overall_rating INT 
                   CHECK (overall_rating BETWEEN 1 AND 5),
    collab_id INT REFERENCES collaborations(collab_id) NOT NULL,  -- This field can be used to identify the employer providing the review
    date_provided DATE NOT NULL
);
