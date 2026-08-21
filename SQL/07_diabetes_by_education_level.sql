SELECT
  CASE
    WHEN SAFE_CAST(EDUCA AS INT64) BETWEEN 1 AND 3 THEN 'Less than high school'
    WHEN SAFE_CAST(EDUCA AS INT64) = 4 THEN 'High school graduate'
    WHEN SAFE_CAST(EDUCA AS INT64) = 5 THEN 'Some college / technical school'
    WHEN SAFE_CAST(EDUCA AS INT64) = 6 THEN 'College graduate'
  END AS education_level,
  COUNT(*) AS total,
  COUNTIF(DIABETE4 = 1) AS diabetes_cases,
  ROUND(COUNTIF(DIABETE4 = 1) * 100.0 / COUNT(*), 1) AS diabetes_percentage
FROM
  `polished-zephyr-483903-p9.brfss_diabetes_2024.clean_diabetes_data`
WHERE
  EDUCA IS NOT NULL
GROUP BY
  education_level
ORDER BY
  CASE education_level
    WHEN 'Less than high school' THEN 1
    WHEN 'High school graduate' THEN 2
    WHEN 'Some college / technical school' THEN 3
    WHEN 'College graduate' THEN 4
  END;