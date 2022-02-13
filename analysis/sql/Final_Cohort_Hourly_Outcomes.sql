-- Extract binary outcomes
-- At the patient-, admission- and stay-level
-- One binary outcome per hour

-- refer to query_Y in Python code

select t.*,
if(y.PF_minval_less is null, 0, y.PF_minval_less) as Y

from  `team_M.to_be_merged` t

left join  `team_M.PaO2_FiO2_ratios_per_hour_with_booleans` y

on t.subject_id = y.subject_id and t.hadm_id = y.hadm_id and t.icustay_id = y.icustay_id and t.hr = y.hr

-- if needed you can filter for subject ids of your choice: where t.subject_id > ? and t.subject_id <= ?
