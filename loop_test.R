library(XML)
library(tidyverse)

# DaumMap APIKEY 
APIKey <- ""

# Request Parameters
getUrls <- function(address, type){
  url <- "http://apis.daum.net/local/geo/addr2coord?apikey="
  urls <- NULL
  urls <- c(urls, paste0(url, APIKey,"&q=",address,"&output=", type))
  return (urls)
}

# Response Element Setting
getData <- function(url){
  root <- xmlRoot(xmlParse(url))
  lat <- xmlSApply(getNodeSet(root, "//lat"), xmlValue)
  lng <- xmlSApply(getNodeSet(root, "//lng"), xmlValue)
  latlon <- cbind(lat, lng) %>% as.data.frame %>% slice(1)
  print(latlon)
  latlon_df <- as.data.frame(latlon, rownames=NULL)
  latlon_false <- data.frame(lat = NA, lng = NA, stringsAsFactors = F)
  
  #만약 lat, lng이 제값을 가지면 그대로 반환 아니면 NA로 채움
  if(is.list(lat) | is.list(lng)){
    return(latlon_false)
  }else{
    return(latlon_df)
  }
}
# get data
my_address <- unique(read.csv("address.csv", stringsAsFactors = F, encoding = "utf-8"))

# empty vector
final_lonlat <- NULL

# loop
for(i in my_address$address){
  xml_address <- getUrls(i, "xml")
  local_lonlat <- getData(xml_address)
  final_lonlat <- rbind(final_lonlat, local_lonlat)
}
