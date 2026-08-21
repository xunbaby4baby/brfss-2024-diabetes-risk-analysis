WITH age_data AS (
  SELECT
    CASE
      WHEN SAFE_CAST(_AGEG5YR AS INT64) BETWEEN 1 AND 5 THEN '18-44'
      WHEN SAFE_CAST(_AGEG5YR AS INT64) BETWEEN 6 AND 9 THEN '45-64'
      WHEN SAFE_CAST(_AGEG5YR AS INT64) BETWEEN 10 AND 11 THEN '65-74'
      WHEN SAFE_CAST(_AGEG5YR AS INT64) BETWEEN 12 AND 13 THEN '75+'
    END AS age_group,
    DIABETE4
  FROM
    `polished-zephyr-483903-p9.brfss_diabetes_2024.clean_diabetes_data`
  WHERE
    _AGEG5YR IS NOT NULL
)

SELECT
  age_group,
  COUNT(*) AS total,
  COUNTIF(DIABETE4 = 1) AS diabetes_cases,
  ROUND(COUNTIF(DIABETE4 = 1) * 100.0 / COUNT(*), 1) AS diabetes_percentage
FROM
  age_data
GROUP BY
  age_group
ORDER BY
  CASE age_group
    WHEN '18-44' THEN 1
    WHEN '45-64' THEN 2
    WHEN '65-74' THEN 3
    WHEN '75+' THEN 4
  END;