SELECT
  CASE SEXVAR
    WHEN 1 THEN 'Male'
    WHEN 2 THEN 'Female'
    ELSE 'Other / Missing'
  END AS sex,
  COUNT(*) AS total,
  COUNTIF(DIABETE4 = 1) AS diabetes_cases,
  ROUND(COUNTIF(DIABETE4 = 1) * 100.0 / COUNT(*), 1) AS diabetes_percentage
FROM
  `polished-zephyr-483903-p9.brfss_diabetes_2024.clean_diabetes_data`
GROUP BY
  SEXVAR
ORDER BY
  SEXVAR;