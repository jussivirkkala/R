# thl-covid19

Reading https://thl.fi/en/web/thlfi-en/statistics/statistical-databases/open-data/confirmed-corona-cases-in-finland-covid-19- data. Notice that  Finnish version of the same page contains much less examples. 

## Version
<li>2021-03-27 First version.

## Examples 

With help of https://wwww.twitter.com/kooran below some example queries. For instance 508500L is used for daily data . By default it opens THl cube graphical interface. By replacing case? with case.json? or case.csv? you can open json or csv file.

Daily deaths:

https://sampo.thl.fi/pivot/prod/en/epirapo/covid19case/fact_epirapo_covid19case?row=dateweek20200101-508500L&column=measure-492118

Daily deaths with hospital district:

https://sampo.thl.fi/pivot/prod/en/epirapo/covid19case/fact_epirapo_covid19case?row=dateweek20200101-508500L&column=hcdmunicipality2020-445222S


Daily cases in hospital districts

https://sampo.thl.fi/pivot/prod/en/epirapo/covid19case/fact_epirapo_covid19case?row=dateweek20200101-508500L&column=hcdmunicipality2020-445222

Daily cases in 5 year age groups
 
 https://sampo.thl.fi/pivot/prod/fi/ttr/shp/fact_shp?row=agegroup-12046&column=time-429400&filter=reportgroup-438231&filter=measure-73006 

Other source of information. https://github.com/hmm/coviddata


Vaccinations by week, district

https://sampo.thl.fi/pivot/prod/en/vaccreg/cov19cov/fact_cov19cov?row=area-518362L&column=cov_vac_age-518413&column=dateweek20201226-525425&column=cov_vac_dose-533170L&column=measure-533175.533172

Total vaccinations, communities

https://sampo.thl.fi/pivot/prod/en/vaccreg/cov19cov/fact_cov19cov?row=area-518376L&column=cov_vac_dose-533170L&column=measure-533175.533172

Vaccinations by week, municipality

https://sampo.thl.fi/pivot/prod/en/vaccreg/cov19cov/fact_cov19cov?row=area-518376L&column=cov_vac_age-518413&column=dateweek20201226-525425&column=cov_vac_dose-533170L&column=measure-533175.533172


 
<li>Monthly cases in 5 year age groups 

 https://sampo.thl.fi/pivot/prod/fi/ttr/shp/fact_shp?row=agegroup-12046&column=time-510113&filter=reportgroup-438231&filter=measure-73006 
 
 hae_ikaryhmat.sh:uri="
 
 https://sampo.thl.fi/pivot/prod/fi/epirapo/covid19case/fact_epirapo_covid19case?row=ttr10yage-443857L&fz&fo&column=measure-444833" 
 
 <li>Total case in municipilaties

 https://sampo.thl.fi/pivot/prod/fi/epirapo/covid19case/fact_epirapo_covid19case?row=hcdmunicipality2020-445131L&column=measure-444833

 
https://sampo.thl.fi/pivot/prod/en/epirapo/covid19case/fact_epirapo_covid19case?row=dateweek20200101-508500L&column=measure-492118
 
 https://sampo.thl.fi/pivot/prod/fi/epirapo/covid19case/fact_epirapo_covid19case?row=hcdmunicipality2020-445131L&fz&fo&column=measure-492118 
 
 https://sampo.thl.fi/pivot/prod/fi/epirapo/covid19case/fact_epirapo_covid19case?row=hcdmunicipality2020-445268L&fz&fo&column=measure-444833 
 
 hae_ttr_alue_2020.sh:uri="
 
 https://sampo.thl.fi/pivot/prod/fi/ttr/shp/fact_shp?row=area-12260&column=time-429400&filter=reportgroup-438231&filter=measure-73006"


<li>Vaccination

https://sampo.thl.fi/pivot/prod/fi/vaccreg/cov19cov/fact_cov19cov?row=area-518362&column=cov_vac_age-518413&column=dateweek20201226-525425&column=cov_vac_dose-533170L&column=measure-533175.533172

<li>Vaccination

https://sampo.thl.fi/pivot/prod/fi/vaccreg/cov19cov/fact_cov19cov.json?row=area-518376L&column=cov_vac_dose-533170L&column=measure-533175.53317

https://sampo.thl.fi/pivot/prod/fi/epirapo/covid19case/fact_epirapo_covid19case?row=dateweek20200101-508500L&column=measure-492118
```
L displays 
```

## .json 
https://sampo.thl.fi/pivot/prod/fi/epirapo/covid19case/fact_epirapo_covid19case.json?row=dateweek20200101-508500L&column=measure-492118
```
csv <- read.csv(file = 'https://sampo.thl.fi/pivot/prod/fi/epirapo/covid19case/fact_epirapo_covid19case.csv?row=dateweek20200101-508500L&column=measure-492118', sep = ';')
csv[3,]
```

## .csv
https://sampo.thl.fi/pivot/prod/fi/epirapo/covid19case/fact_epirapo_covid19case.csv?row=dateweek20200101-508500L&column=measure-492118 Notice that time contains 2020 and 2021.

```
csv <- read.csv(file = 'https://sampo.thl.fi/pivot/prod/fi/epirapo/covid19case/fact_epirapo_covid19case.csv?row=dateweek20200101-508500L&column=measure-492118', sep = ';')
csv[3,]
```



```
library(tidyverse)

```

End
