library(sf)
library(tmap)
library(dplyr)
library(geodata)

# Charger les données des aires protégées
AP_Vahatra <- st_read("data/AP_Vahatra.geojson") %>%
  st_make_valid()

# Charger les communes
communes <- gadm(country = "Madagascar", level = 4, path = "data") %>%
  st_as_sf() %>%
  st_make_valid()

# Filtrer les communes qui intersectent le buffer
communes_avec_ap <- communes %>%
  filter(lengths(st_intersects(., AP_Vahatra)) > 0)

# Visualiser les résultats
tm_shape(communes_avec_ap) + 
  tm_borders() +
  tm_shape(AP_Vahatra) + 
  tm_borders(col = "red")
