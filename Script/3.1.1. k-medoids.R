library(cluster) #Instalar libreria cluster
head(iris)
iris.use<-iris[,1:4] #se quita la variable specie

iris.pam<-pam(iris.use,3) #se genera el modelo usando k medoides con k=3
iris.pam 			  #se muestra la salida del modelo

names(iris.pam)
table(iris.pam$clustering,iris[,5]) #se ve que los clusters calzan con la especia

plot(iris.pam,ask=T)		#se plotea con un grafico especial de pam
					#usar el siguiente menú:
					#1: no usar
					#2: grafica los cluster visualmente usando componentes
					#3: grafico de silueta
					#0: salir del menú
