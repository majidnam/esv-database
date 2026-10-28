-- Dummy data
/* Note: all data below are fake data. 
Therefore, all employers, charities, organisations, roles, reviews, addresses, and all references in the data below, are fictional. */

INSERT INTO employers
VALUES
    (DEFAULT, 'Fictional Employer 1', 'Tech consulting company.', TRUE),
    (DEFAULT, 'Fictional Employer 2', 'Marketing company.', TRUE),
    (DEFAULT, 'Fictional Employer 3', 'Publishing company.', FALSE)
;

INSERT INTO charities
VALUES
    (DEFAULT, 'Fictional Charity 1', 'Offers digital skills support and training.', TRUE),
    (DEFAULT, 'Fictional Charity 2', 'Advocates for people in poverty.', TRUE),
    (DEFAULT, 'Fictional Charity 3', 'Wildlife and park conservation charity.', FALSE)
;

INSERT INTO role_categories
VALUES
    (DEFAULT, 'Administrative work', NULL),
    (DEFAULT, 'Outdoor work', NULL),
    (DEFAULT, 'Fundraising', NULL),
    (DEFAULT, 'Training and mentoring', NULL),
    (DEFAULT, 'General administrative work', 1),  -- This is a subcategory of the 'Administrative work' category
    (DEFAULT, 'Park volunteering', 2),  -- This is a subcategory of the 'Outdoor work' category
    (DEFAULT, 'Fundraising via telephone', 3),  -- This is a subcategory of the 'Fundraising' category
    (DEFAULT, 'In-person fundraising activities', 3),  -- This is a subcategory of the 'Fundraising' category
    (DEFAULT, 'Career mentoring', 4),  -- This is a subcategory of the 'Training and mentoring' category
    (DEFAULT, 'Digital skills mentoring', 4)  -- This is a subcategory of the 'Training and mentoring' category
;

INSERT INTO roles
VALUES
    (DEFAULT, 'Career mentor', 'Seeking volunteers to offer career-related mentoring, focusing on digital skills.', 5, 1, 'non-urgent', '<1 month', '3 months', TRUE, DEFAULT),
    (DEFAULT, 'Digital skills mentor', 'Looking for volunteers to offer digital skills training.', 6, 1, 'urgent', '1 month', '3 months', TRUE, DEFAULT),
    (DEFAULT, 'Park volunteer', 'Looking for enthusiastic volunteers to help maintain visitor areas at Fictional Park.', 2, 3, 'urgent', '3 months', 'no limit', TRUE, DEFAULT)
;

INSERT INTO open_calls 
VALUES
    (DEFAULT, 1, 'Open to collaboration and ideas!', 'If you would like to explore ways in which your organisation may be able to help with any of our projects, or suggest new ideas, we want to hear from you.', TRUE, DEFAULT)
;

INSERT INTO shifts
VALUES
    (DEFAULT, 1, 'Mon', 'Afternoon'),
    (DEFAULT, 1, 'Tue', 'Morning'),
    (DEFAULT, 2, 'Mon', 'Evening'),
    (DEFAULT, 1, 'Wed', 'Morning'),
    (DEFAULT, 1, 'Wed', 'Afternoon'),
    (DEFAULT, 1, 'Thu', 'Morning')
;

INSERT INTO shift_dates
VALUES
    (DEFAULT, 1, '2026-04-10', NULL, TRUE),
    (DEFAULT, 2, '2026-04-10', NULL, TRUE),
    (DEFAULT, 4, '2026-04-10', NULL, TRUE),
    (DEFAULT, 5, '2026-04-10', NULL, TRUE),
    (DEFAULT, 6, '2026-05-01', NULL, TRUE)
;

INSERT INTO role_dates
VALUES
    (DEFAULT, 1, '2026-03-01', '2026-12-01'),
    (DEFAULT, 1, '2027-03-01', '2027-12-01'),
    (DEFAULT, 2, '2026-02-15', '2027-02-15'),
    (DEFAULT, 3, '2026-03-15', NULL)
;
 
INSERT INTO collaborations
VALUES
    (DEFAULT, 1, 1, '2026-05-05', NULL, TRUE),  -- This is a collaboration between the tech consulting company and the digital skills charity
    (DEFAULT, 2, 2, '2026-06-06', '2026-08-06', FALSE),  -- This is a collaboration between the marketing company and the poverty charity
    (DEFAULT, 3, 1, '2026-06-10', NULL, TRUE)  -- This is a collaboration between the publishing company and the digital skills charity
;

INSERT INTO collaboration_roles
VALUES
    (DEFAULT, 1, 1)  -- This collaboration relates to the career mentoring role (collab_id = 1) between the tech consulting company and the digital skills charity
;

INSERT INTO employer_locations
VALUES
    (DEFAULT, 1, '1', 'Fictional Street', 'Fictional Area', 'Fictional Town', 'Fictional County', 'AA1 1AA'),
    (DEFAULT, 2, '2', 'Fictional Road', 'Fictional District', 'Fictional City', 'Fictional County', 'AA1 0AA'),
    (DEFAULT, 2, '10', 'Fictional Street', 'Fictional Area', 'Fictional Town', 'Fictional County', 'AA1 1AB'),
    (DEFAULT, 3, '3', 'Fictional Way', 'Fictional Zone', 'Fictional City', 'Imaginary County', 'AA10 1BA') 
;

INSERT INTO charity_locations
VALUES
    (DEFAULT, 1, '6', 'Fictional Street', 'Fictional Area', 'Fictional Town', 'Fictional County', 'AA1 0AB'),
    (DEFAULT, 2, '7', 'Fictional Road', 'Fictional District', 'Fictional City', 'Fictional County', 'AA1 1BA'),
    (DEFAULT, 3, '8', 'Fictional High Street', 'Fictional Zone', 'Fictional City', 'Imaginary County', 'AA10 1AA'),
    (DEFAULT, 2, '15', 'Fictional Way', 'Fictional Zone', 'Fictional City', 'Imaginary County', 'AA10 0AA'),
    (DEFAULT, 3, '17', 'Fictional Way', 'Fictional Zone', 'Fictional City', 'Imaginary County', 'AA10 1AB')
; 

INSERT INTO employer_reviews
VALUES
    (DEFAULT, 1, 'This employer has been a pleasure to work with!', 5, 1, '2026-09-01'),  -- This feedback from the digital skills charity is about the tech consulting company, and is linked to the career mentoring role
    (DEFAULT, 2, 'This employer provided us with a lot of valuable expertise.', 4, 2, '2026-08-07')  -- This feedback from the poverty support charity is about the marketing company, and is not linked to a role
;

INSERT INTO charity_reviews
VALUES
    (DEFAULT, 1, 'Our employees reported that they found this to be a rewarding experience.', 4, 1, '2026-07-15'),  -- This review from the tech consulting company is about the digital skills charity 
    (DEFAULT, 2, 'Due to their hard work, organising the volunteering placements was a smooth process.', 4, 2, '2026-08-10')  -- This review from the marketing company is about the poverty support charity
;
