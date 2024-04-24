

library(dplyr)
library(leafem)
library(leaflet)

totaldata = readRDS("../R samples/totaldata.rds")

mybins <- c(-0.5, 5, 10, 15, 20, 25, 30)
mypalette <- colorBin(
  palette = "YlOrBr", domain = totaldata$전체발생수,
  na.color = "transparent", bins = mybins
)

leaflet(options = leafletOptions(zoomControl = FALSE)) %>%
  addLogo(img = "https://www.gnfire.go.kr/images/web/gnfire/common/logo.gif",
          url = "https://www.gnfire.go.kr/",
          position = "topleft", width = 180, height = 30, offset.x = 10, offset.y = 10) %>%
  addTiles(
    urlTemplate = 'https://api.vworld.kr/req/wmts/1.0.0/42719290-DC5A-3003-B9DE-877944F23D35/Base/{z}/{y}/{x}.png',
    options = tileOptions(minZoom = 8)) %>%
  
  #addPolygons(data = geo_sig, stroke = TRUE, color = "#000000", weight = 0.6, smoothFactor = 0, fillOpacity = 0) %>% 
  addPolygons(data = totaldata, label = totaldata$GRID_1K_CD, stroke = TRUE, 
              fillColor = ~ mypalette(전체발생수), weight = 0.6, smoothFactor = 0.3, fillOpacity = 1) 
