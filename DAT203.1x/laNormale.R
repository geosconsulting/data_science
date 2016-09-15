genera_normali <- function(casi,mean=600,sd=30){
  lanormale <- rnorm(casi,mean,sd)
  summary(lanormale)
  hist(lanormale,main = paste("numero casi ", casi),col='red')
  laSd<-sd(lanormale)
  abline(v=mean(lanormale),col='red')
  abline(v=mean(lanormale)+laSd,col='blue')
  abline(v=mean(lanormale)-laSd,col='blue')
  abline(v=mean(lanormale)+(2*laSd),col='blue')
  abline(v=mean(lanormale)-(2*laSd),col='blue')
}

numero_casi = c(100,1000,250000,500000)
lapply(numero_casi, genera_normali)
