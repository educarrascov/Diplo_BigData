##################################
######### Script K-means #########
##################################


X.dat <- iris[,3:4]
### Supongamos 8 grupos
X.kmeans <- kmeans(X.dat, 8)
X.kmeans

# Observación: si se usan 3 grupos, da una muy buena partición
# para identificar las distintas especies. Esto se atribuye a la 
# naturaleza geométrica de la información