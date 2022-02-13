# Using Machine Learning to Predict Hypoxemia in ICU
*Team M: Anuhya Vajapey, Marie-Laure Charpignon*

### Background
As one of the most common critical illnesses in the Intensive Care Unit (ICU), hypoxemia is a medical condition that occurs when a person’s arterial blood oxygen partial pressure (PaO2) is less than 80 mmHg (PaO2 < 80 mmHg). If mild hypoxemia (60-79 mmHg) is not detected or treated in a timely manner, it will transform into moderate or severe hypoxemia (PaO2 < 60 mmHg or 100 < r = PaO2/FiO2 < 200 when mechanical ventilation is in place, where FiO2 denotes the fraction of inspired oxygen and r representes the Carrico index). But mechanical ventilation can cause multiple organ failures, hence the need to accurately and timely predict hypoxemia. 

The goal of this study is two-fold.

1. To create a predictive model that will detect early signs of hypoxemia (PaO2 < 80mmHg) so that healthcare providers can be alerted for intervention. Early detection of hypoxemia indeed permits timely oxygen therapy, infusion control, and other appropriate treatments that can reverse aggravation without the use of mechanical ventilation.

2. To further predict moderate to severe cases of hypoxemia (PaO2 < 60 mmHg or 100 < r < 200). The purpose is to alert providers for them organize resources and care teams for such patients.

To achieve this, an approach could be to apply a study on clinical intervention prediction using deep networks [1] to the prediction of hypoxemia. Recent publications propose models that are specific to surgery scenarios to help anesthesiologists prevent hypoxemia. While some leverage deep learning exclusively [2], others build ensemble methods and put more emphasis on risk explainability [3] thus revealing both time and procedure effects.
 
### Research Hypotheses
There exists a set of physiological and biochemical indices from vital signs and laboratory indicators that are known to be positively correlated with the occurrence of hypoxemia. We will use these indicators to predict the occurrence of mild hypoxemia (PaO2 < 80 mmHg) on the one hand, and moderate to severe hypoxemia (PaO2 < 60 mmHg or 100 < r < 200) on the other hand.

Among the 44 covariates manually curated by Dr. Cong Feng, we will use statistical analysis in addition to machine learning method to create a model with the most relevant indicators of hypoxemia. For feature selection, we plan on using backward/forward selection or L1/L2 regularization. Then we will build a baseline classification model using either Support Vector Machines (SVM), Random Forests (RF) or Gradient Boosting Trees (GBT). We also plan on implemented a deep learning model to compare performance. We will select the best approach to predict hypoxemia. The model outcome will be a binary variable: 1 for higher risk of developing hypoxemia and 0 otherwise for a window of 4 hours following a collection window of 6 hours. 

### Research Question / Objective
We are hoping to (1) develop a highly reliable and sparse set of indicators for the occurrence of hypoxemia, selecting the most relevant features from the data and (2) transform these indicators into a real-time early warning score for hypoxemia. The outcome is to use these identified variables to predict whether a patient will develop hypoxemia later on. We will collect data from a 6-hour window and then predict whether the patient will develop hypoxemia in a consequential 4-hour window. Note that the task is to predict whether the onset of hypoxemia will happen during the prediction window, using chart events and lab test results collected during the collection window. A six-hour gap will be observed between the collection and the prediction window.
 
### Data Sources 
We use data from the Multiparameter Intelligent Monitoring in Intensive Care (MIMIC-III v1.4 [4]) database. MIMIC is publicly available and contains over 58,000 hospital admissions from approximately 38,600 adults. The databases have been de-identified; all PHIs have been removed and dates have been changed. We will be looking at ICU events ranging from 2001 to 2012.
 
### Study Population 
The study will involve a training and a testing set. We will need an additional set of patients to select our model in validation step.	

Only patients who are older than 15 years old at time of event and had ICU stays from 24 hours onwards are considered. Physiological factors of hypoxemia are known to be different for children and lab tests are also interpreted differently since the normal heart rate scale is shifted, among other reasons. Therefore, the study excludes any infants.

1. To predict early stages of hypoxemia, we include adult (> 15 years old) ICU patients of all diagnoses. In training phase, patients whose outcome is 0 did not develop hypoxemia nor required mechanical ventilation throughout their stay in ICU. Patients whose outcome is 1 must have had at least one PaO2 test result before the onset of hypoxemia and should be diagnosed with hypoxemia but not administered with mechanical ventilation, within the following 24 hours spent in ICU. To be specific, it means that any mechanical ventilation event preceding test or diagnosis will be excluded. Yet, if all of the above are satisfied and mechanical ventilation happens to be prescribed after the first day in the ICU, the record is not discarded. 

If this scenario happens, we will consider more than one PaO2 < 80 mmHg data point per patient x ICU stay. But note that the time between two consecutive occurences of PaO2 < 80 mmHg has to be longer than 6 hours to ensure these events are distinct i.e. that they do not overlap.
 
2.  To predict moderate to severe cases of hypoxemia, we include adult (> 15 years old) ICU patients of all diagnoses, admitted to ICU for at least 24 hours before starting mechanical ventilation and who have at least one record of r = PaO2 / FiO2 between 100 and 200 during their ICU stay.
 
