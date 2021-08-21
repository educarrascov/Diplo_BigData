# Carga los datos en la sesión de trabajo
  library(rpart)

  datos <- kyphosis

# 1) Define el conjunto de datos de prueba y el de validación

  set.seed(1)
  ind <- sample(2, length(datos$Kyphosis), replace=TRUE, prob=c(2/3, 1/3))
  table(ind)
  datos.trabajo <- datos[ind==1,]
  datos.validacion <- datos[ind==2,]
  dim(datos.trabajo)
  dim(datos.validacion)

# 2) Construye el clasificador de Bayes ingenuo
  
  library(e1071)
  fit.NB <- naiveBayes(Kyphosis ~ .,data=datos.trabajo)
  pred.NB <- predict(fit.NB,datos.validacion[,-1],type="raw")


# 3) Construye el clasificador de KN
  
  library(kknn)
  fit.kknn <- kknn(Kyphosis ~ ., datos.trabajo, datos.validacion, distance = 1, kernel = "triangular")
  summary(fit.kknn)


# 4) Compara clasificadores

  fit <- fitted(fit.kknn)
  table(datos.validacion$Kyphosis, fit)

  library(rminer)
  mmetric(datos.validacion[,1],pred.NB,"ACC") # Precision
  mmetric(datos.validacion[,1],pred.NB,"TPR") # Sensibilidad
  mmetric(datos.validacion[,1],pred.NB,"TNR") # Especificidad

