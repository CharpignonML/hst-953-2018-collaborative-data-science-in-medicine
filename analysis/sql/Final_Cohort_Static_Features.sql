-- Extract static features: mainly demographic
-- At the patient-, admission- and stay-level

-- refer to query_static in Python code

select subject_id,
hadm_id,
icustay_id,
intime,
outtime,
hospital_expire_flag,
gender,
age_category,
ethnicity_category,
admission_type,
admission_location_category,
insurance_category,
marital_status_category

from `team_M.demographics2_final_new`

-- if needed you can filter for subject ids of your choice: where subject_id > ? and subject_id <= ?

order by subject_id, hadm_id,icustay_id
