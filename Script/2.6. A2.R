# 1) Carga los datos en la sesión de trabajo

  datos <- read.table(file.choose(),header=TRUE, sep=";")

# 2) Define el conjunto de datos de prueba y el de validación

  set.seed(1)
  ind <- sample(2, length(datos$clase), replace=TRUE, prob=c(2/3, 1/3))
  table(ind)
  datos.trabajo <- datos[ind==1,]
  datos.validacion <- datos[ind==2,]
  length(datos.trabajo)
  length(datos.validacion)

# 3) Construye el arbol de clasificación

  library(rpart)
  library(rpart.plot)
  fit <- rpart(clase ~ .,data=datos.trabajo,parms = list(split = "gini"))
  print(fit)
  rpart.plot(fit,box.palette="-auto",shadow.col="darkgray",nn=TRUE)
  text(fit)

# cp
  pfit <- prune(fit, cp = 0.012)
  print(pfit)
  rpart.plot(pfit,box.palette="RdBu",shadow.col="gray",nn=TRUE)
  text(pfit)

# 4) Construye el clasificador de Bayes ingenuo
  library(e1071)
  fitNB <- naiveBayes(clase ~ .,data=datos.trabajo,laplace = 1)

  library(adabag)
  modelo.bagg.cv <- bagging.cv(clase~.,v=10,data=datos.trabajo,mfinal=10,control=rpart.control(maxdepth=5))

   pred.tree <- predict(pfit,datos.validacion[,-9])
   pred.nb <- predict(fitNB,datos.validacion[,-9],type="raw")

   library(rminer)
   mmetric(datos.validacion[,9],pred.tree,"ACC") # Precision
   mmetric(datos.validacion[,9],pred.nb,"ACC") # Precision
   mmetric(datos.validacion[,9],pred.tree,"TPR") # Sensibilidad
   mmetric(datos.validacion[,9],pred.nb,"TPR") # Sensibilidad
   mmetric(datos.validacion[,9],pred.tree,"TNR") # Especificidad
   mmetric(datos.validacion[,9],pred.nb,"TNR") # Especificidad
   print(mmetric(datos.validacion[,9],pred.tree,"CONF")) #MATRIZ DE confusión
   print(mmetric(datos.validacion[,9],pred.nb,"CONF")) #matriz de confusión
   
   TClass <- factor()
   PClass <- factor(c(0, 1, 0, 1))
   Y      <- c(2816, 248, 34, 235)
   df <- data.frame(TClass, PClass, Y)
   
   ctable <- as.table(matrix(c(2390, 93, 496, 319), nrow = 2, byrow = TRUE))
   fourfoldplot(ctable, color = c("#CC6666", "#99CC99"),
                conf.level = 0, margin = 1, main = "Matriz de Confusión - Arboles de Decisión")
   
   ctable1 <- as.table(matrix(c(2047, 436, 222, 593), nrow = 2, byrow = TRUE))
   fourfoldplot(ctable1, color = c("#CC6666", "#99CC99"),
                conf.level = 0, margin = 1, main = "Matriz de Confusión - Bayes Ingenuo")
