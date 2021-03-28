
# @jussivirkkala
#
# 2021-03-28 First version based on https://thl.fi/en/web/thlfi-en/statistics/statistical-databases/open-data/confirmed-corona-cases-in-finland-covid-19-
#   this english version contains more examples than finnish version.

# Install packages once.
#
# install.packages("jsonlite")


# Load data from thl

library(jsonlite)

cases_week<-fromJSON(
  "https://sampo.thl.fi/pivot/prod/fi/epirapo/covid19case/fact_epirapo_covid19case.json?row=hcdmunicipality2020-445268L&column=measure-141082.444833.445344.&column=dateweek20200101-509030")

cases_age<-fromJSON(
 "https://sampo.thl.fi/pivot/prod/fi/ttr/shp/fact_shp.json?row=agegroup-12046&column=time-429400.429352.429393.429340.429353.429341.429370.429390.429357.429386.429354.429367.429358.510062.510084.510102.510048.510056.510070.510057.510108.510071.510087.510072.510063.510113.&filter=reportgroup-438231&filter=measure-73006")

# Save json with ISO8601 date

save(cases_week, cases_age,
     file=paste("thl-covid19-",Sys.Date(),".RData",sep=""))

# End
