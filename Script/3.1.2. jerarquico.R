


##################
### Cars example
##################
cars <- read.table(file.choose(),header=TRUE,sep=",")
head(cars)
names(cars)
# Estandarizacin de variables.
cars.use <- cars[,-c(1,2)]
medians <- apply(cars.use,2,median)
mads <- apply(cars.use,2,mad)
cars.use <- scale(cars.use,center=medians,scale=mads)

# Matriz de distancias
cars.dist <- dist(cars.use)
# Hierarchical clustering
cars.hclust <- hclust(cars.dist)
cars.hclust
plot(cars.hclust,labels=cars$Car,main=’Default from hclust’)

