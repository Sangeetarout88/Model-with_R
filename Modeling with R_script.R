#1)Familiarize yourself with the heights 
#data set provided with the modelr package.
library(tidyverse)
library(modelr)

#2)
summary(heights)
frmls <- formulas(~income,
                  h = ~height,
                  h_w = ~height*weight,
                  all = ~.)
frmls
# $h
# income ~ height
# 
# $h_w
# income ~ height * weight
# $all
# income ~ .

#3)
models <- heights %>%
  na.omit() %>%
  fit_with(lm, frmls)
models
#remove rows containing NA’s
#Fit the linear model with the formulas from exercise 2

#4)
heights_no_na <- na.omit(heights)
models %>%
  map(rmse, data = heights)

#5
heights %>%
  lift_dl(gather_residuals)(data = ., models) %>%
  ggplot(aes(resid, color = model)) +
  geom_density(size = 1) +
  theme_bw()
#save our workspace
save.image("Rmodel.RData")
#save history
savehistory("Rmodel.RData")
