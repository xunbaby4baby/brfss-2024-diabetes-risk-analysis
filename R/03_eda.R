# ============================================================
# 03_eda.R
# Exploratory Data Analysis
# Diabetes Risk Factors and Population Health Analysis
# ============================================================


# 1. Load Required Packages
library(dplyr)
library(ggplot2)
library(readr)

# 2. Import Clean Dataset

clean_diabetes_data <- read_csv(
  "clean_diabetes_data.csv",
  show_col_types = FALSE
)

# 3. Inspect Clean Dataset
dim(clean_diabetes_data)

names(clean_diabetes_data)

# 4. Diabetes Prevalence
diabetes_prevalence <- clean_diabetes_data %>%
  count(DIABETE4) %>%
  mutate(
    diabetes_status = case_when(
      DIABETE4 == 1 ~ "Diabetes",
      DIABETE4 == 2 ~ "Pregnancy only",
      DIABETE4 == 3 ~ "No diabetes",
      DIABETE4 == 4 ~ "Prediabetes / borderline",
      TRUE ~ "Other / Missing"
    ),
    percentage = round(n / sum(n) * 100, 1)
  ) %>%
  select(DIABETE4, diabetes_status, n, percentage)

diabetes_prevalence

# 5. Demographic Analysis
# Inspect demographic variable codes

table(clean_diabetes_data$SEXVAR, useNA = "ifany")

table(clean_diabetes_data$`_AGEG5YR`, useNA = "ifany")
# Diabetes prevalence by sex

sex_diabetes <- clean_diabetes_data %>%
  mutate(
    sex = case_when(
      SEXVAR == 1 ~ "Male",
      SEXVAR == 2 ~ "Female",
      TRUE ~ NA_character_
    )
  ) %>%
  filter(!is.na(sex)) %>%
  group_by(sex) %>%
  summarise(
    total = n(),
    diabetes_cases = sum(DIABETE4 == 1, na.rm = TRUE),
    diabetes_percentage = round(diabetes_cases / total * 100, 1),
    .groups = "drop"
  )

sex_diabetes
# Diabetes prevalence by age group
age_diabetes <- clean_diabetes_data %>%
  mutate(
    age_group = case_when(
      `_AGEG5YR` == 1  ~ "18-24",
      `_AGEG5YR` == 2  ~ "25-29",
      `_AGEG5YR` == 3  ~ "30-34",
      `_AGEG5YR` == 4  ~ "35-39",
      `_AGEG5YR` == 5  ~ "40-44",
      `_AGEG5YR` == 6  ~ "45-49",
      `_AGEG5YR` == 7  ~ "50-54",
      `_AGEG5YR` == 8  ~ "55-59",
      `_AGEG5YR` == 9  ~ "60-64",
      `_AGEG5YR` == 10 ~ "65-69",
      `_AGEG5YR` == 11 ~ "70-74",
      `_AGEG5YR` == 12 ~ "75-79",
      `_AGEG5YR` == 13 ~ "80+",
      TRUE ~ NA_character_
    )
  ) %>%
  filter(!is.na(age_group)) %>%
  group_by(`_AGEG5YR`, age_group) %>%
  summarise(
    total = n(),
    diabetes_cases = sum(DIABETE4 == 1, na.rm = TRUE),
    diabetes_percentage = round(diabetes_cases / total * 100, 1),
    .groups = "drop"
  ) %>%
  arrange(`_AGEG5YR`)

age_diabetes
# Create broader age groups for more stable comparison
age_group_summary <- clean_diabetes_data %>%
  mutate(
    age_group_broad = case_when(
      `_AGEG5YR` %in% c(1, 2, 3, 4, 5) ~ "18-44",
      `_AGEG5YR` %in% c(6, 7, 8, 9) ~ "45-64",
      `_AGEG5YR` %in% c(10, 11) ~ "65-74",
      `_AGEG5YR` %in% c(12, 13) ~ "75+",
      TRUE ~ NA_character_
    )
  ) %>%
  filter(!is.na(age_group_broad)) %>%
  group_by(age_group_broad) %>%
  summarise(
    total = n(),
    diabetes_cases = sum(DIABETE4 == 1, na.rm = TRUE),
    diabetes_percentage = round(diabetes_cases / total * 100, 1),
    .groups = "drop"
  )

