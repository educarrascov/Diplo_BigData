##############################
######### Script kNN #########
##############################

# Cargamos los datos de la base de datos "iris"
data("iris")  

# Cargamosla librería "class"
library(class)  

# Armamos un conjunto de entrenamiento con los primeros 25 de cada tipo
train <- rbind(iris3[1:25,,1], iris3[1:25,,2], iris3[1:25,,3]) 

# Los de prueba con los siguientes 25
test <- rbind(iris3[26:50,,1], iris3[26:50,,2], iris3[26:50,,3]) 

# Creamos una lista con un nombre más sencillo para cada categoría que conocemos
cl <- factor(c(rep("s",25), rep("c",25), rep("v",25))) 

# Ajustamos modelo a partir de 'train' y se usa para predecir las clases de 'test'
lazy<-knn(train, test, cl, k = 3, prob=TRUE) 

# Imprimimos el objeto que resulta del ajuste
print(lazy)



# Ahora probamos con el paquete kknn, que posee más funcionalidades
library(kknn)

# Cargamos de nuevo los datos
data(iris)

# Guardamos el número de datos
m <- dim(iris)[1]

# Sacamos un subconjunto de índices para el conjunto de validación
val <- sample(1:m, size = round(m/3), replace = FALSE,
              prob = rep(1/m, m))

# El de entrernamiento no tendrá los de validación, se separa la base en dos
iris.learn <- iris[-val,]
iris.valid <- iris[val,]

# Hacemos el ajuste, modelamos el tipo de especie a partir del resto de las variables
iris.kknn <- kknn(Species~., iris.learn, iris.valid, distance = 1,
                  kernel = "triangular")

# Vemos el resumen del ajuste
summary(iris.kknn)

# Extraemos los ajustados
fit <- fitted(iris.kknn)

# Hacemos la tabla de contingencia para ver la calidad del ajuste
table(iris.valid$Species, fit)

# Escribimos las categorías como números
pcol <- as.character(as.numeric(iris.valid$Species))

# Finalmente vemos los gráficos entre variable, para ver 
# si el caso que quedó mal clasificado tiene alguna 
# característica en particular. Es importante además notar que 
# en la última columna se pueden ver los datos agrupados
pairs(iris.valid[1:4], pch = pcol, col = c("green3", "red")
      [(iris.valid$Species != fit)+1])
