library(readr)
library(dplyr)
library(lubridate)


somministrazione_vaccini <-
    read_csv('https://raw.githubusercontent.com/italia/covid19-opendata-vaccini/master/dati/somministrazioni-vaccini-summary-latest.csv') %>%
    mutate(data_somministrazione_data = ymd(data_somministrazione))

df <- somministrazione_vaccini %>%
    filter(data_somministrazione_data > (max(data_somministrazione_data) - 90)) %>%
    group_by(data_somministrazione) %>%
    summarize(
        prima_dose = sum(prima_dose),
        ciclo_completo = sum(seconda_dose) + sum(pregressa_infezione),

    )

write_csv(df, 'csv/somministrazione_vaccini_90_giorni.csv')
