##################################
######### Script Bagging #########
##################################

# Cargamos la libería adabag
library(adabag)

# Cargamos los datos
data("iris")

# Seleccion de datos de trabajo o entrenamiento
# se seleccionan 25 de cada especie
train = c(sample(1:50, 25),
           sample(51:100, 25),
           sample(101:150, 25))

# Bagging, se modela la especie a partir de todas las variables en los datos de entrenamiento
# mfinal -> N de iteraciones, es 100 por defecto, se bajó para que demore menos
iris.bagging = bagging(Species~., data = iris[train, ], mfinal = 10)

# Vemos la muestra usada en la primera iteración
iris.bagging$samples[,1]

# Hacemos la predicción y vemos el resultado
iris.predbagging = predict.bagging(iris.bagging, newdata=iris[-train,])
iris.predbagging

