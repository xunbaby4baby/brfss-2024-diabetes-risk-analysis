# ============================================================
# Diabetes Risk Factors and Population Health Analysis
# Phase 3: Data Processing
# File: 02_data_cleaning.R
# ============================================================

# 1. Load Required Package
library(haven)

# 2. Import BRFSS 2024 Data
brfss <- haven::read_xpt(
  "LLCP2024.XPT",
  n_max = 1000
)
# 3. Select Variables for Analysis
diabetes_data <- brfss[, c(
  "DIABETE4",
  "DIABAGE4",
  "EDUCA",
  "INCOME3",
  "_AGEG5YR",
  "_AGE80",
  "_BMI5",
  "_BMI5CAT",
  "EXERANY2",
  "SEXVAR"
)]
# 4. Inspect Data Structure
str(diabetes_data)
# 5. Check Missing Values
colSums(is.na(diabetes_data))
# 6. Inspect Response Codes
table(diabetes_data$DIABETE4, useNA = "ifany")

table(diabetes_data$SEXVAR, useNA = "ifany")

table(diabetes_data$EXERANY2, useNA = "ifany")

table(diabetes_data$EDUCA, useNA = "ifany")

table(diabetes_data$INCOME3, useNA = "ifany")
# 7. Create Clean Dataset
clean_diabetes_data <- diabetes_data
# 8. Recode Invalid Responses
# 8. Recode Invalid Responses

clean_diabetes_data$EXERANY2[
  clean_diabetes_data$EXERANY2 %in% c(7, 9)
] <- NA

clean_diabetes_data$EDUCA[
  clean_diabetes_data$EDUCA == 9
] <- NA

clean_diabetes_data$INCOME3[
  clean_diabetes_data$INCOME3 %in% c(77, 99)
] <- NA

clean_diabetes_data$`_AGEG5YR`[
  clean_diabetes_data$`_AGEG5YR` == 14
] <- NA

# 9. Validate Cleaning Results
table(clean_diabetes_data$EXERANY2, useNA = "ifany")

table(clean_diabetes_data$EDUCA, useNA = "ifany")

table(clean_diabetes_data$INCOME3, useNA = "ifany")
table(clean_diabetes_data$`_AGEG5YR`, useNA = "ifany")
# 10. Review Variable Labels
sapply(clean_diabetes_data, attr, "label")
# 11. Export Clean Dataset
write.csv(
  clean_diabetes_data,
  "clean_diabetes_data.csv",
  row.names = FALSE
)