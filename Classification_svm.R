#Data
data(iris)
str(iris)
#using the 4 numrical variable we'll built a classification model to predict the species
library(ggplot2)
library(gplots)
qplot(Petal.Length, Petal.Width, data=iris,
      color = Species)
#Support Vector Machine
library(e1071)
Model <- svm(Species~., data = iris, kernel="radial" #can use linear, polynomial and sigmoid
summary(Model)
plot(Model,data=iris,Petal.Width~Petal.Length, slice = list(Sepal.Width = 3, Sepal.Length = 4))

#Tuning ( also called as hyper parameter optimisation)
set.seed(123)
tmodel <- tune(svm,Species~., data = iris,
     ranges = list(epsilon = seq(0,0.1,1),cost = 2^(2:7)))
plot(tmodel)
summary(tmodel)

#Best Model

Model <- tmodel$best.model
summary(Model)
plot(Model,data=iris,Petal.Width~Petal.Length, slice = list(Sepal.Width = 3, Sepal.Length = 4))
#Dark region- ower misclassification error

#Confusion Matrix and Misclassificaion Error
Pred <- predict(Model, iris)
tab <- table(Predicted = Pred, Actual = iris$Species)
tab
1-sum(diag(tab))/sum(tab)