age_group_summary
# 6. BMI Analysis
# Inspect BMI variables

summary(clean_diabetes_data$`_BMI5`)

table(clean_diabetes_data$`_BMI5CAT`, useNA = "ifany")
# Diabetes prevalence by BMI category

bmi_diabetes <- clean_diabetes_data %>%
  mutate(
    bmi_category = case_when(
      `_BMI5CAT` == 1 ~ "Underweight",
      `_BMI5CAT` == 2 ~ "Normal weight",
      `_BMI5CAT` == 3 ~ "Overweight",
      `_BMI5CAT` == 4 ~ "Obese",
      TRUE ~ NA_character_
    )
  ) %>%
  filter(!is.na(bmi_category)) %>%
  group_by(`_BMI5CAT`, bmi_category) %>%
  summarise(
    total = n(),
    diabetes_cases = sum(DIABETE4 == 1, na.rm = TRUE),
    diabetes_percentage = round(diabetes_cases / total * 100, 1),
    .groups = "drop"
  ) %>%
  arrange(`_BMI5CAT`)

bmi_diabetes
# 7. Physical Activity Analysis
# Inspect physical activity variable

table(clean_diabetes_data$EXERANY2, useNA = "ifany")
# Diabetes prevalence by physical activity

activity_diabetes <- clean_diabetes_data %>%
  mutate(
    physical_activity = case_when(
      EXERANY2 == 1 ~ "Physically active",
      EXERANY2 == 2 ~ "No physical activity",
      TRUE ~ NA_character_
    )
  ) %>%
  filter(!is.na(physical_activity)) %>%
  group_by(physical_activity) %>%
  summarise(
    total = n(),
    diabetes_cases = sum(DIABETE4 == 1, na.rm = TRUE),
    diabetes_percentage = round(diabetes_cases / total * 100, 1),
    .groups = "drop"
  )

activity_diabetes
# 8. Socioeconomic Analysis
# Inspect education variable

table(clean_diabetes_data$EDUCA, useNA = "ifany")
# Diabetes prevalence by education level

education_diabetes <- clean_diabetes_data %>%
  mutate(
    education_level = case_when(
      EDUCA %in% c(1, 2, 3) ~ "Less than high school",
      EDUCA == 4 ~ "High school graduate",
      EDUCA == 5 ~ "Some college / technical school",
      EDUCA == 6 ~ "College graduate",
      TRUE ~ NA_character_
    )
  ) %>%
  filter(!is.na(education_level)) %>%
  group_by(education_level) %>%
  summarise(
    total = n(),
    diabetes_cases = sum(DIABETE4 == 1, na.rm = TRUE),
    diabetes_percentage = round(diabetes_cases / total * 100, 1),
    .groups = "drop"
  )

education_diabetes
# Inspect income variable

table(clean_diabetes_data$INCOME3, useNA = "ifany")
# Diabetes prevalence by income level

income_diabetes <- clean_diabetes_data %>%
  mutate(
    income_group = case_when(
      INCOME3 %in% c(1, 2) ~ "Less than $15,000",
      INCOME3 %in% c(3, 4) ~ "$15,000-$24,999",
      INCOME3 == 5 ~ "$25,000-$34,999",
      INCOME3 == 6 ~ "$35,000-$49,999",
      INCOME3 %in% c(7, 8) ~ "$50,000-$99,999",
      INCOME3 %in% c(9, 10) ~ "$100,000-$199,999",
      INCOME3 == 11 ~ "$200,000 or more",
      TRUE ~ NA_character_
    )
  ) %>%
  filter(!is.na(income_group)) %>%
  group_by(income_group) %>%
  summarise(
    total = n(),
    diabetes_cases = sum(DIABETE4 == 1, na.rm = TRUE),
    diabetes_percentage = round(diabetes_cases / total * 100, 1),
    .groups = "drop"
  )

income_diabetes
# Create broader income groups for more stable comparison

