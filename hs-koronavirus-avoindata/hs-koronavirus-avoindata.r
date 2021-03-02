
# @jussivirkkala
# 2021-03-01 Subplot
# 2021-02-29 Renamed processedThlData, Adding finnishCoronaHospitalData
# 2021-02-28 First version

# Install packages once.

install.packages("jsonlite")
install.packages("dplyr")
install.packages("magick")


# Load previous data

load(paste("hs-koronavirus-avoindata-",Sys.Date()-1,".Rdata",sep=""))
processedThlData1<-processedThlData
data1<-as.data.frame(processedThlData1$confirmed[22])
summary(data1)
y1<-unlist(data1[1])
sum(y1)

# Load data from hs-avoindata

library(jsonlite)

processedThlData<-fromJSON("https://w3qa5ydb4l.execute-api.eu-west-1.amazonaws.com/prod/processedThlData")
finnishCoronaHospitalData<-fromJSON("https://w3qa5ydb4l.execute-api.eu-west-1.amazonaws.com/prod/finnishCoronaHospitalData")
thlTestData<-fromJSON("https://w3qa5ydb4l.execute-api.eu-west-1.amazonaws.com/prod/thlTestData")
hcdTestData<-fromJSON("https://w3qa5ydb4l.execute-api.eu-west-1.amazonaws.com/prod/hcdTestData")
finnishVaccinationData<-fromJSON("https://w3qa5ydb4l.execute-api.eu-west-1.amazonaws.com/prod/finnishVaccinationData")

# Save json with ISO8601 date

save(processedThlData,finnishCoronaHospitalData,thlTestData,hcdTestData,finnishVaccinationData,
     file=paste("hs-koronavirus-avoindata-",Sys.Date(),".RData",sep=""))

# https://dplyr.tidyverse.org/

library(dplyr)

files<-c()
names=c("Finland","HYKS","Other than HYKS","TAYS","OYS","KYS","TYKS")
for (i in 1:length(names)) {
  n=names[i]
  region<-finnishCoronaHospitalData$hospitalised %>% filter(area==n)
  hospitalised=region$totalHospitalised;
  inICU=region$inIcu;

  title2=paste(n," ",Sys.Date()," Hospitalized ",hospitalised[length(hospitalised)]," in ICU ",inICU[length(inICU)],sep="")
  png(file=paste("Hospital-",n,".png",sep=""),width=1000,heigh=500)
  plot(hospitalised,type="l",xlab = "Days from 2020",ylab="Hospitalized (in ICU)",main =title2 )
  lines(inICU)
  dev.off()
}

# Get all cases
confirmed<-as.data.frame(processedThlData$confirmed[22])
y<-confirmed$Kaikki.sairaanhoitopiirit.value

# New case
sum(y)-sum(y1)

files<-c()
for (i in 1:length(processedThlData$confirmed)) {
  # Convert to frame
  data<-as.data.frame(as.data.frame(processedThlData$confirmed[i]))
  y<-unlist(data[1])
  data1<-as.data.frame(as.data.frame(processedThlData1$confirmed[i]))
  y1<-unlist(data1[1])
  
  
  title1=names(processedThlData$confirmed[i])
  title2=paste(title1," ",Sys.Date()," N=",sum(y),". Lisäys ",sum(y)-sum(y1),".",sep="")


  # Save
  title1<-paste("tapaukset-",title1,".png",sep="")
  files[i]<-title1
  
  png(file=title1,width=1000,heigh=500)
  yl=c(0,max(y[1:(length(y)-3)]))
  par(mfrow=c(2,1))
  plot(y[1:(length(y)-3)],type="l",lwd=2,ylab="Korona tapauksia",xlab="Päiviä 2020 alusta",main=title2,ylim=yl)
  abline(v=c((length(y)-3-28),(length(y)-3)),lwd=2)
  plot(y[(length(y)-3-28):(length(y)-3)],type="b",lwd=2,ylab="Korona tapauksia",xlab="Viimeiset 28 päivää (poislukien uusimmat 4)",ylim=yl, new=FALSE)
  abline(v=c(1,8,15,22,29),lwd=2)
  dev.off()
}

# Create gif

library(magick)

imgs <- files
img_list <- lapply(imgs, image_read)
img_joined <- image_join(img_list)
img_animated <- image_animate(img_joined, fps = 1)

img_animated
image_write(image = img_animated,path = "tapaukset.gif")


paste("Uusia COVID-19 tapauksia ",Sys.Date()," n=",sum(y)-sum(y1),". Yhteensï¿½ N=",sum(y)," Kuvista uusimmat 4 pï¿½ivï¿½ï¿½ jï¿½tetty pois https://github.com/jussivirkkala/R/tree/main/hs-koronavirus-avoindata",sep="")

# git add .
# git commit -a -m "Update"

# End

