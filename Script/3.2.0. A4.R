# 1) Carga los datos en la sesión de trabajo

  datos <- read.table(file.choose(),header=TRUE, sep=",")


# 2) Clacula el tamaño de la silueta para diferentes k
  library(cluster)

  my.k.choices <- 2:10
  avg.sil.width <- rep(0, length(my.k.choices))
  for (ii in (1:length(my.k.choices)) )
  {
       avg.sil.width[ii] <- pam(datos, k=my.k.choices[ii])$silinfo$avg.width
  }
  print( cbind(my.k.choices, avg.sil.width) )

# K=2 es buen numero

# 3) Define k=2 conglomerados

  fit.medoids <- pam(datos, 2)
  names(fit.medoids)

  fit.medoids$medoids
  fit.medoids$id.med

# 4) Gráfico de silueta

  plot(fit.medoids, which.plots=2)

# ancho de silueta promedio por cluster
  fit.medoids$silinfo$clus.avg.widths
# ancho de silueta promedio general
  fit.medoids$silinfo$avg.widt

# 5) Conglomerados jerárquico aglomerativo

# Matriz de distancias
  wholesale.dist <- dist(datos)

# Hierarchical clustering
  fit.hclust <- hclust(wholesale.dist)
  fit.hclust

  plot(fit.hclust)

# 6) Reduciendo a dos grupos

  fit.hclust.2 <- cutree(fit.hclust,2)
  table(fit.hclust.2) # 439-1
  fit.medoids$clusinfo #333-107


# 7) Calculando el número de observaciones por cada uno de los k grupos

  counts <- sapply(2:10,function(ncl)table(cutree(fit.hclust,ncl)))
  names(counts) <- 2:10
  counts