### Study Outcomes 
The study outcome is to determine a group of physiological and biochemical indices that are most closely related to the occurrence of hypoxemia. To identify patients suffering from hypoxemia in the database, we have five options – listed below.
* Leveraging PaO2 test result only - It is a positive hypoxemia case if the value is less than 80 mmHg.
* Leveraging PaO2 and FiO2 arterial blood gas measures together - The patient may be given oxygen right away when the oxygen saturation drops and remains low, so by the time the arterial blood gas is drawn the Pa02 has gone up. Therefore, Dr. Leo Celi recommends computing the Carrico index r = PaO2/FiO2 ratio to look for episodes of moderate to severe hypoxemia (100 < r < 200) for intubated patients.
* Using chart events related to arterial blood gas - Items ID 779 and 220224 have been successfully identified by Dr. Lu Shen, and if reliable we could also use Arterial Blood Gases (ABG) test results (item ID 3837).
*	Relying on International Classification of Diseases (ICD) codes - The ICD-9 code for Hypoxemia is 799.02 and after October 2015, the ICD-10 code R09.02 is used.
*	Parsing medical notes and looking for various substrings of “hypoxemia” using regular expressions.	

As a first step, we will opt for chart events and lab test results only. If sensitivity analysis reveals that it matters, and if time permits, we will include signals from ICD codes and medical notes to refine the outcome variable.

### Covariate(s) of Interest (Exposure)
The covariates of interest can be classified in four main categories. You can find more details below.

1. Vital signs (from Chart Events in MIMIC-III data): blood pressure, heart rate, respiration rate, oxygen saturation, body temperature, inputs and outputs;	
2. Laboratory indicators (from Lab Events in MIMIC-III data): routine blood tests and biochemical blood tests, white blood cell, hemoglobin, red blood cell, platelet count, calcitonin, C-reactive protein, Interleukin 6 (IL-6), blood lactic acid, Alanine Transaminase (ALT), Aspartate Aminotransferase (AST), urea nitrogen, creatinine, amylase, lipase and blood coagulation function (Activated Partial Thromboplastin Time (APTT), Prothrombin Time (PT) and International Normalized Ratio (INR), D-dimer, fibrinogen);	
3. Surgery history: cardiovascular and pulmonary surgery events in particular (binary presence, categorical variable counting the number of events and recency to account for potential time effects);
4. Past ICU and emergency room visits as well as hospitalizations: number and frequency of such cases, average / median length of stay and recency (i.e. time between last visit and window start time).

Note that inputs and outputs (2) are particularly useful when studying ICU patients, yet complicated to handle technically in the MIMIC-III data. Inputs are any fluids which have been administered to the patients such as oral or tube feedings or intravenous solutions containing medications. Outputs are fluids which have either been excreted by the patient, such as urine output, or extracted from the patient, for example through a drain. Also note that past stays might be difficult to get.

### Confounders
It is critical to incorporate into the model severity scores for each of the diseases a patient may have. Medical information and diagnoses that can be collected from patient history may include the following:	
*	main patient characteristics, including gender, age and ethnicity as well as height, weight and BMI (from Chart Events in MIMIC-III);
*	allergy, smoking and diabetes history;
*	anemia, ARDS (Acute Respiratory Distress Syndrome), asthma, pneumonia, sleep apnea and known chronic diseases;
*	lung-specific diseases such as interstitial lung disease, pneumothorax (collapsed lung), pulmonary edema (excess fluid in the lungs), pulmonary embolism (blood clot in an artery in the lung), COPD (Chronic Obstructive Pulmonary Disease, which emphysema is a specific case) and pulmonary fibrosis (scarred and damaged lungs);
*	heart-specific diseases such as congenital heart disease (in the case of adults).	
*	Drugs that have downside effects in that they depress breathing, such as certain narcotics and anesthetics. Later in the project, we may include the number of different drugs taken along with dosage. The time at which the patient started taking the drugs and treatment duration should also be considered. Any recent switch in medications taken and / or in their dosage might also have an impact and therefore should be considered. 
-- *Note that such data only exists for ICU patients treated between 2008 and 2012. Between 2001 and 2008, information is only available for medication administered via intravenous pipeline. We have the possibility to aggregate ICU stay history at the hospital-patient level. Recurrence of hypoxemia episodes is common among preterm children; it might not be the case for adults, but it is an aspect we should explore to decide whether to include it as part of the final model where data would then be aggregated at the patient level instead of the event level (assuming independence).*

### Acknowledgements
Dr. Cong Feng, Dr. Lu Shen, Aldo Arévalo, Dr. Leo Anthony Celi.
 
### References 
[1] “Clinical Intervention Prediction and Understanding using Deep
Networks”; H. Suresh, N. Hunt, A. Johnson, L.A. Celi, P. Szolovits, M. Ghassemi (2017).


[2]“Anesthesiologist-level forecasting of hypoxemia with only SpO2 data using deep learning”;
G. Erion, H. Chen, S.M. Lundberg, S.-I. Lee; 31st Conference on Neural Information Processing Systems (NIPS 2017), Long Beach, CA, USA.


[3] “Explainable machine learning predictions to help anesthesiologists prevent hypoxemia during surgery”; S.M. Lundberg, B. Nair, M.S. Vavilala (2017).


[4] “MIMIC-III, a freely accessible critical care database”; A. Johnson, T.J. Pollard, L. Shen, L. Lehman, M. Feng, M. Ghassemi, B. Moody, P. Szolovits, L.A. Celi, R.G. Mark; Scientific Data (2016).





