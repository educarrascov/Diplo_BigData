library(rpart) #Cargamos la librerìa rpart
KyphosisDatos  <-  
  kyphosis #cargamos los datos necesarios para la simulación
summary(KyphosisDatos) #resumen de la simulación.
table(KyphosisDatos$Age) #se genera una tabla para observar los datos de la variable age
head(KyphosisDatos) #Con esta función además podemos ver los 6 primero datos de todas las variables (4)
names(KyphosisDatos) #con esta también podemos ver, pero sólo las variables.
table(KyphosisDatos$Kyphosis)#se genera una tabla para observar los datos de la variable khyposis
table(KyphosisDatos$Number)#se genera una tabla para observar los datos de la variable number
table(KyphosisDatos$Start)#se genera una tabla para observar los datos de la variable start
par(mfrow=c(1,3)) #permite generar gráficos en paralelo
hist(KyphosisDatos$Age,  main  =  "Histograma  para  Age",  xlab  =  "Age") #hist de la variable age
hist(KyphosisDatos$Number,  main  =  "Histograma  para  Number",  xlab  =  "Number") #hist de la var. number
hist(KyphosisDatos$Start,  main  =  "Histograma  para  Start",  xlab  =  "Start") #hist de la var. start
library(Hmisc) #cargamos la librería Hmisc para permitir ejecutar la función describe y verificar valores faltantes
describe(KyphosisDatos) #ejecutamos la función y observamos que no existen datos faltantes
set.seed(1) #por defecto para generar las distintas bases de datos
ind  <-  sample(2,  length(KyphosisDatos$Kyphosis),  replace=TRUE,  prob=c(2/3, 1/3)) #con esto podemos observar
# que dividimos los datos en dos grupos, el primero corresponde al 2 tercio y el segundo al tercio restante
table(ind)#esto nos permite idetificar la cantidad de valores que se fueron a un grupo u otro
datos.trabajo  <-  KyphosisDatos[ind==1,] #con esto conformamos el grupo nª 1 como datos trabajo
datos.validacion  <-  KyphosisDatos[ind==2,] #con esto conformamos el grupo nª 2 como datos validación
dim(datos.trabajo) #con esto podemos conocer la dimensión de una variable.
dim(datos.validacion) #con esto podemos conocer la dimensión de la variable validación
library(e1071) #ahora cargamos la librería sammut and web 2017 que permite efectuar la función clasificadora
#de naive bayes
fit.NB  <-  naiveBayes(Kyphosis  ~  .,  data=datos.trabajo, laplace = 1) #se asigna el clasificador a la var. fit.NB
pred.NB  <-  predict(fit.NB,  datos.validacion[,-1],  type="raw") #se realiza una predicción preliminar
head(pred.NB) #con esto observamos la probabilidad de obtener un absent o present, en base a las otras var.
#la ventaja que nos da por sobre la función pred.NB es que esta muestra sólo los 6 primeros en la lista
library(rminer) #esta función permite abrir la libreria rminer y poder medir las métricas
mmetric(datos.validacion[,1],  pred.NB,  "ACC") #precisiòn, ref. a Accuracy.
mmetric(datos.validacion[,1],  pred.NB,  "TPR") #sensibilidad, ref. a True Possitive Rate.
mmetric(datos.validacion[,1],  pred.NB,  "TNR") #Especificidad, ref. a True Negative Rate.
print(pred.NB.Conf  <-  mmetric(datos.validacion[,1],  pred.NB,  "CONF")) #permite hacer la matríz de confusión
print(pred.NB.Conf  <-  mmetric(datos.validacion[,1],  pred.NB,  "AUC"))#Permite obtener el área bajo la curva ROC
ctable <- as.table(matrix(c(21,1,3,3), nrow = 2, byrow = TRUE)) #se deben colocar los valores obtenidos en la matriz
fourfoldplot(ctable, color = c("#CC6666", "#99CC99"),conf.level = 0, margin = 1, main = "Matriz Confusión - Naive Bayes")
library(kknn) #cargamos la librería del KNN 
fit.kknn<-kknn(Kyphosis~.,datos.trabajo,datos.validacion,distance= 1,kernel="triangular") #efectuamos una
#predicción utilizando el algoritmo KNN 
summary(fit.kknn)
head(fit.kknn)
fit  <-  fitted(fit.kknn) #esto lo utilizamos para verificar el desempeño del ajuste del algoritmo
table(datos.validacion$Kyphosis,fit) #y con esto verificamos lo ajustado graficamente con una matriz de confusión
ctable1 <- as.table(matrix(c(20,2,5,1), nrow = 2, byrow = TRUE)) #se deben colocar los valores obtenidos en la matriz
fourfoldplot(ctable1, color = c("#CC6666", "#99CC99"),conf.level = 0, margin = 1, main = "Matriz Confusión - KNN")
mmetric(datos.validacion$Kyphosis,fit,"ACC")#Obtenemos las métricas, Accuracy, precisión.
mmetric(datos.validacion$Kyphosis,fit,"TPR")
mmetric(datos.validacion$Kyphosis,fit,"TNR")

