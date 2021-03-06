#set workingdirectory
#seleccionar workingdirectory
setwd("C:/Users/user/Desktop/DataExploration")
library(ggplot2)
#cargar las proyecciones de poblacion del 2017
dataPoblacionMunicipios<-read.csv(file="proyeccionesMunicipios2017.csv",sep=",")
colnames(dataPoblacionMunicipios)
sapply(dataPoblacionMunicipios, class)
head(dataPoblacionMunicipios)
tail(dataPoblacionMunicipios)
#Eliminar registros inexistentes
dataPoblacionMunicipios <- dataPoblacionMunicipios[!apply(is.na(dataPoblacionMunicipios) | dataPoblacionMunicipios == "", 1, all),]
##Esto quita las tildes
dataPoblacionMunicipios$DPNOM<-iconv(dataPoblacionMunicipios$DPNOM,to="ASCII//TRANSLIT")
##Esto quita el espacios,puntuacion
dataPoblacionMunicipios$DPNOM<-gsub("\\s|\\.|\\,", '', dataPoblacionMunicipios$DPNOM)
#Esto pone en mayuscula
dataPoblacionMunicipios$DPNOM<-toupper(dataPoblacionMunicipios$DPNOM)
dataPoblacionMunicipios$DPNOM<-gsub("BOGOTADC", 'CUNDINAMARCA', dataPoblacionMunicipios$DPNOM)
##Esto quita las tildes
dataPoblacionMunicipios$MPIO<-iconv(dataPoblacionMunicipios$MPIO,to="ASCII//TRANSLIT")
#Esto pone en mayuscula
dataPoblacionMunicipios$MPIO<-toupper(dataPoblacionMunicipios$MPIO)
##Esto quita el CD, espacios,puntuacion,(1) y (3) del nombre del municipio
dataPoblacionMunicipios$MPIO<-gsub("[:(:]CD[:):]|\\s|[:(:]1[:):]|[:(:]3[:):]|\\.|\\,|[:(:]2[:):]", '', dataPoblacionMunicipios$MPIO)
#Esto quita la coma
dataPoblacionMunicipios$X2017<-gsub(",", '', dataPoblacionMunicipios$X2017)
#transformar la variable poblacion a numerica
dataPoblacionMunicipios$X2017<-as.numeric(dataPoblacionMunicipios$X2017)
sapply(dataPoblacionMunicipios, class)
#estadisticas descriptivas
summary(dataPoblacionMunicipios$X2017)
sd(dataPoblacionMunicipios$X2017)
##Esto quita el total nacional
dataPoblacionMunicipios <- dataPoblacionMunicipios[-nrow(dataPoblacionMunicipios),]
summary(dataPoblacionMunicipios$X2017)
sd(dataPoblacionMunicipios$X2017)
dataPoblacionMunicipios$MPXDP <-paste(dataPoblacionMunicipios$MPIO, dataPoblacionMunicipios$DPNOM)


