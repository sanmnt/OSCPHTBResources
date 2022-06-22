#!/bin/bash

GEOURL=https://www.ipinfodb.com/my_ip_location.php
WEAURL=http://forecast.weather.gov/zipcity.php?inputstring=

# Get zip code
wget -q -O /tmp/geo.html $GEOURL
ZIPCODE=$(grep -A 1 Postcode /tmp/geo.html | tail -n 1 | cut -d' ' -f1)

# Get temperature
wget -q -O /tmp/weather.html $WEAURL$ZIPCODE
TEMP=$(grep 'myforecast-current-lrg' /tmp/weather.html| cut -d'&' -f1 | cut -d'>' -f2)

HOUR=$(date +%H)
if [[ $HOUR -ge 0 && $HOUR -le 11 ]]; then
    GREET="Good Morning"
elif [[ $HOUR -ge 12 && $HOUR -le 17 ]]; then
    GREET="Good Afternoon"    
else
    GREET="Good Evening"
fi

echo "$GREET $USER."
echo "Current Temp: ${TEMP}F"
echo ""

# if [[ "$(date +%p)" == "PM" ]]; then
#     echo "PM"
# else
#     echo "AM"
# fi
