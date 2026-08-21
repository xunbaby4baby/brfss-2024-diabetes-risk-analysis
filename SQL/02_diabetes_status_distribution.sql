SELECT
  CASE DIABETE4
    WHEN 1 THEN 'Diabetes'
    WHEN 2 THEN 'Pregnancy only'
    WHEN 3 THEN 'No diabetes'
    WHEN 4 THEN 'Prediabetes / borderline'
    ELSE 'Other / Missing'
  END AS diabetes_status,
  COUNT(*) AS total,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS percentage
FROM
  `polished-zephyr-483903-p9.brfss_diabetes_2024.clean_diabetes_data`
GROUP BY
  DIABETE4
ORDER BY
  DIABETE4;