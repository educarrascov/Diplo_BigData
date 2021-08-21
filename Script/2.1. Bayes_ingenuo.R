
library(e1071)                         	#si le aparece "Error in library(e1071) : there is no package called ?e1071?"
						   	#Instale el paquete e1071 siguiendo el tutorial
data(HouseVotes84,package="mlbench")   	#Instale el paquete mlbench
names(HouseVotes84)				#Entrega el nombre de las variables
head(HouseVotes84)				#Da un vistaso r?pido a los datos

######################################
#### M?delo predictivo n?mero 1   ####
######################################
model <- naiveBayes(Class~.,data=HouseVotes84) 	#Genera el modelo usando bayes ingenuo
predict(model, HouseVotes84[1:10,]) 		#Predice en los primeros 10 datos, si es que son republicanos o democratas
predict(model, HouseVotes84[1:10,],type="raw")  #Da la probabilidad de ser republicano y la de ser democrata para los primeros diez votantes.
#################################### 

######################################
#### Predicciones m?delo n?mero 1 ####
######################################
pred <- predict(model, HouseVotes84) 	#predecimos sobre todos los datos
table(pred, HouseVotes84$Class)		#Genera una tabla comparativa entre los datos predichos y los reales.
#
#la tabla es de la siguiente forma
#			|Real=Democrata|Real =republicano|
#_________________|______________|_________________|
# pred=Democrata	|	bien	   |		mal	   |
#_________________|______________|_________________|
# pred=Republicano|	mal	   |		bien	   |
#_________________|______________|_________________|
#
#y en cada cuadro de la tabla, indica la cantidad de aciertos o errores de cada tipo.
#################################### 


######################################
#### Usando correcci?n de Laplace ####
######################################
model2 <- naiveBayes(Class~.,data=HouseVotes84,laplace=3)	#Genera una prediccion con Bayes ingenuo y una correcci?n de Laplace
pred2 <- predict(model2,HouseVotes84[,-1])			#Predice
table(pred2, HouseVotes84$Class)					#Compara
#################################### 
