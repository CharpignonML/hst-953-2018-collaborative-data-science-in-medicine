SELECT subject_id, hadm_id, icustay_id, hr,
avg(valuenum) as AST_avgval
FROM (SELECT subject_id, hadm_id, icustay_id, floor(hr) AS hr,
valuenum
FROM `team_M.Cohort_LabItems_Reviewed_UnitChange1_new`
WHERE label = 'BUN' AND hr <= 168)
GROUP BY SUBJECT_ID, HADM_ID, icustay_id, hr
ORDER BY SUBJECT_ID, HADM_ID, icustay_id, hr
