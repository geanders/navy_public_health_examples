# Load the required packages
library("readr")
library("magrittr")
library("DT")
library("plotly")
library("sf")
library("leaflet")

# Load the data for the example
fl_accidents <- read_csv("data/fl_accidents.csv")

# <--scroll down-->

















# Example 1---Create an interactive data table
fl_accidents %>% 
  datatable()

# <--scroll down-->


















# Example 2---Fancier data table
datatable(fl_accidents, 
          class = "compact", 
          caption = "Example of an interactive data table. Each observation (row) is the information for one of the fatal motor vehicle accidents in Florida the week of Hurricane Irma's landfall, with columns for the county where the accident occurred, the date of the accident, and the number of fatalities.",
          colnames = c("County FIPS", "Date",
                       "Latitude", "Longitude", "# fatalities"),
          width = 800)

# <--scroll down-->


















## Example 3---Interactive plot
fatality_plot <- ggplot(data = daily_fatalities) + 
  geom_line(aes(x = date, y = fatals), color = "darkgray") + 
  geom_point(aes(x = date, y = fatals, color = weekday), size = 2) + 
  expand_limits(y = 0) + 
  scale_color_viridis_d() + 
  labs(x = "Date", y = "# of fatalities", color = "Day of week") + 
  ggtitle("Motor vehicle fatalities in Florida",
          subtitle = "Late summer / early fall of 2019") +
  theme(legend.position = "bottom")

fatality_plot %>% 
  ggplotly()

# <--scroll down-->

















# Example 4---Convert the data to an sf object and then create
# an interactive plot
fl_accidents %<>% 
  st_as_sf(coords = c("longitud", "latitude")) %>% 
  st_sf(crs = 4326)

leaflet() %>% 
  addTiles() %>% 
  addMarkers(data = fl_accidents)

# <--scroll down-->

















# Example 5---Fancier interactive plot, with a track for Irma and 
# pop-up information
irma_track <- st_read("data/al112017_best_track", 
                      layer = "al112017_lin") %>% 
  st_transform(crs = 4326)

fl_accidents %<>% 
  mutate(popup = paste("<b>Date:</b>", date, 
                       "<br/>",
                       "<b># fatalities:</b>", fatals))

leaflet() %>% 
  addTiles() %>%
  fitBounds(lng1 = -88, lng2 = -80, lat1 = 24.5, lat2 = 31.5) %>% 
  addMarkers(data = fl_accidents,
             popup = ~ popup) %>% 
  addPolylines(data = irma_track, color = "red")

















