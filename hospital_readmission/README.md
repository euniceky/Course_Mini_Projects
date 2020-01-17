All-Cause Hospital Readmissions
===============================

_30-Day All-Cause Hospital Readmissions_ is a quality measure that many healthcare organizations use to track their performance. Lower readmission rates indicate better patient outcomes, while higher ones tend to indicate system problems that are negatively impacting patients. The goal of this exercise is to analyze a dataset that simulates hospitalizations for a geriatric patient population in 2015 and 2016 to predict if a patient is likely to have a readmission based on the information available at the time of their initial admission.

You have 3 hours to complete the exercise. If you don't get through all the objectives, that's OK. After 3 hours, please finish what you're working on and send in whatever code, analyses, and visualizations (such as images) you have available. Include comments documenting any assumptions you've made.

Feel free to use the language and statistical/machine learning libraries that you are most comfortable with, and ask questions along the way if any clarifications are necessary.

Data Dictionary
---------------

  * admissions.csv
    * Patient - a unique patient identifier string.
    * AdmitDate - start date of hospital admission (yyyy-MM-dd formatted).
    * LOS - length of hospital stay for the admission in days.

  * claims.csv
    * Patient - a unique patient identifier string.
    * AdmitDate - start date of hospital admission (yyyy-MM-dd formatted).
    * Age - patient's current age at time of admission.
    * Gender - single character gender value for the patient (limited to 2 values for simplicity).
    * PrimaryDx - the primary diagnosis code for the patient.
    * Dx2 - the secondary diagnosis code for the patient (nullable).
    * Dx3 - the tertiary diagnosis code for the patient (nullable).
    * PastPCPVisits - the count of primary care physician visits the patient had in the 12 months prior to admission.

Definitions
-----------

admissions to claims is a 1:1 mapping.

`null` values may be encoded in the CSVs as empty values, empty strings, or "@NA" strings.

Readmission is defined as `<=30 days` from the time of the `AdmitDate` for this exercise rather than the discharge date.

Objectives
----------

  1. Extract, transform, and load (ETL) the CSV data and cleanup null and @NA values.
  2. Determine patients that have a readmission.
  3. Provide univariate analysis on each potential feature.
  4. Fit/train a model that predicts readmissions using admissions that occurred in 2015. An admission that had occurred in December of 2015 may result in a readmission at the beginning of 2016.
  5. Evaluate the model using admissions in 2016 as the test set and provide performance metrics.

