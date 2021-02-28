

# Install package once.

install.packages("jsonlite")

# Using jsonlite

library(jsonlite)

# Load previous

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


for (i in 1:length(json$confirmed)) {
  # Convert to frame
  title1=names(json$confirmed[i])
  print(title1)
  data<-as.data.frame(json$confirmed[i])
  y<-unlist(data[1])
  title2=paste(title1," ",Sys.Date()," N=",sum(y),sep="")
  

  # Plot
  plot(y,type="l",lwd=2,ylab="Korona tapauksia",xlab="Päiviä 2020 alusta",main=title2)

  # Save
  png(file=paste("tapaukset-",title1,".png",sep=""),width=1000,heigh=500)
  plot(y,type="l",lwd=2,ylab="Korona tapauksia",xlab="Päiviä 2020 alusta",main=title2)
  dev.off()
}


