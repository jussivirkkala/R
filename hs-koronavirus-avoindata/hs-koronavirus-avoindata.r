
# @jussivirkkala
# 2021-02-29 Renamed processedThlData, Adding finnishCoronaHospitalData
# 2021-02-28 First version

# Install package once.

# install.packages("jsonlite")
# install.packages("magick")

# Using jsonlite

library(jsonlite)
library(magick)

# Load previous data

load(paste("hs-koronavirus-avoindata-",Sys.Date()-1,".Rdata",sep=""))
processedThlData1<-processedThlData
data1<-as.data.frame(processedThlData1$confirmed[22])
summary(data1)
y1<-unlist(data1[1])
sum(y1)

sumY# Load data from hs-avoindata

processedThlData<-fromJSON("https://w3qa5ydb4l.execute-api.eu-west-1.amazonaws.com/prod/processedThlData")
finnishCoronaHospitalData<-fromJSON("https://w3qa5ydb4l.execute-api.eu-west-1.amazonaws.com/prod/finnishCoronaHospitalData")
thlTestData<-fromJSON("https://w3qa5ydb4l.execute-api.eu-west-1.amazonaws.com/prod/thlTestData")
hcdTestData<-fromJSON("https://w3qa5ydb4l.execute-api.eu-west-1.amazonaws.com/prod/hcdTestData")
finnishVaccinationData<-fromJSON("https://w3qa5ydb4l.execute-api.eu-west-1.amazonaws.com/prod/finnishVaccinationData")

# Save json with ISO8601 date

save(processedThlData,finnishCoronaHospitalData,thlTestData,hcdTestData,finnishVaccinationData,
     file=paste("hs-koronavirus-avoindata-",Sys.Date(),".RData",sep=""))

# Get all cases
data<-as.data.frame(processedThlData$confirmed[22])
y<-unlist(data[1])

# New case
sum(y)-sum(y1)

files<-c()
for (i in 1:length(processedThlData$confirmed)) {
  # Convert to frame
  data<-as.data.frame(processedThlData$confirmed[i])
  y<-unlist(data[1])
  data1<-as.data.frame(processedThlData1$confirmed[i])
  y1<-unlist(data1[1])
  
  
  title1=names(processedThlData$confirmed[i])
  title2=paste(title1," ",Sys.Date()," N=",sum(y),". Lis�ys ",sum(y)-sum(y1),".",sep="")


  # Save
  title1<-paste("tapaukset-",title1,".png",sep="")
  files[i]<-title1
  
  png(file=title1,width=1000,heigh=500)
  par(mfrow=c(2,1))
  plot(y[1:(length(y)-3)],type="l",lwd=2,ylab="Korona tapauksia",xlab="P�ivi� 2020 alusta",main=title2)
  abline(v=c((length(y)-3-27),(length(y)-3)))
  plot(y[(length(y)-3-27):(length(y)-3)],type="b",lwd=2,ylab="Korona tapauksia",xlab="Viimeiset 28 p�iv��")
  dev.off()

  
}

# Create gif

imgs <- files
img_list <- lapply(imgs, image_read)
img_joined <- image_join(img_list)
img_animated <- image_animate(img_joined, fps = 1)

img_animated
image_write(image = img_animated,path = "tapaukset.gif")

# git add .
# git commit -a -m "Update"

paste("Uusia COVID-19 tapauksia ",Sys.Date()," n=",sum(y)-sum(y1),". Yhteens� N=",sum(y)," Kuvista uusimmat 4 p�iv�� j�tetty pois https://github.com/jussivirkkala/R/tree/main/hs-koronavirus-avoindata",sep="")


# End
