SELECT
  CASE SAFE_CAST(_BMI5CAT AS INT64)
    WHEN 1 THEN 'Underweight'
    WHEN 2 THEN 'Normal weight'
    WHEN 3 THEN 'Overweight'
    WHEN 4 THEN 'Obese'
  END AS bmi_category,
  COUNT(*) AS total,
  COUNTIF(DIABETE4 = 1) AS diabetes_cases,
  ROUND(COUNTIF(DIABETE4 = 1) * 100.0 / COUNT(*), 1) AS diabetes_percentage
FROM
  `polished-zephyr-483903-p9.brfss_diabetes_2024.clean_diabetes_data`
WHERE
  _BMI5CAT IS NOT NULL
GROUP BY
  _BMI5CAT
ORDER BY
  SAFE_CAST(_BMI5CAT AS INT64);