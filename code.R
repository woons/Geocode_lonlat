library(XML)

# DaumMap APIKEY 
APIKey <- "비밀"

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
  latlon <- cbind(lat, lng)
  latlon <- as.data.frame(latlon, rownames=NULL)
  return (latlon)
}

# sample vector
my_address <- c("제주 특별자치도 제주시 첨단로 242", "부산광역시 동래구 안락1동 921-5", "서울특별시 구로구 공원로6가길")

# empty vector
final_lonlat <- NULL

# loop
for(i in my_address){
  xml_address <- getUrls(i, "xml")
  local_lonlat <- getData(xml_address)
  final_lonlat <- rbind(final_lonlat, local_lonlat)
}

