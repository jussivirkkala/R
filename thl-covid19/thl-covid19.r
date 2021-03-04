
# @jussivirkkala
# 2021-02-03 First version based on https://thl.fi/fi/tilastot-ja-data/aineistot-ja-palvelut/avoin-data/varmistetut-koronatapaukset-suomessa-covid-19-

# Install packages once.

install.packages("rjstat")

library(rjstat)
url_base <- "https://sampo.thl.fi/pivot/prod/fi/epirapo/covid19case/fact_epirapo_covid19case.json"
request <- "?row=hcdmunicipality2020-445268L&column=dateweek20200101-509030"

cube <- fromJSONstat(paste0(url_base,request), naming = "label", use_factors = F, silent = T)
