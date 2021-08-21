#Esta técnica se utiliza como limpieza de datos (agrupación), para determinar si hay datos fuera de rango
#de manera de ser eliminados
library(MASS) 		#cargar libreria
data(mcycle)		#cargar data
head(mcycle)		#ver el encabezado de los datos
length(mcycle)		#largo de mcycle (numero de variables)
length(mcycle[1,])	#largo de mcycle[1,]=primera observaci?n, te da el numero de variables
length(mcycle[,1])	#largo de mcycle[,1]=primera variable, te da la cantidad de observaciones
#como nos piden que hayan 4 observaciones por bin, debemos separar los 133 experimentos
#en bins que contengan solo 4, obviamente sobrar? uno, es por eso que el ?ltimo ser? de 5
#nos olvidaremos del tiempo y suavisaremos la aceleraci?n, luego graficaremos tiempo vs aceleracion.
datasuavizada=mcycle

#suavizamos los datos
for(i in seq(1,132,4)){
	datasuavizada$accel[i:(i+3)]=sum(mcycle$accel[i:(i+3)])/4
}
#corregimos el ultimo bin (ya que tiene 5 elementos
datasuavizada$accel[129:133]=(datasuavizada$accel[132]*4+datasuavizada$accel[133])/5
#graficamos en rojo los datos originales
plot(mcycle,col="red")
#graficamos en linea verde los datos suavizados
lines(datasuavizada,col="green")

