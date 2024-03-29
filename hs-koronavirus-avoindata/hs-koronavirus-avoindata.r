
# Read hs-koronavirus-avoindata
# 
# @jussivirkkala
# 2021-04-24 Date from last entry
# 2021-04-07 Changes in week and two week
# 2021-04-05 Change of path
# 2021-03-14 Added /max.
# 2021-03-08 Date from data.
# 2021-03-03 Renamed axis, COVID-19.
# 2021-03-01 Subplot.
# 2021-02-29 Renamed processedThlData, Adding finnishCoronaHospitalData.
# 2021-02-28 First version.

# R version 4.0.4 (2021-02-15)
# Platform: x86_64-w64-mingw32/x64 (64-bit)
# Running under: Windows 10 x64 19042.870


# Install packages once.
# install.packages("rstudioapi")
# install.packages("jsonlite")
# install.packages("stringr")
# install.packages("dplyr")
# install.packages("magick")

# set path

library("rstudioapi")
setwd(dirname(getActiveDocumentContext()$path))


# Load previous data

load(paste("hs-koronavirus-avoindata-",Sys.Date()-1,".RData",sep=""))
processedThlData1 <- processedThlData
thlTestData1 <- thlTestData
hcdTestData1 <- hcdTestData
data1<-as.data.frame(processedThlData1$confirmed[22])
y1<-unlist(data1[1])

# Load data from hs-avoindatastr

library(jsonlite)

processedThlData<-fromJSON("https://w3qa5ydb4l.execute-api.eu-west-1.amazonaws.com/prod/processedThlData")
finnishCoronaHospitalData<-fromJSON("https://w3qa5ydb4l.execute-api.eu-west-1.amazonaws.com/prod/finnishCoronaHospitalData")
thlTestData<-fromJSON("https://w3qa5ydb4l.execute-api.eu-west-1.amazonaws.com/prod/thlTestData")
hcdTestData<-fromJSON("https://w3qa5ydb4l.execute-api.eu-west-1.amazonaws.com/prod/hcdTestData")
finnishVaccinationData<-fromJSON("https://w3qa5ydb4l.execute-api.eu-west-1.amazonaws.com/prod/finnishVaccinationData")

# Save json with ISO8601 date


last=Sys.Date()
last=tail(processedThlData$confirmed[22]$`Kaikki sairaanhoitopiirit`$date, n=1)
last=substr(last,1,10)
save(processedThlData,finnishCoronaHospitalData,thlTestData,hcdTestData,finnishVaccinationData,
file=paste("hs-koronavirus-avoindata-",last,".RData",sep=""))

   
for (i in 1:length(hcdTestData)) {
  region <- as.data.frame(hcdTestData[i])
  region1 <- as.data.frame(hcdTestData1[i])
#  print(region[1]-region1[1])
}

# https://dplyr.tidyverse.org/
library(dplyr)
library(stringr)

n="Finland"
region <- finnishCoronaHospitalData$hospitalised %>% filter(area==n)
hospitalised <- region$totalHospitalised
inICU <-region$inIcu
dead <- region$dead

# year ago

s <- Sys.Date()
s <- gsub("2021","2020",s)
writeLines(sprintf("\nVuosi sitten %s:",s))
i <- which(str_detect(region$date,s))
if (length(i)>0) {
writeLines(sprintf("Sairaalassa %i Tehohoidossa %i Kuolleita %i",hospitalised[i],inICU[i],dead[i]))
}

# cases year ago

region <- processedThlData$confirmed$`Kaikki sairaanhoitopiirit`
i <- which(str_detect(region$date,s))
writeLines(sprintf("Tapauksia n=%i",region$value[i]))

# plot beginning of two years, start from wednesdays which is 2020-01-01


i <- which(str_detect(region$date,"2021-01-01"))
j=length(region$date)-i-4
yl=c(0,max(region$value[i:(i+j)]))
plot(region$value[i:(i+j)], type="l", col="red", xlab = "P�ivi� vuoden alusta 2020/2021a",
     ylab = "Diagnosoituja tapauksia", xylim=yl)
par(new=TRUE)
plot(region$value[1:(1+j)], type="l", ylim = yl, col="blue", ylab="", xlab ="")

