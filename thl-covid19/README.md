# thl-covid19

Reading https://thl.fi/en/web/thlfi-en/statistics/statistical-databases/open-data/confirmed-corona-cases-in-finland-covid-19- data. Notice that  Finnish version of the same page contains much less examples. 

## Version
<li>2021-03-28 First version.


## Examples 

With help of https://wwww.twitter.com/kooran below some example queries.  By default it opens THl cube graphical interface. By replacing case? with case.json? or case.csv? you can open json or csv file.

Weekly new cases, population, tests in municipality and hospital districts. Tests are only reported on hospital district levels.

https://sampo.thl.fi/pivot/prod/fi/epirapo/covid19case/fact_epirapo_covid19case?row=hcdmunicipality2020-445222&column=measure-444833.445344.445356.&column=dateweek20200101-509030&row=445268L


Monthly new cases in 5 year age groups

https://sampo.thl.fi/pivot/prod/fi/ttr/shp/fact_shp?row=agegroup-12046&column=time-429400.429352.429393.429340.429353.429341.429370.429390.429357.429386.429354.429367.429358.510062.510084.510102.510048.510056.510070.510057.510108.510071.510087.510072.510063.510113.&filter=reportgroup-438231&filter=measure-73006

 /100 000 

https://sampo.thl.fi/pivot/prod/fi/ttr/shp/fact_shp?row=agegroup-12046&column=time-429400.429352.429393.429340.429353.429341.429370.429390.429357.429386.429354.429367.429358.510062.510084.510102.510048.510056.510070.510057.510108.510071.510087.510072.510063.510113.&filter=reportgroup-438231&filter=measure-73008


End
