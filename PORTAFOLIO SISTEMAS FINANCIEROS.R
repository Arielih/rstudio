library(xts)
library(tseries)
library("tidyverse")
library(zoo)
library(dplyr)
library(PerformanceAnalytics)
library(quantmod)
library(Quandl)


#El comando más útil de  esta librería:  getSymbols(). Importar de Yahoo.	

getSymbols("NKE")
getSymbols("MRK")
getSymbols("MMM")
getSymbols("INTC")
getSymbols("JNJ")
getSymbols("CSCO")
getSymbols("^GSPC")   # Este e el indice SP500  Nota: Hay que eliminar^ 

# Se analiza la estructura de la serie importada. Se toma como ejemplo NKE.

head(NKE)

tail(NKE)

plot.zoo(NKE)


#EN OCASIONES ES NECESARIO CAMBIAR EL TICKER

GSPC <- getSymbols("^GSPC", env = NULL)

head(GSPC)


#Son datos diarios de 2007 a 2021 y con varias columnas.Se mensualizan.

NKEm <- to.monthly(NKE)
MRKm <- to.monthly(MRK)
MMMm <- to.monthly(MMM)
INTCm <- to.monthly(INTC)
JNJm<- to.monthly(JNJ)
CSCOm<- to.monthly(CSCO)

head(CSCOm)
tail(CSCOm)


# RENDIMIENTOS POR CADA STOCK. SE TOMA AL CLOSE. Y SE ELIMINA EL PRIMER RENGLÓN.
RNKE <- Return.calculate(NKEm[ ,4])
RNKE <- RNKE[-1, ]
RMRK <- Return.calculate(MRKm[ ,4])
RMRK <- RMRK[-1, ]
RMMM <- Return.calculate(MMMm[ ,4])
RMMM <- RMMM[-1, ]
RINTC <- Return.calculate(INTCm[ ,4])
RINTC <- RINTC[-1, ]

RJNJ <- Return.calculate(JNJm[ ,4])
RJNJ <- RJNJ[-1, ]
RCSCO <- Return.calculate(CSCOm[ ,4])
RCSCO <- RCSCO[-1, ]

### Rendimiento del 2007 
plot.zoo(RNKE[1:11,])
plot.zoo(RMRK)


#########
# AHORA, LO IMPORTANTE. JUNTAR EN UN SOLO FRAMEWORK

RET_6 <- merge(RNKE,RMRK,RMMM,RINTC,RJNJ,RCSCO)
head(RET_6)



#Ahora, tomo una muestra, por ejemplo: 2017-01-01, 2020-12-31
# Se usa el comando "window"
RET_6m <- window(RET_6, start = "2017-01-01", end = "2020-12-31")
head(RET_6m)
write.table(RET_6m,"RET_6m")