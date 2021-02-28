
# @jussivirkkala
# 2021-02-28 First version

# Install package once.

# install.packages("jsonlite")
# install.packages("magick")

# Using jsonlite

library(jsonlite)
library(magick)

# Load previous data

load(paste("hs-koronavirus-avoindata-",Sys.Date()-1,".Rdata",sep=""))
json1<-json;
data1<-as.data.frame(json1$confirmed[22])
summary(data1)
y1<-unlist(data1[1])

# Load data from hs-avoindata

json<-fromJSON("https://w3qa5ydb4l.execute-api.eu-west-1.amazonaws.com/prod/processedThlData")

# Save json with ISO8601 date

save(json,file=paste("hs-koronavirus-avoindata-",Sys.Date(),".RData",sep=""))

# Get all cases
data<-as.data.frame(json$confirmed[22])
y<-unlist(data[1])

# New case
sum(y)-sum(y1)

files<-c()
for (i in 1:length(json$confirmed)) {
  # Convert to frame
  data<-as.data.frame(json$confirmed[i])
  y<-unlist(data[1])
  data1<-as.data.frame(json1$confirmed[i])
  y1<-unlist(data1[1])
  
  
  title1=names(json$confirmed[i])
  title2=paste(title1," ",Sys.Date()," N=",sum(y),". T�n��n ",sum(y)-sum(y1),".",sep="")

  # Plot
  plot(y,type="l",lwd=2,ylab="Korona tapauksia",xlab="P�ivi� 2020 alusta",main=title2)

  # Save
  title1<-paste("tapaukset-",title1,".png",sep="")
  files[i]<-title1
  
  png(file=title1,width=1000,heigh=500)
  plot(y,type="l",lwd=2,ylab="Korona tapauksia",xlab="P�ivi� 2020 alusta",main=title2)
  dev.off()

  
}

# Create gif
imgs <- files
img_list <- lapply(imgs, image_read)
img_joined <- image_join(img_list)
img_animated <- image_animate(img_joined, fps = 1)

img_animated
image_write(image = img_animated,path = "tapaukset.gif")

# End