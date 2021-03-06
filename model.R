# Clear workspace variables
rm(list = ls())
cat("\014")

# Set working directory
setwd("~/Dropbox/Documents/Projects/DataScience/CVDModel")

# Load libraries
library(haven, lmtest)

data <- read_dta("data.dta")

table(data$diabetes)
prop.table(table(data$diabetes))
mean(data$diabetes)
sd(data$diabetes)
summary(data$diabetes)
prop.table(table(data$diabetes, data$sex),2)

# Add a labels tthe categories of variables
data$diabetes <- factor(data$diabetes, levels = c(0,1), labels = c("No", "Yes"))
data$sex <- factor(data$sex, levels = c(0,1), labels = c("Men", "Women"))
prop.table(table(data$diabetes, data$ag16g10),2)

model1 <- glm(diabetes ~ factor(ag16g10), data = data,
              family = binomial(link = "logit"))
summary(model1)
exp(cbind(odds=coef(model1), confint(model1)))

# OR for 45-54 = 4.92
# OR for 75+ = 16.57

data$sex <- factor(data$sex)
data$sex <- relevel(data$sex, ref="Women") # ref here is the reference category
model2 <- glm(diabetes ~ sex,
                data = data,
                family = binomial(link = "logit"))
summary(model2)
exp(cbind(odds=coef(model2), confint(model2)))

model3 <- glm(diabetes ~ sex + factor(ag16g10),
              data = subset(data, ethnici>0),
              family = binomial(link = "logit"))
summary(model3)
exp(cbind(odds=coef(model3), confint(model3)))
model4<- glm(diabetes ~ sex + factor(ag16g10) + factor(ethnici), data = data,
               family = binomial(link = "logit"))
summary(model4)
exp(cbind(odds=coef(model4), confint(model4)))
lrtest(model3, model4)

model5<- glm(bmi30 ~ sclass2 + factor(smoker) + overlim + age,
             data = subset(data, sex=="Men"),
             family = binomial(link = "logit"))
summary(model5)
exp(cbind(odds=coef(model5), confint(model5)))

model6<- glm(bmi30 ~ sclass2 + factor(smoker) + overlim + age,
             data = subset(data, sex==1),
             family = binomial(link = "logit"))
summary(model6)
exp(cbind(odds=coef(model6), confint(model6)))

model7 <- glm(cvddef1 ~ sex + agegr + sex:agegr,
              data = data, family = binomial(link = "logit"))
summary(model7)
exp(cbind(odds=coef(model7), confint(model7)))

model8 <- glm(cvddef1 ~ factor(sex) + factor(adt30gp) + factor(sex):factor(adt30gp),
              data = data, family = binomial(link = "logit"))
summary(model8)
exp(cbind(odds=coef(model8), confint(model8)))

model9 <- glm(cvddef1 ~ factor(sex) + factor(adt30gp), data = data,
              family = binomial(link = "logit"))
summary(model9)
exp(cbind(odds=coef(model9), confint(model9)))
lrtest(model8, model9)

model10 <- glm(cvddef1 ~ factor(sex), data = subset(data, adt30gp==1),
               family = binomial(link = "logit"))
summary(model10)
exp(cbind(odds=coef(model10), confint(model10)))

model11 <- glm(cvddef1 ~ factor(sex), data = subset(data, adt30gp==2),
               family = binomial(link = "logit"))
summary(model11)
exp(cbind(odds=coef(model11), confint(model11)))

model12 <- glm(cvddef1 ~ factor(sex), data = subset(data, adt30gp==3),
               family = binomial(link = "logit"))
summary(model12)
exp(cbind(odds=coef(model12), confint(model12)))

model13 <- glm(bmi30 ~ age + sclass2 + factor(sex) +
               overlim + factor(smoker) + factor(sex):overlim +
               factor(sex):factor(smoker), data = data,
               family = binomial(link = "logit"))
summary(model13)
exp(cbind(odds=coef(model13), confint(model13)))
