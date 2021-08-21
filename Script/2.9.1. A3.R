# 1) Carga los datos en la sesión de trabajo

  datos <- read.table(file.choose(),header=TRUE, sep=",")
  datos$left <- factor(datos$left)


# 2) Define el conjunto de datos de prueba y el de validación

  set.seed(1)
  ind <- sample(2, length(datos$left), replace=TRUE, prob=c(2/3, 1/3))
  table(ind)
  datos.trabajo <- datos[ind==1,]
  datos.validacion <- datos[ind==2,]
  dim(datos.trabajo)
  dim(datos.validacion)

# 3) Construye el clasificador basado en bagging

  library(adabag)
  set.seed(1)
  fit.bagging <- bagging(left ~., data=datos.trabajo, mfinal=10)

# 4) Construye el clasificador basado en boosting
  set.seed(1)
  fit.boosting <- boosting(left ~., data=datos.trabajo, boos=TRUE, mfinal=10)

# 5) Construye el clasificador basado en random forest

  library(randomForest)
  set.seed(1)
  fit.randomforest <- randomForest(left ~ ., data=datos.trabajo, ntree=100, proximity=TRUE)
  plot(fit.randomforest)

# 6) Predicciones

  pred.bagging <- predict.bagging(fit.bagging, newdata = datos.validacion)
  pred.boosting <- predict.boosting(fit.boosting, newdata = datos.validacion)
  pred.randomforest <- predict(fit.randomforest, newdata = datos.validacion)

  library(rminer)
# Precision
  mmetric(datos.validacion[,7],pred.bagging$class,"ACC")
  mmetric(datos.validacion[,7],pred.boosting$class,"ACC")
  mmetric(datos.validacion[,7],pred.randomforest,"ACC")

# Sensibilidad
  mmetric(datos.validacion[,7],pred.bagging$class,"TPR")
  mmetric(datos.validacion[,7],pred.boosting$class,"TPR")
  mmetric(datos.validacion[,7],pred.randomforest,"TPR")

# Especificidad
  mmetric(datos.validacion[,7],pred.bagging$class,"TNR")
  mmetric(datos.validacion[,7],pred.boosting$class,"TNR")
  mmetric(datos.validacion[,7],pred.randomforest,"TNR")


