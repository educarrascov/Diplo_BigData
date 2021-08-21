# 1) Carga los datos en la sesión de trabajo

  datos <- read.table(file.choose(),header=TRUE, sep=",")

# 2) Calcule en forma manual el puntaje z

  media.o <- mean(datos$hour_per_week)
  desv.o <- sd(datos$hour_per_week)
  media.o
  desv.o

  puntaje_z <- (datos$hour_per_week-media.o)/desv.o

  media.z <- mean(puntaje_z)
  desv.z <- sd(puntaje_z)
  media.z
  desv.z


# 3) Construye un histograma de los datos originales y los datos estandarizados

  par(mfrow=c(1,2))
  hist(datos$hour_per_week)
  hist(puntaje_z)

# 4) Construye un boxplot de los datos originales y los datos estandarizados

  par(mfrow=c(1,2))
  boxplot(datos$hour_per_week)
  boxplot(puntaje_z)
  

# 5) Construye un histograma y un boxplot de los datos originales y los datos estandarizados

  par(mfrow=c(2,2))
  hist(datos$hour_per_week)
  hist(scale(datos$hour_per_week))
  boxplot(datos$hour_per_week)
  boxplot(scale(datos))