#cargar la informacion de hurto a personas de la sijin
dataHurtoPersonas<-read.csv(file="HurtoANSI.csv",sep=",")
head(dataHurtoPersonas)
colnames(dataHurtoPersonas)
summary(dataHurtoPersonas$Municipio)
sapply(dataHurtoPersonas, class)
dataHurtoPersonas$CodigoDANE= substr(dataHurtoPersonas$CodigoDANE,1,nchar(dataHurtoPersonas$CodigoDANE)-3)
##Esto quita puntos de los nombres de las columnas
colnames(dataHurtoPersonas) <- gsub("\\.", "", colnames(dataHurtoPersonas))
##Esto quita las tildes
colnames(dataHurtoPersonas)<-iconv(colnames(dataHurtoPersonas),to="ASCII//TRANSLIT")
##Esto quita el CT y espacios del nombre del municipio
dataHurtoPersonas$Municipio<-gsub("\\s|[:(:]CT[:):]|\\.|\\,", '', dataHurtoPersonas$Municipio)
dataHurtoPersonas$Municipio<-gsub("PUERTOLEGUIZAMO", 'LEGUIZAMO', dataHurtoPersonas$Municipio)
dataHurtoPersonas$Municipio<-gsub("CHIBOLO", 'CHIVOLO', dataHurtoPersonas$Municipio)
##Esto quita las tildes
dataHurtoPersonas$Municipio<-iconv(dataHurtoPersonas$Municipio,to="ASCII//TRANSLIT")
##Esto quita las tildes
dataHurtoPersonas$Departamento<-iconv(dataHurtoPersonas$Departamento,to="ASCII//TRANSLIT")
##Esto quita el espacios,puntuacion
dataHurtoPersonas$Departamento<-gsub("\\s|\\.|\\,", '', dataHurtoPersonas$Departamento)
#Esto pone en mayuscula
dataHurtoPersonas$Departamento<-toupper(dataHurtoPersonas$Departamento)
##Esto PONE VALLE COMO VALLE DEL CAUCA Y GUAJIRA COMO LAGUAJIRA
dataHurtoPersonas$Departamento<-gsub("VALLE", 'VALLEDELCAUCA', dataHurtoPersonas$Departamento)
dataHurtoPersonas$Departamento<-gsub("GUAJIRA", 'LAGUAJIRA', dataHurtoPersonas$Departamento)
dataHurtoPersonas$Departamento<-gsub("SANANDRES", 'ARCHIPIELAGODESANANDRES', dataHurtoPersonas$Departamento)

head(dataProyMunStand)
sapply(dataProyMunStand,class)
dataProyMunStand$DPNOM<-as.factor(dataProyMunStand$DPNOM)
dataProyMunStand$MPIO<-as.factor(dataProyMunStand$MPIO)
summary(dataProyMunStand)

head(dataHurtoPersonas)
View(dataHurtoPersonas)
sapply(dataHurtoPersonas,class)
dataHurtoPersonas2 <- dataHurtoPersonas
#Fecha est� como Factor y debe ser Date
dataHurtoPersonas2$Fecha<-as.Date(dataHurtoPersonas2$Fecha,"%m/%d/%Y")
head(dataHurtoPersonas2[185099,])
sapply(dataHurtoPersonas2,class)
#Departamento y Municipio son character y deben ser factor
dataHurtoPersonas2$Departamento <- as.factor(dataHurtoPersonas2$Departamento)
dataHurtoPersonas2$Municipio<- as.factor(dataHurtoPersonas2$Municipio)
dataHurtoPersonas2$CodigoDANE <- as.factor(dataHurtoPersonas2$CodigoDANE)
dataHurtoPersonas2$Hora <- as.factor(substr(dataHurtoPersonas2$Hora,11,22))
summary(dataHurtoPersonas2)
View(dataHurtoPersonas2)

head(dataMerged2)
View(dataMerged2)
sapply(dataMerged2,class)
str(dataMerged3)
dataMerged3 <- dataMerged2
dataMerged3[,6:44]<-lapply(dataMerged3[,6:44],as.factor)
dataMerged3[,"P5785"]<-as.integer(dataMerged3[,"P5785"])
#DEPMUNI debe ser Factor
#P5785 Numeric Edad
#Todo Factor