writeLines("\nSairaalassa, kuolleita (muutos):")
files<-c()
names=c("Finland","HYKS","TAYS","OYS","KYS","TYKS")
for (i in 1:length(names)) {
  n=names[i]
  region<-finnishCoronaHospitalData$hospitalised %>% filter(area==n)
  hospitalised=region$totalHospitalised;
  inICU=region$inIcu;
  deadDiff<-c(0,diff(region$dead))
  
  png(file=paste("Hospital-",n,".png",sep=""),width=1000,heigh=500)
  last=substr(region$date[length(region$date)],1,10)
  title2=paste0(n," ",last," Sairaalassa ",hospitalised[length(hospitalised)],"/",max(hospitalised),
               " (",hospitalised[length(hospitalised)]-hospitalised[length(hospitalised)-1],")",
               ", joista teholla ",inICU[length(inICU)],"/",max(inICU)," (",inICU[length(inICU)]-inICU[length(inICU)-1],")")
  writeLines(title2)
  par(mfrow=c(2,1))
  plot(hospitalised,type="l",xlab = "Tietoja",ylab="Sairaalassa, teholla",main =title2 )
  lines(inICU)
  title3=paste("Kuolemia ",region$dead[length(region$dead)]," (",region$dead[length(region$dead)]-region$dead[length(region$dead)-1],")",sep="")
  plot(deadDiff,type="l",xlab="Tietoja",ylab="Muutos kuolemissa",main=title3)
  writeLines(title3)
  dev.off()
}

# Get all cases
confirmed<-as.data.frame(processedThlData$confirmed[22])
y<-confirmed$Kaikki.sairaanhoitopiirit.value

files<-c()
writeLines("\nSairaanhoitopiirit:")
for (i in 1:length(processedThlData$confirmed)) {
  # Convert to frame
  data<-as.data.frame(processedThlData$confirmed[i])
  y<-unlist(data[1])
  data1<-as.data.frame(as.data.frame(processedThlData1$confirmed[i]))
  y1 <- unlist(data1[1])
  
  title1=names(processedThlData$confirmed[i])
  
  # Date from data
  last<-unlist(data[3])
  last=substr(last[length(last)],1,10)
  title2=paste(title1," ",last," N=",sum(y),". Lis�ys ",sum(y)-sum(y1),".",sep="")
  writeLines(title2)
  
  # Save
  title1<-paste("tapaukset-",title1,".png",sep="")
  files[i]<-title1
  
  png(file=title1,width=1000,heigh=500)
  yl=c(0,max(y[1:(length(y)-3)]))
  par(mfrow=c(2,1))
  plot(y[1:(length(y)-3)],type="l",lwd=2,ylab="COVID-19 tapauksia",xlab="P�ivi� 2020 alusta",main=title2,ylim=yl)
  abline(v=c((length(y)-3-28),(length(y)-3)),lwd=2)
  plot(y[(length(y)-3-28):(length(y)-3)],type="b",lwd=2,ylab="COVID-19 tapauksia",xlab="Viimeiset 28 p�iv�� (poislukien uusimmat 4)",ylim=yl, new=FALSE)
  abline(v=c(1,8,15,22,29),lwd=2)
  dev.off()
}

# Viikko sitten

load(paste0("hs-koronavirus-avoindata-",Sys.Date()-7,".RData"))
processedThlData1 <- processedThlData
data1<-as.data.frame(processedThlData1$confirmed[22])
y7<-unlist(data1[1])
load(paste0("hs-koronavirus-avoindata-",Sys.Date()-7-1,".RData"))
processedThlData1 <- processedThlData
data1<-as.data.frame(processedThlData1$confirmed[22])
y8<-unlist(data1[1])
writeLines(sprintf("\n1 Viikkoa sitten %s uusia tapauksia %i",s,sum(y7)-sum(y8)))

load(paste0("hs-koronavirus-avoindata-",Sys.Date()-14,".RData"))
processedThlData1 <- processedThlData
data1<-as.data.frame(processedThlData1$confirmed[22])
y14<-unlist(data1[1])
load(paste0("hs-koronavirus-avoindata-",Sys.Date()-14-1,".RData"))
processedThlData1 <- processedThlData
data1<-as.data.frame(processedThlData1$confirmed[22])
y15<-unlist(data1[1])
writeLines(sprintf("2 viikkoa sitten uusia tapauksia %i",sum(y14)-sum(y15)))


# Create gif

library(magick)
imgs <- files
img_list <- lapply(imgs, image_read)
# img_list <- lapply(img_list,image_rotate,270)
img_joined <- image_join(img_list)
img_animated <- image_animate(img_joined, fps = 1)
img_animated
image_write(image = img_animated,path = "tapaukset.gif")



# In Terminal

writeClipboard("git add .\n git commit -m update\n git push")
#
# git add .
# git commit -m "Update"
# git push

# End