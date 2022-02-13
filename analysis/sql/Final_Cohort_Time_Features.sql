-- Extract time-dependent features: lab tests, vital signs, crystalloids and vasopressors
-- At the patient-, admission- and stay-level
-- Average value per hour for continuous features, check for presence within one-hour time window for binary features

-- refer to query_X in Python code

select distinct *
from (

select t.subject_id,
t.hadm_id,
t.icustay_id,
t.hr,

-- Lab tests
ALB.ALBUMIN_avgval,
ALT.ALT_avgval,
AMYLASE.AMYLASE_avgval,
ANION_GAP.ANION_GAP_avgval,
AST.AST_avgval,
BANDS.BANDS_avgval,
BICARBONATE.BICARBONATE_avgval,
BILIRUBIN.BILIRUBIN_avgval,
BUN.BUN_avgval,
CHLORIDE.CHLORIDE_avgval,
CK.CK_avgval,
CKISO.CKISO_avgval,
CREATININE.CREATININE_avgval,
CRP.CRP_avgval,
D_DIMER.D_DIMER_avgval,
FIBRINOGEN.FIBRINOGEN_avgval,
FREE_CALCIUM.FREE_CALCIUM_avgval,
GLUCOSE.GLUCOSE_avgval,
HEMATOCRIT.HEMATOCRIT_avgval,
HEMOGLOBIN.HEMOGLOBIN_avgval,
INR.INR_avgval,
LACTATE.LACTATE_avgval,
LIPASE.LIPASE_avgval,
NEUTROPHILS.NEUTROPHILS_avgval,
NTPROBNP.NTPROBNP_avgval,
PH.PH_avgval,
PLATELET.PLATELET_avgval,
POTASSIUM.POTASSIUM_avgval,
-- at the end, we chose not to include PT, following a piece of advice from Dr. Leo Celi (we used INR and PTT instead): PT.PT_avgval,
PTT.PTT_avgval,
RBC.RBC_avgval,
SODIUM.SODIUM_avgval,
TROPONIN_T.TROPONIN_T_avgval,
WBC.WBC_avgval,

-- Vital Signs
HR.HR_avgval,
DiasBP.DiasBP_avgval,
SysBP.SysBP_avgval,
MeanBP.MeanBP_avgval,
RespRate.RespRate_avgval,
TempC.TempC_avgval,

-- Crystalloids
CRYSTALLOID.CRYSTALLOID_binary,
CRYSTALLOID.CRYSTALLOID_sum,

-- Vasopressors
VASOPRESSORS.VASOPRESSOR_binary

from `team_M.to_be_merged` t

-- Joins

-- Lab tests
left join `team_M.ALB_join`as ALB on t.subject_id = ALB.subject_id and t.hadm_id = ALB.hadm_id and t.icustay_id = ALB.icustay_id and t.hr = ALB.hr
left join `team_M.ALT_join`as ALT on t.subject_id = ALT.subject_id and t.hadm_id = ALT.hadm_id and t.icustay_id = ALT.icustay_id and t.hr = ALT.hr
left join `team_M.AMYLASE_join`as AMYLASE on t.subject_id = AMYLASE.subject_id and t.hadm_id = AMYLASE.hadm_id and t.icustay_id = AMYLASE.icustay_id and t.hr = AMYLASE.hr
left join `team_M.ANION_GAP_join`as ANION_GAP on t.subject_id = ANION_GAP.subject_id and t.hadm_id = ANION_GAP.hadm_id and t.icustay_id = ANION_GAP.icustay_id and t.hr = ANION_GAP.hr
left join `team_M.AST_join`as AST on t.subject_id = AST.subject_id and t.hadm_id = AST.hadm_id and t.icustay_id = AST.icustay_id and t.hr = AST.hr
left join `team_M.BANDS_join`as BANDS on t.subject_id = BANDS.subject_id and t.hadm_id = BANDS.hadm_id and t.icustay_id = BANDS.icustay_id and t.hr = BANDS.hr
left join `team_M.BICARBONATE_join`as BICARBONATE on t.subject_id = BICARBONATE.subject_id and t.hadm_id = BICARBONATE.hadm_id and t.icustay_id = BICARBONATE.icustay_id and t.hr = BICARBONATE.hr
left join `team_M.BILIRUBIN_join`as BILIRUBIN on t.subject_id = BILIRUBIN.subject_id and t.hadm_id = BILIRUBIN.hadm_id and t.icustay_id = BILIRUBIN.icustay_id and t.hr = BILIRUBIN.hr
left join `team_M.BUN_join`as BUN on t.subject_id = BUN.subject_id and t.hadm_id = BUN.hadm_id and t.icustay_id = BUN.icustay_id and t.hr = BUN.hr
left join `team_M.CHLORIDE_join`as CHLORIDE on t.subject_id = CHLORIDE.subject_id and t.hadm_id = CHLORIDE.hadm_id and t.icustay_id = CHLORIDE.icustay_id and t.hr = CHLORIDE.hr
left join `team_M.CK_join`as CK on t.subject_id = CK.subject_id and t.hadm_id = CK.hadm_id and t.icustay_id = CK.icustay_id and t.hr = CK.hr
left join `team_M.CKISO_join`as CKISO on t.subject_id = CKISO.subject_id and t.hadm_id = CKISO.hadm_id and t.icustay_id = CKISO.icustay_id and t.hr = CKISO.hr
left join `team_M.CREATININE_join`as CREATININE on t.subject_id = CREATININE.subject_id and t.hadm_id = CREATININE.hadm_id and t.icustay_id = CREATININE.icustay_id and t.hr = CREATININE.hr
left join `team_M.CRP_join`as CRP on t.subject_id = CRP.subject_id and t.hadm_id = CRP.hadm_id and t.icustay_id = CRP.icustay_id and t.hr = CRP.hr
left join `team_M.D_DIMER_join`as D_DIMER on t.subject_id = D_DIMER.subject_id and t.hadm_id = D_DIMER.hadm_id and t.icustay_id = D_DIMER.icustay_id and t.hr = D_DIMER.hr
left join `team_M.FIBRINOGEN_join`as FIBRINOGEN on t.subject_id = FIBRINOGEN.subject_id and t.hadm_id = FIBRINOGEN.hadm_id and t.icustay_id = FIBRINOGEN.icustay_id and t.hr = FIBRINOGEN.hr
left join `team_M.FREE_CALCIUM_join`as FREE_CALCIUM on t.subject_id = FREE_CALCIUM.subject_id and t.hadm_id = FREE_CALCIUM.hadm_id and t.icustay_id = FREE_CALCIUM.icustay_id and t.hr = FREE_CALCIUM.hr
left join `team_M.GLUCOSE_join` as GLUCOSE on t.subject_id = GLUCOSE.subject_id and t.hadm_id = GLUCOSE.hadm_id and t.icustay_id = GLUCOSE.icustay_id and t.hr = GLUCOSE.hr
left join `team_M.HEMATOCRIT_join`as HEMATOCRIT on t.subject_id = HEMATOCRIT.subject_id and t.hadm_id = HEMATOCRIT.hadm_id and t.icustay_id = HEMATOCRIT.icustay_id and t.hr = HEMATOCRIT.hr
left join `team_M.HEMOGLOBIN_join`as HEMOGLOBIN on t.subject_id = HEMOGLOBIN.subject_id and t.hadm_id = HEMOGLOBIN.hadm_id and t.icustay_id = HEMOGLOBIN.icustay_id and t.hr = HEMOGLOBIN.hr
left join `team_M.INR_join`as INR on t.subject_id = INR.subject_id and t.hadm_id = INR.hadm_id and t.icustay_id = INR.icustay_id and t.hr = INR.hr
left join `team_M.LACTATE_join`as LACTATE on t.subject_id = LACTATE.subject_id and t.hadm_id = LACTATE.hadm_id and t.icustay_id = LACTATE.icustay_id and t.hr = LACTATE.hr
left join `team_M.LIPASE_join`as LIPASE on t.subject_id = LIPASE.subject_id and t.hadm_id = LIPASE.hadm_id and t.icustay_id = LIPASE.icustay_id and t.hr = LIPASE.hr
left join `team_M.NEUTROPHILS_join`as NEUTROPHILS on t.subject_id = NEUTROPHILS.subject_id and t.hadm_id = NEUTROPHILS.hadm_id and t.icustay_id = NEUTROPHILS.icustay_id and t.hr = NEUTROPHILS.hr
left join `team_M.NTPROBNP_join`as NTPROBNP on t.subject_id = NTPROBNP.subject_id and t.hadm_id = NTPROBNP.hadm_id and t.icustay_id = NTPROBNP.icustay_id and t.hr = NTPROBNP.hr
left join `team_M.PH_join` as PH on t.subject_id = PH.subject_id and t.hadm_id = PH.hadm_id and t.icustay_id = PH.icustay_id and t.hr = PH.hr
left join `team_M.PLATELET_join` as PLATELET on t.subject_id = PLATELET.subject_id and t.hadm_id = PLATELET.hadm_id and t.icustay_id = PLATELET.icustay_id and t.hr = PLATELET.hr
left join `team_M.POTASSIUM_join` as POTASSIUM on t.subject_id = POTASSIUM.subject_id and t.hadm_id = POTASSIUM.hadm_id and t.icustay_id = POTASSIUM.icustay_id and t.hr = POTASSIUM.hr
-- at the end, we chose not to include PT, following a piece of advice from Dr. Leo Celi (we used INR and PTT instead): left join `team_M.PT_join`as PT on t.subject_id = PT.subject_id and t.hadm_id = PT.hadm_id and t.icustay_id = PT.icustay_id and t.hr = PT.hr
left join `team_M.PTT_join`as PTT on t.subject_id = PTT.subject_id and t.hadm_id = PTT.hadm_id and t.icustay_id = PTT.icustay_id and t.hr = PTT.hr
left join `team_M.RBC_join`as RBC on t.subject_id = RBC.subject_id and t.hadm_id = RBC.hadm_id and t.icustay_id = RBC.icustay_id and t.hr = RBC.hr
left join `team_M.SODIUM_join`as SODIUM on t.subject_id = SODIUM.subject_id and t.hadm_id = SODIUM.hadm_id and t.icustay_id = SODIUM.icustay_id and t.hr = SODIUM.hr
left join `team_M.TROPONIN_T_join`as TROPONIN_T on t.subject_id = TROPONIN_T.subject_id and t.hadm_id = TROPONIN_T.hadm_id and t.icustay_id = TROPONIN_T.icustay_id and t.hr = TROPONIN_T.hr
left join `team_M.WBC_join`as WBC on t.subject_id = WBC.subject_id and t.hadm_id = WBC.hadm_id and t.icustay_id = WBC.icustay_id and t.hr = WBC.hr

-- Vital Signs
left join `team_M.HR_join`as HR on t.subject_id = HR.subject_id and t.hadm_id = HR.hadm_id and t.icustay_id = HR.icustay_id and t.hr = HR.hr
left join `team_M.DiasBP_join`as DiasBP on t.subject_id = DiasBP.subject_id and t.hadm_id = DiasBP.hadm_id and t.icustay_id = DiasBP.icustay_id and t.hr = DiasBP.hr
left join `team_M.SysBP_join`as SysBP on t.subject_id = SysBP.subject_id and t.hadm_id = SysBP.hadm_id and t.icustay_id = SysBP.icustay_id and t.hr = SysBP.hr
left join `team_M.MeanBP_join`as MeanBP on t.subject_id = MeanBP.subject_id and t.hadm_id = MeanBP.hadm_id and t.icustay_id = MeanBP.icustay_id and t.hr = MeanBP.hr
left join `team_M.RespRate_join`as RespRate on t.subject_id = RespRate.subject_id and t.hadm_id = RespRate.hadm_id and t.icustay_id = RespRate.icustay_id and t.hr = RespRate.hr
left join `team_M.TempC_join`as TempC on t.subject_id = TempC.subject_id and t.hadm_id = TempC.hadm_id and t.icustay_id = TempC.icustay_id and t.hr = TempC.hr

-- Crystalloids
left join `team_M.CRYSTALLOID_join_reviewed_new_2`as CRYSTALLOID on t.subject_id = CRYSTALLOID.subject_id and t.hadm_id = CRYSTALLOID.hadm_id and t.icustay_id = CRYSTALLOID.icustay_id and t.hr = CRYSTALLOID.hr

-- Vasopressors
left join `team_M.VASOPRESSORS_join_reviewed_new_2`as VASOPRESSORS on t.subject_id = VASOPRESSORS.subject_id and t.hadm_id = VASOPRESSORS.hadm_id and t.icustay_id = VASOPRESSORS.icustay_id and t.hr = VASOPRESSORS.hr

-- if needed you can filter for subject ids of your choice: WHERE t.subject_id > ? and t.subject_id <= ?

ORDER BY subject_id, hadm_id, icustay_id, hr)
ORDER BY subject_id, hadm_id, icustay_id, hr
