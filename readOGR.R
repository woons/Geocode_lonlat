# packages needed
library(sp)
library(rgdal)
library(ggplot2)
library(ggmap)
library(tidyverse)
library(ggthemes)

# read shapefile
gis_data <- readOGR(".", "mapo")
info <- gis_data@data # load dbf as data.frame

# check data.frame
is.data.frame(info)

# read address
address <- read.csv("information_game_address.csv", stringsAsFactors = FALSE, encoding = "utf-8")

# read coords (bessel)
xy <- gis_data@proj4string 
xy

# point chart (vis)
map <- get_map("Sangsu-dong", zoom = 15, scale = 1)
ggmap(map) + geom_point(data = address, aes(x=Longitude, y=Latitude, colour = 법정동)) + theme_woons()


