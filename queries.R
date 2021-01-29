# Crea un repositorio en Github llamado Reto_Sesion_7
# 
# Crea un Project llamado Reto_Sesion_07 dentro de RStudio utilizando tu cuenta 
# de RStudio, que esté ligado al repositorio recién creado
# 
# Ahora en RStudio crea un script llamado queries.R en donde se conecte a 
# la BDD shinydemo
install.packages("DBI")
install.packages("RMySQL")
library(DBI)
library(RMySQL)
MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")
# Una vez hecha la conexión a la BDD, generar una busqueda con dplyr que 
# devuelva el porcentaje de personas que hablan español en todos los países
install.packages("dplyr")
library(dplyr)
dbListTables(MyDataBase)
View(MyDataBase)
dbListFields(MyDataBase, 'CountryLanguage')
Data.Lang <- dbGetQuery(MyDataBase, "select * from CountryLanguage")
Data.Spanish <- Data.Lang  %>%
  filter(Language == "Spanish")
Data.Spanish <- as.data.frame(Data.Spanish)
View(Data.Spanish)
install.packages("ggplot2")
# Realizar una gráfica con ggplot que represente este porcentaje de tal 
# modo que en el eje de las Y aparezca el país y en X el porcentaje, y 
# que diferencíe entre aquellos que es su lengua oficial y los que no 
# con diferente color (puedes utilizar la geom_bin2d() y coord_flip())
library(ggplot2)
grafo <- ggplot(Data.Spanish, aes(x=Percentage, y=CountryCode, 
                                  fill=IsOfficial))+
  geom_bin2d()+
  coord_flip()+
  labs(x = "Porcentaje hablante", y= "Paises", main="Paises hispano1")+
  theme_dark()
grafo

Data.Spanish %>%
  ggplot() +
  aes(x = Percentage,y = CountryCode, fill = IsOfficial) +
  geom_col()+
  ggtitle("Paises hispano3")+
  xlab("Procentaje de hablantes") + 
  ylab("Paises")+
  theme_dark()#+
  geom_bin2d()


# Una vez hecho esto hacer el commit y push para mandar tu archivo al 
# repositorio de Github Reto_Sesion_7