SELECT
  CASE
    WHEN SAFE_CAST(INCOME3 AS INT64) BETWEEN 1 AND 4
      THEN 'Less than $25,000'
    WHEN SAFE_CAST(INCOME3 AS INT64) BETWEEN 5 AND 6
      THEN '$25,000-$49,999'
    WHEN SAFE_CAST(INCOME3 AS INT64) BETWEEN 7 AND 8
      THEN '$50,000-$99,999'
    WHEN SAFE_CAST(INCOME3 AS INT64) BETWEEN 9 AND 11
      THEN '$100,000 or more'
  END AS income_group,
  COUNT(*) AS total,
  COUNTIF(DIABETE4 = 1) AS diabetes_cases,
  ROUND(COUNTIF(DIABETE4 = 1) * 100.0 / COUNT(*), 1) AS diabetes_percentage
FROM
  `polished-zephyr-483903-p9.brfss_diabetes_2024.clean_diabetes_data`
WHERE
  SAFE_CAST(INCOME3 AS INT64) BETWEEN 1 AND 11
GROUP BY
  income_group
ORDER BY
  CASE income_group
    WHEN 'Less than $25,000' THEN 1
    WHEN '$25,000-$49,999' THEN 2
    WHEN '$50,000-$99,999' THEN 3
    WHEN '$100,000 or more' THEN 4
  END;