#PARTE II
Datos_Wholesale<-  read.table(file.choose(),header=TRUE,  sep=",")
summary(Datos_Wholesale)
table(Datos_Wholesale$Fresh)
head(Datos_Wholesale)
library(graphics) 
par(mfrow=c(2,3))
hist(Datos_Wholesale$Fresh,  main  =  "Hist.Fresh",  xlab  =  "Fresh") 
hist(Datos_Wholesale$Milk,  main  =  "Hist. Milk",  xlab  =  "Milk") 
hist(Datos_Wholesale$Grocery,  main  =  "Hist. Grocery",  xlab  = "Grocery")
hist(Datos_Wholesale$Frozen,  main  =  "Hist. Frozen",  xlab  =  "Frozen") 
hist(Datos_Wholesale$Detergents_Paper,  main  =  "Hist. Detergents_Paper",  xlab  =  "Detergents_Paper")
hist(Datos_Wholesale$Delicassen,  main  =  "Hist. Delicassen",  xlab  = "Delicassen")

D1=kmeans(Datos_Wholesale, 1)
D2=kmeans(Datos_Wholesale, 2)
D3=kmeans(Datos_Wholesale, 3)
D4=kmeans(Datos_Wholesale, 4)
D5=kmeans(Datos_Wholesale, 5)
D6=kmeans(Datos_Wholesale, 6)
D7=kmeans(Datos_Wholesale, 7)
D8=kmeans(Datos_Wholesale, 8)
D9=kmeans(Datos_Wholesale, 9)
D10=kmeans(Datos_Wholesale, 10)
D1$withinss
D1$size
D2$withinss
D2$size
D3$withinss
D3$size
D4$withinss
D4$size
D5$withinss
D5$size
D6$withinss
D6$size
D7$withinss
D7$size
D8$withinss
D8$size
D9$withinss
D9$size
D10$withinss
D10$size

library(factoextra)
fviz_cluster  (D1,  Datos_Wholesale,  geom  =  "point",  stand  =FALSE,  ellipse.type
               =  "Euclid")
fviz_cluster  (D2,  Datos_Wholesale,  geom  =  "point",  stand  =FALSE,  ellipse.type
               =  "Euclid")
fviz_cluster  (D3,  Datos_Wholesale,  geom  =  "point",  stand  =FALSE,  ellipse.type
               =  "Euclid")
fviz_cluster  (D4,  Datos_Wholesale,  geom  =  "point",  stand  =FALSE,  ellipse.type
               =  "Euclid")
fviz_cluster  (D5,  Datos_Wholesale,  geom  =  "point",  stand  =FALSE,  ellipse.type
               =  "Euclid")
fviz_cluster  (D6,  Datos_Wholesale,  geom  =  "point",  stand  =FALSE,  ellipse.type
               =  "Euclid")
fviz_cluster  (D7,  Datos_Wholesale,  geom  =  "point",  stand  =FALSE,  ellipse.type
               =  "Euclid")
fviz_cluster  (D8,  Datos_Wholesale,  geom  =  "point",  stand  =FALSE,  ellipse.type
               =  "Euclid")
fviz_cluster  (D9,  Datos_Wholesale,  geom  =  "point",  stand  =FALSE,  ellipse.type
               =  "Euclid")
fviz_cluster  (D10,  Datos_Wholesale,  geom  =  "point",  stand  =FALSE,  ellipse.type
               =  "Euclid")
porcentaje = 0.10

# tot.withinss entrega la suma de variaciones entre grupos

tots = c(D1$tot.withinss,
         D2$tot.withinss,
         D3$tot.withinss,
         D4$tot.withinss,
         D5$tot.withinss,
         D6$tot.withinss,
         D7$tot.withinss,
         D8$tot.withinss,
         D9$tot.withinss,
         D10$tot.withinss)
diferencias = tots[1:9] - tots[2:10]
porcentajes = diferencias/tots[1]

min_errores = porcentajes[porcentajes < porcentaje][1]
k = match(min_errores, porcentajes)
k

fviz_nbclust  (Datos_Wholesale,  kmeans,  method  =  "wss")  +
  geom_vline(xintercept  =  3,  linetype  =  2)  +	labs(subtitle  =  "Método del Codo")

library("NbClust")
nb  <-  NbClust(Datos_Wholesale,  distance  =  "euclidean",  min.nc  =  2,  max.nc  = 10,  method  =  "kmeans")
library("factoextra") 
fviz_nbclust(nb)

Fresh =  Datos_Wholesale$Fresh 
Grocery  =  Datos_Wholesale$Grocery
plot(Fresh,Grocery,col= c("red",  "blue",  "green")[D3$cluster])

# Para obtener subgrupo, usamos k = 3 por regla de 10 %
indices = D3$cluster
subgrupo1 = subset(Datos_Wholesale, indices == 1)
summary(subgrupo1)
dim(subgrupo1)
sd(subgrupo1$Fresh)
sd(subgrupo1$Grocery)

indices = D3$cluster
subgrupo2 = subset(Datos_Wholesale, indices == 2)
summary(subgrupo2)
dim(subgrupo2)
sd(subgrupo2$Fresh)
sd(subgrupo2$Grocery)

indices = D3$cluster
subgrupo3 = subset(Datos_Wholesale, indices == 3)
summary(subgrupo3)
dim(subgrupo3)
sd(subgrupo3$Fresh)
sd(subgrupo3$Grocery)



