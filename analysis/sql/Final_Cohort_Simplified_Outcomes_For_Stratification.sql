-- Extract outcomes in order to stratify on that variable when doing the train - validation - test split
-- At the patient-, admission- and stay-level

select t.subject_id,
t.hadm_id,
t.icustay_id,
if(y.max_PF is null, 0, y.max_PF) as Y
from `team_M.to_be_merged` t 

left join (select subject_id,
hadm_id,
icustay_id,
max(PF_minval_less) as max_PF
from `team_M.PaO2_FiO2_ratios_per_hour_with_booleans`
group by subject_id, hadm_id, icustay_id
order by subject_id, hadm_id, icustay_id) y

on t.subject_id = y.subject_id and t.hadm_id = y.hadm_id and t.icustay_id = y.icustay_id

-- if needed you can filter for subject ids of your choice: where t.subject_id > ? and t.subject_id <= ?

group by subject_id, hadm_id, icustay_id, max_PF
order by subject_id, hadm_id, icustay_id
