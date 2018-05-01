# Clear workspace variables
rm(list = ls())
cat("\014")

# Set working directory
setwd("~/Dropbox/Documents/Projects/DataScience/CVDModel")

library(haven)
data <- read_dta("data.dta")
View(data)

table(data$diabetes)
prop.table(table(data$diabetes))
mean(data$diabetes)
sd(data$diabetes)
summary(data$diabetes)
prop.table(table(data$diabetes, data$sex),2)

# In case it is too hard to understand this table, you can add a label to the categories of variables diabetes and sex by typing:

data$diabetes <- factor(data$diabetes, levels = c(0,1), labels = c("No", "Yes"))
data$sex <- factor(data$sex, levels = c(0,1), labels = c("Men", "Women"))
prop.table(table(data$diabetes, data$ag16g10),2)
