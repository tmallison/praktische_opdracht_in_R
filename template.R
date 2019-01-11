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


# x = math, y = portugese
library(ggplot2) 

d1=read.table("./data/student-mat.csv",sep=";",header=TRUE)
d2=read.table("./data/student-por.csv",sep=";",header=TRUE)

d3=merge(d1,d2,by=c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet"))
print(nrow(d3)) # 382 students

# library(ggplot2)
# ggplot(d, aes(x=CLASS)) + geom_histogram(binwidth=.1)
help(plot)

require(gridExtra)

plot1 <- qplot(d1$freetime, d1$G1, xlab="Absence", ylab="Final grade")
plot2 <- qplot(d1$absences, xlab = "Absence",  geom = "histogram")
plot3 <- qplot(d1$age, d1$G3, xlab="Age", ylab="Final grade")
plot4 <- qplot(d1$age, xlab = "Age",  geom = "histogram")

grid.arrange(plot1, plot2, plot3, plot4, ncol=2)

# gekozen classifier of regressie model trainen (10 punten)
lm.fit=lm(G1~absences,data=d1) # eenvoudig lineaire regressie model, G3 = eindcijfer, absences = afwezigheid
lm.fit # basisinformatie van model
summary(lm.fit) # meer informatie
confint(lm.fit) # Betrouwbaarheidsinterval voor de schattingen van de coëfficienten verkrijgen
attach(d1)
plot(absences, G1) # plot de chart
abline(lm.fit) # teken de lijn van ons model
predict(lm.fit, data.frame(absences=c(40,60,80)), interval="confidence") # voorspel waardes
predict(lm.fit, data.frame(absences=c(40,60,80)), interval="prediction") #voorspel waardes

par(mfrow=c(2,2)) # maak twee rijen + twee kolommen
plot(lm.fit) # plot model

plot(predict(lm.fit), residuals(lm.fit))
plot(predict(lm.fit), rstudent(lm.fit))
plot(hatvalues(lm.fit))
which.max(hatvalues(lm.fit))

# cross validatie of R squared (voor regressie) (10 punten)




# visualisatie en conclusies (10 punten)





