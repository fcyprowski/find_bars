getToken = function(file = 'facebook_token.json') {
  jsonlite::fromJSON(file)$access_token
}
base_url = function() {
  'https://graph.facebook.com'
}
api_version = function() {
  'v3.0'
}
endpoint = function() {
  'search'
}
get_lat_long_from_city = function(city) {
  center = ggmap::geocode(city)
  i = 1
  while((nrow(na.omit(center)) == 0) & i < 10) {
    center = ggmap::geocode(city)
    i = i + 1
  }
  stopifnot(length(na.omit(center)) == 2)
  return(center)
}
api_request_params = function(fields = c('name', 'checkins',
                                         'location{latitude,longitude}'),
                              city) {
  list(
    type = 'place',
    fields = paste0(fields, collapse = ','),
    center = get_lat_long_from_city(city) %>%
      mutate(param = paste(lat, lon, sep = ',')) %>%
      magrittr::extract2('param'),
    distance = 10000,
    categories = '["FOOD_BEVERAGE"]',
    access_token = getToken(),
    limit = 1000
  )
}
getPlaces = function(city) {
  paste0(base_url(), '/',
         api_version(), '/',
         endpoint(), '?') %>%
    httr::modify_url(
      query = api_request_params(city = city)
    ) %>%
    httr::GET(httr::verbose()) %>%
    httr::content() %>%
    magrittr::extract2('data') %>%
    purrr::map_dfr(~as.data.frame(.))
}