#Asumiendo con el diccionario de variables inexistente que cantidad se refiere al numero de objetos
#determinamos cada instancia como un robo en el departamento
dataHurtoPersonas$MPXDP <-paste(dataHurtoPersonas$Municipio, dataHurtoPersonas$Departamento)
#numero de articulos robados por hurto
mytable <- table(dataHurtoPersonas$Cantidad)
mytable
#histograma cantidad no tiene sentido todo esta inclinado hacia el 1
ggplot(dataHurtoPersonas, aes( x=Cantidad)) + geom_histogram()
#numero de robos por dia de la semana
mytable <- table(dataHurtoPersonas$Dia)
mytable
#diagrama de barras dia
ggplot(dataHurtoPersonas, aes(x=Dia)) + geom_histogram(stat = "count")
#movil del agresor
mytable <- table(dataHurtoPersonas$MovilAgresor)
mytable
#diagrama de barras movil del agresor
ggplot(dataHurtoPersonas, aes(x=MovilAgresor)) + geom_histogram(stat = "count")
#movil del victima
mytable <- table(dataHurtoPersonas$MovilVictima)
mytable
#diagrama de barras movil del victima
ggplot(dataHurtoPersonas, aes(x=MovilVictima)) + geom_histogram(stat = "count")
#una tabla para sacar numero de robos por municipio
#mytable <- table(c(dataHurtoPersonas$MUNICIPIO,dataHurtoPersonas$DEPARTAMENTO))
mytable <- table((dataHurtoPersonas$MPXDP))
summary(mytable)
mytable[names(mytable)=="MEDELLIN ANTIOQUIA"]
mytable[names(mytable)=="CALI VALLEDELCAUCA"]
mytable[names(mytable)=="DIBULLA LAGUAJIRA"]
mytable[names(mytable)=="BOGOTADC CUNDINAMARCA"]
mytable[names(mytable)=="PROVIDENCIA ARCHIPIELAGODESANANDRES"]
mytable[names(mytable)=="RIOSUCIO CHOCO"]
mytable[names(mytable)=="LEGUIZAMO PUTUMAYO"]


#obtenemos el departamento con menos crimenes 
unlist(mytable)[which.min(unlist(mytable))]
#ACHI Bolivar EXISTE
#obtenemos el departamento con m�s crimenes 
unlist(mytable)[which.max(unlist(mytable))]
#BOGOTADC
#convertimos la tabla CON CODIGO DANE
mytable <- table((dataHurtoPersonas$CodigoDANE))
dataHurtoXMunicipio <- data.frame(unlist(mytable))
colnames(dataHurtoXMunicipio)<-c('CODIGO','HURTOS')
#Verificamos que todo esta bien
sapply(dataHurtoXMunicipio, class)
head(dataHurtoXMunicipio)
tail(dataHurtoXMunicipio)
#Aplicamos estadistica descriptiva al Hurto
summary(dataHurtoXMunicipio$HURTOS)
sd(dataHurtoXMunicipio$HURTOS)
#plot basico  demasiados municipios
plot(dataHurtoXMunicipio)
#join con poblacion municipio
datapoblacionhurto<-merge(dataHurtoXMunicipio,dataPoblacionMunicipios,by.x = 'CODIGO',by.y = 'DPMP')
#datapoblacionhurto<-merge(dataHurtoXMunicipio,dataPoblacionMunicipios,by.x = 'MPXDP',by.y = 'MPXDP',all.x = TRUE)
#datapoblacionhurto <- datapoblacionhurto[!apply(is.na(datapoblacionhurto$HURTOS) | datapoblacionhurto == "", 1, all),]
datapoblacionhurto$MPXDP[duplicated(datapoblacionhurto$MPXDP)]
mapply(setdiff,datapoblacionhurto$MPXDP,dataHurtoXMunicipio$MPXDP)
setdiff(datapoblacionhurto$MPXDP,dataHurtoXMunicipio$MPXDP)
?merge
#Calculamos el indice de robos por cada 100 000 habitantes
datapoblacionhurto$INDICE <- (datapoblacionhurto$HURTOS/ datapoblacionhurto$X2017)*100000

summary(datapoblacionhurto$INDICE)
sd(datapoblacionhurto$INDICE)
#calculamos el indice maximo y el minimo
tempHurtos<-setNames(as.list(datapoblacionhurto$INDICE), datapoblacionhurto$MPXDP)
tempHurtos[which.max(tempHurtos)]
tempHurtos[which.min(tempHurtos)]

library(dplyr)

datapoblacionhurto  %>%  filter(MPXDP == "GALERAS SUCRE")
datapoblacionhurto  %>%  filter(MPXDP == "CHIQUIZA BOYACA")


plot(datapoblacionhurto$INDICE,datapoblacionhurto$MPXDP)
#graficas no nos dicen mucho as� 


