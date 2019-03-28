# Load the required packages
library("readr")
library("magrittr")
library("dplyr")
library("tidyr")
library("stringr")
library("lubridate")

# Read in the required data

fl_accidents <- read_csv("data/accident.csv")


# <--scroll down-->














# Clean up the data using the tidyverse framework of small functions (verbs)
# strung together with a pipe operator. Try highlighting certain rows of
# this call and running them (highlight everything up to one of the %>%s),
# and then check out the output step-by-step to get a better idea of how
# this process works. Note that, because we're not assigning this 
# output to an object, it will print out but not save (see the next step for 
# how to do that).

fl_accidents %>% 
  rename_all(.funs = str_to_lower) %>% 
  select(state, county, day, month, year, latitude, longitud, fatals) %>% 
  filter(state == 12) %>% 
  mutate(county = str_pad(county, width = 3, pad = "0")) %>% 
  unite(col = fips, c(state, county), sep = "") %>% 
  unite(col = date, c(month, day, year), sep = "-") %>% 
  mutate(date = mdy(date)) %>% 
  filter(date >= mdy("9-7-2017") & date <= mdy("9-13-2017"))

# <--scroll down-->
















# Overwrite the original fl_accidents data with the cleaned version
fl_accidents %<>% 
  rename_all(.funs = str_to_lower) %>% 
  select(state, county, day, month, year, latitude, longitud, fatals) %>% 
  filter(state == 12) %>% 
  mutate(county = str_pad(county, width = 3, pad = "0")) %>% 
  unite(col = fips, c(state, county), sep = "") %>% 
  unite(col = date, c(month, day, year), sep = "-") %>% 
  mutate(date = mdy(date)) %>% 
  filter(date >= mdy("9-7-2017") & date <= mdy("9-13-2017"))

