# Load the required packages
library("readr")
library("sf")
library("tigris")
library("ggplot2")

# Load the data for the examples and convert it to the sf class
fl_accidents <- read_csv("data/fl_accidents.csv")
fl_accidents %<>% 
  st_as_sf(coords = c("longitud", "latitude")) %>% 
  st_sf(crs = 4326)

irma_tracks <- st_read("data/al112017_best_track/",
                       layer = "al112017_lin") %>% 
  st_transform(crs = 4326)

fl_counties <- counties(state = "FL", cb = TRUE, class = "sf")

# <--scroll down-->


















# First mapping example
ggplot() + 
  geom_sf(data = fl_counties) + 
  geom_sf(data = fl_accidents, aes(color = date)) +
  geom_sf(data = irma_tracks, color = "red", size = 1.5) + 
  coord_sf(xlim = c(-88, -80), ylim = c(24.5, 31.5)) 

# <--scroll down-->


















# Second mapping example
ggplot() + 
  geom_sf(data = fl_counties, fill = "antiquewhite") + 
  geom_sf(data = fl_accidents, color = "darkcyan") +
  geom_sf(data = irma_tracks, color = "red") + 
  coord_sf(xlim = c(-88, -80), ylim = c(24.5, 31.5)) + 
  facet_wrap(~ date, ncol = 4) + 
  theme_bw() + 
  theme(panel.background = element_rect(fill = "aliceblue"),
        axis.ticks = element_blank(),
        axis.text = element_blank(),
        panel.grid = element_line(color = "white", size = 0.8))





