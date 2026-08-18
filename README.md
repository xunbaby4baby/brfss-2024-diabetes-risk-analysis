# Diabetes Risk Factors and Population Health Analysis in the United States

## Project Overview

This project analyzes diabetes-related demographic, behavioral, and socioeconomic patterns using the CDC Behavioral Risk Factor Surveillance System (BRFSS) 2024 dataset.

The project follows the Google Data Analytics workflow:

**Ask → Prepare → Process → Analyze → Share → Act**

Because of computational resource limitations during development, the current exploratory analysis uses a **1,000-record development sample**. Results presented at this stage are exploratory and should not be interpreted as nationally representative U.S. prevalence estimates.

## Project Objectives

- Examine diabetes status across demographic and socioeconomic groups.
- Explore relationships between diabetes and age, BMI, physical activity, education, and household income.
- Develop a reproducible public health analytics workflow using R, SQL, and Tableau.
- Translate analytical findings into clear public health insights and visualizations.

## Data Source

- **Dataset:** CDC Behavioral Risk Factor Surveillance System (BRFSS) 2024
- **Organization:** Centers for Disease Control and Prevention (CDC)
- **Original format:** SAS Transport (`.XPT`)
- **Development sample:** 1,000 records
- **Variables analyzed:** diabetes status, age, sex, BMI, physical activity, education, and household income

## Tools

- **R / Posit Cloud** — data cleaning, exploratory data analysis, and visualization
- **SQL** — planned analytical querying
- **Tableau** — planned dashboard development
- **Microsoft Word** — analytical reporting
- **GitHub** — project documentation and version control

## Exploratory Data Analysis

The initial EDA identified several patterns within the BRFSS 2024 development sample:

- Diabetes was reported by **27.5%** of the development sample.
- Diabetes percentages were similar between females (**28.0%**) and males (**26.3%**).
- The highest observed diabetes percentage among broad age groups occurred among adults ages **65–74 (31.1%)**.
- Participants classified as obese had the highest diabetes percentage among BMI groups (**36.1%**).
- Participants reporting no physical activity had a higher diabetes percentage (**31.7%**) than physically active participants (**24.9%**).
- Participants with less than a high school education had the highest diabetes percentage by education level (**37.0%**).
- Diabetes percentages decreased across the broad household-income categories, from **34.8%** among participants earning less than $25,000 to **20.3%** among those earning $100,000 or more.

## Important Limitations

The current results are based on an **unweighted development sample of 1,000 BRFSS 2024 records** and are intended for exploratory workflow development.

They should **not** be interpreted as U.S. national diabetes prevalence estimates.

Additional limitations include:

- BRFSS data are largely self-reported.
- Cross-sectional data can identify associations but cannot establish causation.
- Some variables contain missing responses.
- Household income has substantial missing data (**35.4%**).
- A nationally representative analysis would require the complete BRFSS dataset and appropriate survey weights.

## Repository Structure

```text
brfss-2024-diabetes-risk-analysis/
├── Data/
│   └── Processed/
│       └── clean_diabetes_data.csv
├── Docs/
│   └── Diabetes_Risk_Analysis_Report.docx
├── Images/
│   ├── 01_diabetes_status_distribution.png
│   ├── 02_diabetes_by_sex.png
│   ├── 03_diabetes_by_age_group.png
│   ├── 04_diabetes_by_bmi_category.png
│   ├── 05_diabetes_by_physical_activity.png
│   ├── 06_diabetes_by_education_level.png
│   └── 07_diabetes_by_income_level.png
├── R/
│   ├── 02_data_cleaning.R
│   └── 03_eda.R
├── .gitignore
└── README.md
