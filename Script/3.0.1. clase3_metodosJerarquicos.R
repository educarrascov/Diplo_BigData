##################
### Cars example
##################
data(mtcars)
head(mtcars)
names(mtcars)
# Estandarizacin de variables.
cars.use <- mtcars[,-c(1,2)]
cars.use
medians <- apply(cars.use,2,median)
mads <- apply(cars.use,2,mad)
cars.use <- scale(cars.use,center=medians,scale=mads)
# Matriz de distancias
cars.dist <- dist(cars.use)
# Hierarchical clustering
cars.hclust <- hclust(cars.dist)
cars.hclust
plot(cars.hclust,main="Default from hclust")