library(rpart) 	#si es que no tienes este paquete instalado, sigue el tutorial.
data(stagec)   	#cargamos la base que se explic� en clases
head(stagec)   	#damos un vistaso del encabezado de los datos
names(stagec)	#Le pedimos los nombres de las columnas de la base o tambien llamadas variables.
#help(stagec)     #descomenta esta linea para ver el help de la base (ingles)
progstat <- factor(stagec$pgstat, levels=0:1,labels=c("No", "Prog"))
#en esta parte covertimos los 0's y 1's en labels con palabras. Si el cancer esta 
#progesando dir� "prog", sino aparecera un "No".

############################
#####Creaci�n del �rbol#####
############################
cfit <- rpart(progstat ~ age + eet + g2 + grade +gleason + ploidy,data=stagec, method="class")
#genera el arbol de desiciones utilizando todas las variables

############################
###Visualizaci�n del �rbol##
############################
print(cfit)
plot(cfit) 
text(cfit)
printcp(cfit)
# estas cuatro lineas juntas crean la visualizaci�n del �rbol.
#En el arbol, en cada nodo se ve la pregunta donde se genera el corte:
# - El lado izquierdo es respues Si (a la pregunta).
# - El lado derecho es respuesta No.
#Por Ej: una persona con grade =1,4 se iria por la rama izquierda y si progstat=No.

############################
######Podando el �rbol######
############################

pruned.tree <- prune(cfit,cp=0.06) #Poda el �rbol con, cp mide el grado de flexibilidad al podar
plot(pruned.tree)
text(pruned.tree)
#las ultimas lineas grafican el �rbol.


