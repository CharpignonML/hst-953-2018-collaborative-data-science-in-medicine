-- Extract value for length of stay
-- At the patient-, admission- and stay-level
-- Truncate at 168 hours (i.e. 7 days) if the patient stays longer

-- Note that this is needed to build up the slices that constitute the 3D tensor

-- Refer to "query_lengths" in Python code

select distinct subject_id, 
       hadm_id,
       icustay_id,
       if(floor(los*24)+1 > 168, 168, floor(los*24)+1) as los 
         
from `team_M.LuStep1_new_new`
 
-- if needed you can filter for subject ids of your choice: where icu_stay_rank = 1 and subject_id > ? and subject_id <= ?

group by subject_id, hadm_id, icustay_id, los
order by subject_id, hadm_id, icustay_id
