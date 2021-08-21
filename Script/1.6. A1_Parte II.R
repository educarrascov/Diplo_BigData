# 1) Carga los datos en la sesión de trabajo

  datos <- read.table(file.choose(),header=TRUE, sep=",")

# 2) Calcula los estadísticos descriptivos

  summary(datos)

# 3) Cre una variable que indica el tamaño total de la familia del pasajero (incluido el mismo)

  datos$Fsize <- datos$SibSp + datos$Parch + 1

# 4) Grafica la proporción de sobrevivientes versus el tamaño de la familia.

  library(ggplot2)
  library(ggthemes)
  library(scales)

  ggplot(datos, aes(factor(Fsize), Survived)) +
         stat_summary(fun.y=mean, geom="point", shape=21, fill="red", size=2) +
         scale_y_continuous(labels=percent_format(), limits=c(0,1)) +
         theme_bw()

# 5) Define la siguiente discretización:
# Familias de tamaño 1 (1), de 2 a 4 (2),
# de 5 a 7 (3) y mayor a 7 (4).

  datos$FsizeD[datos$Fsize == 1] <- "Solitario"
  datos$FsizeD[datos$Fsize < 5 & datos$Fsize > 1] <- "Familia_Minima"
  datos$FsizeD[datos$Fsize < 8 & datos$Fsize > 4] <- "Familia_Mediana"
  datos$FsizeD[datos$Fsize > 7] <- "Familia_Grande"

  table(datos$FsizeD)


# 6) Identifica los pasajeros con datos faltantes para las variable embarked y age

   Embarked_NA <- datos[is.na(datos$Embarked),]
   Embarked_NA$PassengerId

   Age_NA <- datos[is.na(datos$Age),]
   Age_NA


# 7) Identifica los pasajeros con datos faltantes para la variable embarked

   datos$Embarked[Embarked_NA$PassengerId] <- 'C'
   datos$Age[Age_NA$PassengerId] <- mean(na.omit(datos$Age))

   summary(datos)