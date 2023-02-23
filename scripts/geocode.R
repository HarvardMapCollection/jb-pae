library(tidyverse)
library(tidygeocoder)

# Read data
df <- read_csv("~/Desktop/geocoded.csv")


df_geocoded <- df %>%
  # Add column to specify that these are in Mexico
  mutate(to_geocode = paste0(P3_6, ", Mexico")) %>%
  # Geocode with OpenStreetMap
  geocode(to_geocode, method = "osm") %>%
  # Rename lat/long columns to provide clarity about what they represent
  rename(
    P3_6_lat = lat,
    P3_6_lon = long
  )

####### 
####### This is for double-checking the returned values
# library(leaflet)
# 
# unique_latlon <- df_geocoded %>%
#   distinct(P2_1, P2_1_lat, P2_1_lon)
# 
# leaflet(unique_latlon) %>%
#   addTiles() %>%
#   addCircleMarkers(
#     lat = ~P2_1_lat,
#     lng = ~P2_1_lon,
#     popup = ~paste0(P2_1)
#   )
#######

write_csv(df_geocoded, "~/Desktop/geocoded-2.csv")