income_group_summary <- clean_diabetes_data %>%
  mutate(
    income_group_broad = case_when(
      INCOME3 %in% c(1, 2, 3, 4) ~ "Less than $25,000",
      INCOME3 %in% c(5, 6) ~ "$25,000-$49,999",
      INCOME3 %in% c(7, 8) ~ "$50,000-$99,999",
      INCOME3 %in% c(9, 10, 11) ~ "$100,000 or more",
      TRUE ~ NA_character_
    )
  ) %>%
  filter(!is.na(income_group_broad)) %>%
  group_by(income_group_broad) %>%
  summarise(
    total = n(),
    diabetes_cases = sum(DIABETE4 == 1, na.rm = TRUE),
    diabetes_percentage = round(diabetes_cases / total * 100, 1),
    .groups = "drop"
  )

income_group_summary
# 9. Create EDA Visualizations
# Diabetes by Sex

sex_diabetes_plot <- ggplot(
  sex_diabetes,
  aes(x = sex, y = diabetes_percentage)
) +
  geom_col() +
  geom_text(
    aes(label = paste0(diabetes_percentage, "%")),
    vjust = -0.4
  ) +
  scale_y_continuous(
    expand = expansion(mult = c(0, 0.12))
  ) +
  labs(
    title = "Diabetes Percentage by Sex",
    subtitle = "BRFSS 2024 Development Sample (n = 1,000)",
    x = NULL,
    y = "Percentage with Diabetes"
  ) +
  theme_minimal()

sex_diabetes_plot
# Diabetes Status Distribution

diabetes_plot <- ggplot(
  diabetes_prevalence,
  aes(x = reorder(diabetes_status, percentage),
      y = percentage)
) +
  geom_col() +
  geom_text(
    aes(label = paste0(percentage, "%")),
    hjust = -0.1
  ) +
  coord_flip() +
  scale_y_continuous(
    expand = expansion(mult = c(0, 0.12))
  ) +
  labs(
    title = "Diabetes Status Distribution",
    subtitle = "BRFSS 2024 Development Sample (n = 1,000)",
    x = NULL,
    y = "Percentage of Sample"
  ) +
  theme_minimal()

diabetes_plot
# Diabetes by Sex

sex_diabetes_plot <- ggplot(
  sex_diabetes,
  aes(x = sex, y = diabetes_percentage)
) +
  geom_col() +
  geom_text(
    aes(label = paste0(diabetes_percentage, "%")),
    vjust = -0.4
  ) +
  scale_y_continuous(
    expand = expansion(mult = c(0, 0.12))
  ) +
  labs(
    title = "Diabetes Percentage by Sex",
    subtitle = "BRFSS 2024 Development Sample (n = 1,000)",
    x = NULL,
    y = "Percentage with Diabetes"
  ) +
  theme_minimal()

sex_diabetes_plot
# Diabetes by Age Group

