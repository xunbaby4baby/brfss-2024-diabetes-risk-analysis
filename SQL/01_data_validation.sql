SELECT  
  COUNT(*) AS total_rows,
  COUNTIF(DIABETE4 IS NULL) AS diabetes_status_nulls,
  COUNTIF(DIABAGE4 IS NULL) AS diabetes_age_nulls,
  COUNTIF(EDUCA IS NULL) AS education_nulls,
  COUNTIF(INCOME3 IS NULL) AS income_nulls,
  COUNTIF(_AGEG5YR IS NULL) AS age_group_nulls,
  COUNTIF(_AGE80 IS NULL) AS age80_nulls,
  COUNTIF(_BMI5 IS NULL) AS bmi_nulls,
  COUNTIF(_BMI5CAT IS NULL) AS bmi_category_nulls,
  COUNTIF(EXERANY2 IS NULL) AS physical_activity_nulls,
  COUNTIF(SEXVAR IS NULL) AS sex_nulls
FROM
  `polished-zephyr-483903-p9.brfss_diabetes_2024.clean_diabetes_data`;