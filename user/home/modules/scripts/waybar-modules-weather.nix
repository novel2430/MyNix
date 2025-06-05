{pkgs, ...}:
let
  jq = "${pkgs.jq}/bin/jq";
  curl = "${pkgs.curl}/bin/curl";
in
pkgs.writeShellScriptBin "waybar-modules-weather" ''
set -euo pipefail
unset http_proxy
unset https_proxy

icon="󰅟"
class_name="custom-weather"

if [ -z "''${WEATHER_API_KEY:-}" ]; then
  exit 1
fi

geo_json=$(${curl} -s --max-time 3 "https://geolocation-db.com/json/")
lat=$(echo "$geo_json" | ${jq} -r '.latitude')
lon=$(echo "$geo_json" | ${jq} -r '.longitude')
city=$(echo "$geo_json" | ${jq} -r '.city')

if [[ -z "$lat" || "$lat" == "null" || -z "$lon" || "$lon" == "null" ]]; then
  exit 1
fi

weather=$(${curl} -s "http://api.weatherapi.com/v1/current.json?key=$WEATHER_API_KEY&q=''${lat},''${lon}&aqi=no")

if echo "$weather" | grep -q '"error"'; then
  exit 1
fi

temp_c=$(echo "$weather" | ${jq} -r '.current.temp_c')
condition=$(echo "$weather" | ${jq} -r '.current.condition.text')
wind_kph=$(echo "$weather" | ${jq} -r '.current.wind_kph')
humidity=$(echo "$weather" | ${jq} -r '.current.humidity')

text="$icon $condition"
tooltip="City: $city\rTemperature: $temp_c°C\rCondition: $condition\rWind: $wind_kph km/h\rHumidity: $humidity%"

echo "{ \"text\": \"$text\", \"tooltip\": \"$tooltip\", \"class\": \"$class_name\"}"

''

