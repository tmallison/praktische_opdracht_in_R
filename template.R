#--------Template - Onderdeel 2 - Machine Learning - ikml (40 punten) -------------
# Naam student: Thomas Allison
# studienummer: s1095073

# Gekozen dataset https://archive.ics.uci.edu/ml/datasets/Student+Performance. Beschrijving dataset:
# This data approach student achievement in secondary education of two Portuguese schools. 
# The data attributes include student grades, demographic, social and school related features) and 
# it was collected by using school reports and questionnaires. Two datasets are provided regarding 
# the performance in two distinct subjects: Mathematics (mat) and Portuguese language (por). 
# In [Cortez and Silva, 2008], the two datasets were modeled under binary/five-level classification 
# and regression tasks. Important note: the target attribute G3 has a strong correlation with 
# attributes G2 and G1. This occurs because G3 is the final year grade (issued at the 3rd period), 
# while G1 and G2 correspond to the 1st and 2nd period grades. It is more difficult to predict G3 
# without G2 and G1, but such prediction is much more useful (see paper source for more details).

# Inlezen dataset en nul-meeting (10 punten)
# met nul meeting bedoelen we 
# - scatterplots maken. histrogram plots
# - dimensies van je data (aantal rijen, aantal kolommen) => 1.000.000 rijen en 11 kolommen
# - numerieke of categorische data => categorische data omdat het geen wiskundige waarde heeft
# - missing values? => die bestaan niet in deze dataset
# - Bereik van de datapunten? => Alle (S)uits hebben de opties [1|2|3|4] en de (C)ards [1|2|...|12|13]

library(ggplot2) 
library(boot)
require(gridExtra)

d1=read.table("./data/student-mat.csv", sep=";", header=TRUE)
print(nrow(d1)) # 395 studenten

# gekozen classifier of regressie model trainen (10 punten)
lm.fit=lm(G1~absences,data=d1) # eenvoudig lineaire regressie model, G3 = eindcijfer, absences = afwezigheid
lm.fit # basisinformatie van model
summary(lm.fit) # meer informatie
confint(lm.fit) # Betrouwbaarheidsinterval voor de schattingen van de coëfficienten verkrijgen
attach(d1)

predict(lm.fit, data.frame(absences=c(40,60,80)), interval="confidence") # voorspel waardes
predict(lm.fit, data.frame(absences=c(40,60,80)), interval="prediction") # voorspel waardes

plot(predict(lm.fit), residuals(lm.fit))
plot(predict(lm.fit), rstudent(lm.fit))
plot(hatvalues(lm.fit))
which.max(hatvalues(lm.fit))

# cross validatie of R squared (voor regressie) (10 punten)
# Leave-One-Out Cross Validatie
lm.fit=lm(G1~absences,data=d1)
coef(lm.fit)

glm.fit=glm(G1~absences,data=d1)
coef(glm.fit)


glm.fit=glm(G1~absences,data=d1)
cv.err=cv.glm(d1,glm.fit)
cv.err$delta # 11.07009 11.06998

# Nu gaan we deze procedure herhalen voor steeds complexere polynomische fits
cv.error=rep(0,5)
for (i in 1:5) {
  glm.fit=glm(G1~poly(absences,i),data=d1)
  cv.error[i]=cv.glm(d1,glm.fit)$delta[1]
}
cv.error # 11.07009 11.10098 11.19502 12.79235 17.24899, een stijging tussen de lineaire en kwadratische fits

# K-Fold Cross Validatie
set.seed(17)
cv.error.10=rep(0,10)
for(i in 1:10) {
  glm.fit=glm(G1~poly(absences, i))
  cv.error.10[i]=cv.glm(d1,glm.fit,K=10)$delta[i]
}
cv.error.10

# visualisatie en conclusies (10 punten)

plot1 <- qplot(d1$freetime, d1$G1, xlab="Absence", ylab="Final grade")
plot2 <- qplot(d1$absences, xlab = "Absence",  geom = "histogram")
plot3 <- qplot(d1$age, d1$G1, xlab="Age", ylab="Final grade")
plot4 <- qplot(d1$age, xlab = "Age",  geom = "histogram")

grid.arrange(plot1, plot2, plot3, plot4, ncol=2)

par(mfrow=c(2,2)) # maak twee rijen + twee kolommen
plot(lm.fit) # plot model

par(mfrow=c(1,1))
plot(absences, G1) # plot de chart
abline(lm.fit) # teken de lijn van ons model

# We hebben gekeken naar deze dataset waarin studenten het vak wiskunde hebben gevolgd.
# Vervolgens hebben we de aanwezigheid en het cijfer dat ze behaald hebben vergeleken, 
# en in een lineaire regressie model gestopt.
#
# We zien een afname naar mate de absentie-graad hoger is. De daling is wel lager dan verwacht.
# Het is een lage afname, er zijn studenten die altijd aanwezig waren 
# en lager hebben gescoord dan iemand met 60+ absentie.

# Betrouwbaarheidsgetallen:
# 2.5 %      97.5 %
# (Intercept) 10.57846018 11.38607163
# absences    -0.05396903  0.02825282

# Residuals:
# Min      1Q  Median      3Q     Max 
# -7.8794 -2.9115  0.0177  2.2363  8.0692 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept) 10.98227    0.20539  53.470   <2e-16 ***
#   absences    -0.01286    0.02091  -0.615    0.539    
# ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 3.322 on 393 degrees of freedom
# Multiple R-squared:  0.0009612,	Adjusted R-squared:  -0.001581 
# F-statistic: 0.3781 on 1 and 393 DF,  p-value: 0.539
