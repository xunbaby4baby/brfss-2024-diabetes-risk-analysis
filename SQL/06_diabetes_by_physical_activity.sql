SELECT
  CASE SAFE_CAST(EXERANY2 AS INT64)
    WHEN 1 THEN 'Physically active'
    WHEN 2 THEN 'No physical activity'
  END AS physical_activity,
  COUNT(*) AS total,
  COUNTIF(DIABETE4 = 1) AS diabetes_cases,
  ROUND(COUNTIF(DIABETE4 = 1) * 100.0 / COUNT(*), 1) AS diabetes_percentage
FROM
  `polished-zephyr-483903-p9.brfss_diabetes_2024.clean_diabetes_data`
WHERE
  EXERANY2 IS NOT NULL
GROUP BY
  EXERANY2
ORDER BY
  SAFE_CAST(EXERANY2 AS INT64);