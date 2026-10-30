-- Find open calls for volunteers which are active and were added recently (in the example below, within the last six months)
SELECT
    oc.open_call_id,
    oc.charity_id,
    oc.name,
    oc.description,
    oc.active,
    oc.date_added
FROM open_calls as oc
WHERE oc.active IS NOT FALSE
    AND oc.date_added > (CURRENT_DATE - INTERVAL '6 months');  -- Added within the last six months

