SELECT subject_id, hadm_id, icustay_id,  hr, label, itemid,
if(label = "RBC" AND units = "#/UL", valuenum*1000,IF(label="CRP" and units = "MG/DL",valuenum*10,valuenum)) AS valuenum,
if(label = "RBC" AND units = "#/UL", "M/UL", IF(label="CRP" and units = "MG/DL", "MG/L",units)) AS units,
if(label = "RBC" AND units = "#/UL", 1, IF(label="CRP" and units = "MG/DL", 1,0)) AS unitchange
FROM `team_M.Cohort_LabItems_Reviewed_new`
WHERE hr > 0 AND units is not null
ORDER BY SUBJECT_ID, HADM_ID, icustay_id,  hr, label, itemid, valuenum, unitchange
