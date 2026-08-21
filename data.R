library(tidyverse)

# Download hourly weather for Sarasota, FL for the past 7 days via Open-Meteo
url <- "https://api.open-meteo.com/v1/forecast?latitude=27.3364&longitude=-82.5307&hourly=temperature_2m,relative_humidity_2m,precipitation,wind_speed_10m&past_days=7&forecast_days=0"

raw_json <- jsonlite::fromJSON(url)

# Format into a clean tibble
weather <- tibble(
  time = ymd_hm(raw_json$hourly$time),
  temperature_2m = raw_json$hourly$temperature_2m,
  relative_humidity_2m = raw_json$hourly$relative_humidity_2m,
  precipitation = raw_json$hourly$precipitation,
  wind_speed_10m = raw_json$hourly$wind_speed_10m
)

# Save to file
write_rds(weather, "sarasota_weather.rds")
write_csv(weather, "sarasota_weather.csv")