age_diabetes_plot <- ggplot(
  age_diabetes,
  aes(
    x = factor(
      age_group,
      levels = c(
        "18-24", "25-29", "30-34", "35-39",
        "40-44", "45-49", "50-54", "55-59",
        "60-64", "65-69", "70-74", "75-79", "80+"
      )
    ),
    y = diabetes_percentage
  )
) +
  geom_col() +
  geom_text(
    aes(label = paste0(diabetes_percentage, "%")),
    vjust = -0.4,
    size = 3
  ) +
  scale_y_continuous(
    expand = expansion(mult = c(0, 0.12))
  ) +
  labs(
    title = "Diabetes Percentage by Age Group",
    subtitle = "BRFSS 2024 Development Sample (valid age n = 988)",
    x = "Age Group",
    y = "Percentage with Diabetes"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

age_diabetes_plot
# Diabetes by Broad Age Group

age_group_plot <- ggplot(
  age_group_summary,
  aes(
    x = factor(
      age_group_broad,
      levels = c("18-44", "45-64", "65-74", "75+")
    ),
    y = diabetes_percentage
  )
) +
  geom_col() +
  geom_text(
    aes(label = paste0(diabetes_percentage, "%")),
    vjust = -0.4
  ) +
  scale_y_continuous(
    expand = expansion(mult = c(0, 0.12))
  ) +
  labs(
    title = "Diabetes Percentage by Age Group",
    subtitle = "BRFSS 2024 Development Sample (valid age n = 988)",
    x = "Age Group",
    y = "Percentage with Diabetes"
  ) +
  theme_minimal()

age_group_plot

# Diabetes by BMI Category

bmi_diabetes_plot <- ggplot(
  bmi_diabetes,
  aes(
    x = factor(
      bmi_category,
      levels = c(
        "Underweight",
        "Normal weight",
        "Overweight",
        "Obese"
      )
    ),
    y = diabetes_percentage
  )
) +
  geom_col() +
  geom_text(
    aes(label = paste0(diabetes_percentage, "%")),
    vjust = -0.4
  ) +
  scale_y_continuous(
    expand = expansion(mult = c(0, 0.12))
  ) +
  labs(
    title = "Diabetes Percentage by BMI Category",
    subtitle = "BRFSS 2024 Development Sample (valid BMI n = 935)",
    x = "BMI Category",
    y = "Percentage with Diabetes"
  ) +
  theme_minimal()

bmi_diabetes_plot

# Diabetes by Physical Activity

activity_diabetes_plot <- ggplot(
  activity_diabetes,
  aes(
    x = factor(
      physical_activity,
      levels = c("Physically active", "No physical activity")
    ),
    y = diabetes_percentage
  )
) +
  geom_col() +
  geom_text(
    aes(label = paste0(diabetes_percentage, "%")),
    vjust = -0.4
  ) +
  scale_y_continuous(
    expand = expansion(mult = c(0, 0.12))
  ) +
  labs(
    title = "Diabetes Percentage by Physical Activity",
    subtitle = "BRFSS 2024 Development Sample (valid activity n = 997)",
    x = NULL,
    y = "Percentage with Diabetes"
  ) +
  theme_minimal()

activity_diabetes_plot
# Diabetes by Education Level

education_diabetes_plot <- ggplot(
  education_diabetes,
  aes(
    x = factor(
      education_level,
      levels = c(
        "Less than high school",
        "High school graduate",
        "Some college / technical school",
        "College graduate"
      )
    ),
    y = diabetes_percentage
  )
) +
  geom_col() +
  geom_text(
    aes(label = paste0(diabetes_percentage, "%")),
    vjust = -0.4
  ) +
  scale_y_continuous(
    expand = expansion(mult = c(0, 0.12))
  ) +
  labs(
    title = "Diabetes Percentage by Education Level",
    subtitle = "BRFSS 2024 Development Sample (valid education n = 994)",
    x = "Education Level",
    y = "Percentage with Diabetes"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 25, hjust = 1)
  )

education_diabetes_plot
# Diabetes by Income Level

income_group_plot <- ggplot(
  income_group_summary,
  aes(
    x = factor(
      income_group_broad,
      levels = c(
        "Less than $25,000",
        "$25,000-$49,999",
        "$50,000-$99,999",
        "$100,000 or more"
      )
    ),
    y = diabetes_percentage
  )
) +
  geom_col() +
  geom_text(
    aes(label = paste0(diabetes_percentage, "%")),
    vjust = -0.4
  ) +
  scale_y_continuous(
    expand = expansion(mult = c(0, 0.12))
  ) +
  labs(
    title = "Diabetes Percentage by Income Level",
    subtitle = "BRFSS 2024 Development Sample (valid income n = 646)",
    x = "Annual Household Income",
    y = "Percentage with Diabetes"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 25, hjust = 1)
  )

income_group_plot
# 10. Export EDA Results
ggsave(
  filename = "Images/01_diabetes_status_distribution.png",
  plot = diabetes_plot,
  width = 8,
  height = 5.5,
  dpi = 300
)
ggsave(
  filename = "Images/02_diabetes_by_sex.png",
  plot = sex_diabetes_plot,
  width = 8,
  height = 5.5,
  dpi = 300
)
ggsave(
  filename = "Images/03_diabetes_by_age_group.png",
  plot = age_group_plot,
  width = 8,
  height = 5.5,
  dpi = 300
)
ggsave(
  filename = "Images/04_diabetes_by_bmi_category.png",
  plot = bmi_diabetes_plot,
  width = 8,
  height = 5.5,
  dpi = 300
)
ggsave(
  filename = "Images/05_diabetes_by_physical_activity.png",
  plot = activity_diabetes_plot,
  width = 8,
  height = 5.5,
  dpi = 300
)
ggsave(
  filename = "Images/06_diabetes_by_education_level.png",
  plot = education_diabetes_plot,
  width = 8,
  height = 5.5,
  dpi = 300
)
ggsave(
  filename = "Images/07_diabetes_by_income_level.png",
  plot = income_group_plot,
  width = 8,
  height = 5.5,
  dpi = 300
)