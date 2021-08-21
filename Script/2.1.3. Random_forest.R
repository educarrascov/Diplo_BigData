####### RANDOM FOREST #######

library(randomForest)			#Instalar paquete randomForest
data("iris")				#Carga los datos

ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.7, 0.3))	#genera 1's o 2's con probabilidad 0,7 y 0,3 respectivamente.
trainData <- iris[ind==1,]			#genera la data de entrenamiento segun los que hayan sido 1 en ind
testData <- iris[ind==2,]			#genera la data de testeo como el resto del anterior

#Generamos el modelo con todas las variables (menos Specie) sobre los datos de entrenamiento.
rf <- randomForest(Species~., data=trainData, ntree=100, proximity=TRUE) 
print(rf) #muestra el detalle del modelo


summary(rf) $muestra un resumen de las variables del objeto rf que contiene las variables que genera el metodo RandomForest
rf$votes # muestra las votaciones (en porcentaje)
rf$oob.times 
rf$predicted #muestra la prediccion en los datos de testeo

# Comparar la prediccion con los datos originales de testeo
table(predict(rf), trainData$Species)
