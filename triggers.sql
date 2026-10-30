-- Triggers

-- Deactivate roles associated with a volunteer involving organisation when the organisation's record is marked as inactive.
CREATE OR REPLACE FUNCTION deactivate_roles()
RETURNS TRIGGER
AS
$$
BEGIN
    IF (NEW.active = FALSE AND OLD.active = TRUE) THEN  -- If updated record has 'active' changed to FALSE
        UPDATE roles
	SET active = FALSE
	WHERE charity_id = NEW.charity_id;  -- Only update roles with the deactivated volunteer involving organisation's charity_id	
        RAISE NOTICE 'Any active roles with this organisation have been marked as inactive.';
    END IF;
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER deactivate_roles_trigger
AFTER UPDATE OF active
ON charities
FOR EACH ROW
EXECUTE FUNCTION deactivate_roles();

/*  When a new record is inserted into the shift_dates table for a given role, check whether
there is also a record in the role_dates table for the same role.
If not, generate a message (NOTICE). */
CREATE OR REPLACE FUNCTION check_shift_dates()
RETURNS TRIGGER
AS
$$
DECLARE role_var INT;  -- Variable to store value of role_id for the relevant role
BEGIN

    -- First, find the role_id using the shift_id of the inserted shift_dates record
    SELECT
        shifts.role_id
	FROM shifts
	INNER JOIN shift_dates
	    USING (shift_id)
	WHERE shift_id = NEW.shift_id
	GROUP BY role_id
	INTO role_var;

	 /* Check if a record exists in the role_dates table with the retrieved role_id, 
	where the role's dates cover the date range in the inserted shift_dates record. */
	IF NOT EXISTS (
	    SELECT
                rd.role_id
	    FROM role_dates AS rd
            WHERE rd.role_id = role_var
                AND rd.start_date <= NEW.start_date
	       	AND rd.end_date >= NEW.end_date
	)
        THEN
        RAISE NOTICE 'A record does not exist in role_dates for this role which covers the provided dates.
       	Consider adding a new record to the role_dates table.
	NB: Multiple role_dates records may collectively cover the provided dates.';
        END IF;
        RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER check_shift_dates_trigger 
AFTER INSERT
ON shift_dates
FOR EACH ROW
EXECUTE FUNCTION check_shift_dates();

