# Carga los datos en la sesión de trabajo

  datos <- read.table(file.choose(),header=TRUE, sep=",")

  

# 1) kmeans
d1 = kmeans(datos, 1)
d2 = kmeans(datos, 2)
d3 = kmeans(datos, 3)
d4 = kmeans(datos, 4)
d5 = kmeans(datos, 5)
d6 = kmeans(datos, 6)
d7 = kmeans(datos, 7)
d8 = kmeans(datos, 8)
d9 = kmeans(datos, 9)
d10 = kmeans(datos, 10)

# El valor pedido se almacena en la variable withinss

d1$withinss
d2$withinss
d3$withinss
d4$withinss
d5$withinss
d6$withinss
d7$withinss
d8$withinss
d9$withinss
d10$withinss

# 2)

# Se debe definir un criterio: 
# pararemos cuando la mejora sea menor a un % del total inicial, conocida como regla del codo
# o "elbow method"

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

# Vemos que distintos criterios darían distintos k. 
plot(porcentajes)
lines(rep(0.1, 10), type = 'l', col = 'red') # 10 %
lines(rep(0.05, 10), type = 'l', col = 'blue') # 5 %
lines(rep(0.01, 10), type = 'l', col = 'green') # 1 %


# 3)

Fresh = Datos_Wholesale$Fresh
groc = Datos_Wholesale$Grocery
plot(Fresh, groc, col = c("blue", "red", "green")[D3$cluster])

# Para obtener subgrupo, usamos k = 3 por regla de 10 %
indices = d3$cluster
subgrupo = subset(datos, indices == 1)
summary(subgrupo)
