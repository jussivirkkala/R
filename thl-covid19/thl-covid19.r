
# @jussivirkkala
# 2021-02-03 First version based on https://thl.fi/en/web/thlfi-en/statistics/statistical-databases/open-data/confirmed-corona-cases-in-finland-covid-19-
#   this english version contains more examples than finnish version.

# Install packages once.

# install.packages("rjstat")

library(rjstat)
url_base <- "https://sampo.thl.fi/pivot/prod/fi/epirapo/covid19case/fact_epirapo_covid19case.json"
request <- "?row=hcdmunicipality2020-445268L&column=dateweek20200101-509030"

hae_kunnat.sh:uri=
  "https://sampo.thl.fi/pivot/prod/fi/epirapo/covid19case/fact_epirapo_covid19case?

row=hcdmunicipality2020-445268L&fz&fo&column=measure-444833"


# Died
https://sampo.thl.fi/pivot/prod/fi/epirapo/covid19case/fact_epirapo_covid19case.json?row=dateweek20200101-508500L&column=measure-492118&fz&fo

cube <- fromJSONstat(paste0(url_base,request), naming = "label", use_factors = F, silent = T)

library(jsonlite)

json <- material <- fromJSON("https://sampo.thl.fi/pivot/prod/en/epirapo/covid19case/fact_epirapo_covid19case.json?column=ttr10yage-444309")

