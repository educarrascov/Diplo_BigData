##################################
######### Script Boosting ########
##################################

# Cargamos la librería a usar y los datos
library(rpart)
data(iris)

# Seleccion de datos de trabajo o entrenamiento,
# se seleccionan 25 de cada especie
train = c(sample(1:50, 25),
          sample(51:100, 25),
          sample(101:150, 25))

# Modelamos la especie a partir de todas las variables en los datos de entrenamiento
# mfinal -> N de iteraciones
# boos -> Permite submuestrear para generar los pesos
iris.adaboost <- boosting(Species~., data=iris[train,], boos=TRUE, mfinal=10)
iris.adaboost

# Graficamos las variables según su porcentaje de relevancia  
# El largo de pétalo es la más relevante.
barplot(iris.adaboost$imp[order(iris.adaboost$imp, decreasing = TRUE)],
        ylim = c(0, 100), main = "Variables Relative Importance",
        col = "lightblue")

# Ajustamos a los nuevos datos, y vemos el ajuste
iris.predboosting <- predict.boosting(iris.adaboost,
                                      newdata = iris[-train, ])
iris.predboosting
