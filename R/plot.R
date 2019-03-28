# Load the required packages
library("readr")
library("ggplot2")
library("forcats") 
library("magrittr")
library("dplyr")
library("lubridate")

# Load the data for the example
daily_fatalities <- read_csv("data/daily_fatalities.csv")

# <--scroll down-->






# First example
ggplot(data = daily_fatalities) + 
  geom_line(aes(x = date, y = fatals), color = "darkgray") + 
  geom_point(aes(x = date, y = fatals, color = weekday), size = 2) + 
  expand_limits(y = 0) + 
  scale_color_viridis_d() + 
  labs(x = "Date", y = "# of fatalities", color = "Day of week") + 
  ggtitle("Motor vehicle fatalities in Florida",
          subtitle = "Late summer / early fall of 2019") +
  theme(legend.position = "bottom")

# <--scroll down-->






# Extra for first example---getting the days in the right order in 
# the label
daily_fatalities %<>% 
  mutate(weekday = as_factor(weekday)) %>% 
  mutate(weekday = fct_relevel(weekday, 
                               "Sunday", "Monday", "Tuesday", "Wednesday", 
                               "Thursday", "Friday", "Saturday"))
ggplot(data = daily_fatalities) + 
  geom_line(aes(x = date, y = fatals), color = "darkgray") + 
  geom_point(aes(x = date, y = fatals, color = weekday), size = 2) + 
  expand_limits(y = 0) + 
  scale_color_viridis_d() + 
  labs(x = "Date", y = "# of fatalities", color = "Day of week") + 
  ggtitle("Motor vehicle fatalities in Florida",
          subtitle = "Late summer / early fall of 2019") +
  theme(legend.position = "bottom")

# <--scroll down-->








# Second example
ggplot(data = daily_fatalities) + 
  geom_col(aes(x = weekday, y = fatals), fill = "skyblue") + 
  facet_wrap(~ week, ncol = 1) + 
  theme_classic()  + 
  labs(x = "", y = "# of fatalities") + 
  ggtitle("Motor vehicle fatalities in Florida by weekday, 2019")

# <--scroll down-->










# Extra for second example---better facet labels
daily_fatalities %<>% 
  group_by(week) %>% 
  mutate(first_day = first(date)) %>% 
  ungroup() %>% 
  mutate(week_label = paste("Week of", 
                            month(first_day, label = TRUE, abbr = FALSE), 
                            day(first_day))) %>% 
  mutate(week_label = as_factor(week_label),
         week_label = fct_reorder(week_label, week, .fun = min))

ggplot(data = daily_fatalities) + 
  geom_col(aes(x = weekday, y = fatals), fill = "skyblue") + 
  facet_wrap(~ week_label, ncol = 1) + 
  labs(x = "", y = "# of fatalities") + 
  theme_classic() + 
  ggtitle("Motor vehicle fatalities in Florida by weekday, 2019")

# <--scroll down-->
















# Saving a plot. After you run this, look for a file called "irma_fatalities.pdf" in
# the project folder.
irma_fatalities_plot <- ggplot(data = daily_fatalities) + 
  geom_col(aes(x = weekday, y = fatals), fill = "skyblue") + 
  facet_wrap(~ week_label, ncol = 1) + 
  labs(x = "", y = "# of fatalities") + 
  theme_classic() + 
  ggtitle("Motor vehicle fatalities in Florida by weekday, 2019")

ggsave(irma_fatalities_plot, 
       filename = "irma_fatalities.pdf",
       device = "pdf",
       height = 6, width = 5, units = "in")