#histograma de distribucion del indice
ggplot(datapoblacionhurto, aes( x=INDICE)) + geom_histogram()

#boxplot por departamento
ggplot(datapoblacionhurto, aes(x=DPNOM, y=INDICE)) + 
  geom_boxplot()


datapoblacionhurto$INDICELOG <- log10(datapoblacionhurto$INDICE )

summary(datapoblacionhurto$INDICELOG)
sd(datapoblacionhurto$INDICELOG)

tempHurtosLOG<-setNames(as.list(datapoblacionhurto$INDICELOG), datapoblacionhurto$MPXDP)
tempHurtosLOG[which.max(tempHurtosLOG)]
tempHurtosLOG[which.min(tempHurtosLOG)]


plot(datapoblacionhurto$INDICELOG,datapoblacionhurto$MPXDP)
#graficas no nos dicen mucho as� 


#histograma de distribucion del indice
ggplot(datapoblacionhurto, aes( x=INDICELOG)) + geom_histogram()

#boxplot por departamento
ggplot(datapoblacionhurto, aes(x=DPNOM, y=INDICELOG)) + 
  geom_boxplot()

#dataHurtoPersonas<-dataHurtoPersonas[,-c(dataHurtoPersonas$Codigo.DANE,dataHurtoPersonas$Cantidad)]
## este comando tumba R dataHurtoPersonas[ ,c(dataHurtoPersonas$Código.DANE,dataHurtoPersonas$Cantidad)] <- list(NULL)
## Tambien me desconecto de la red aunque no estoy seguro de como

#Esto elimina multiples columnas por nombre
dataHurtoPersonas[ ,c('Codigo.DANE','Cantidad')] <- list(NULL)

summary(dataHurtoPersonas$Barrio)
summary(dataHurtoPersonas$Municipio)

?select
attach(dataHurtoPersonas)
dataHurtoPersonas[1,]



?gsub

Municipios<-dataHurtoPersonas %>% select(Municipio)  %>%  filter(Municipio == "MEDELLiN")

summary(Municipios)
detach(dataHurtoPersonas)

dataCaracGen <- read.delim("CaracteristicasGenerales.txt", sep = " ")
head(dataCaracGen)
dataVivienda <- read.delim("DatosVivienda.txt",sep = " ")
head(dataVivienda)
dataPercepSeg <- read.delim("PercepcionSeguridad.txt",sep = "\t")
#El separador de este era \t en vez de espacio.
head(dataPercepSeg)
dataMerged1 = merge(dataCaracGen, dataVivienda, by.x=c("DIRECTORIO", "SECUENCIA_ENCUESTA","SECUENCIA_P","ORDEN","FEX_C"), 
                    by.y=c("DIRECTORIO", "SECUENCIA_ENCUESTA","SECUENCIA_P","ORDEN","FEX_C"))
head(dataMerged1)

dataMerged2 = merge(dataMerged1,dataPercepSeg, by.x=c("DIRECTORIO", "SECUENCIA_ENCUESTA","SECUENCIA_P","ORDEN","FEX_C"),
                    by.y=c("DIRECTORIO", "SECUENCIA_ENCUESTA","SECUENCIA_P","ORDEN","FEX_C"))
head(dataMerged2)

tradcTipoVivienda <- data.frame("cod" = 1:4, "tipo_vivienda" = c("Casa" ,"Apartamento", "Cuarto","Otravivienda"))
dataVivienda= merge(dataVivienda,tradcTipoVivienda,by.x="P5747",by.y="cod")
#dataVivienda[ ,c('P5747','cod')] <- list(NULL)  
mytable3 <- table(dataVivienda$tipo_vivienda)
mytable3
mytable3 <- table(paste(dataVivienda$tipo_vivienda,dataVivienda$DEPMUNI))
mytable3
dataviviendaMuni <- data.frame(unlist(mytable3))
colnames(dataHurtoXMunicipio)<-c('vivxcod','HURTOS')