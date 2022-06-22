#!/bin/bash
WHOME=~/.weather
GEOURL=https://www.ipinfodb.com/my_ip_location.php
WEAURL=http://forecast.weather.gov/zipcity.php?inputstring=
if [[ ! -d $WHOME ]]; then
    mkdir $WHOME
    chmod 700 $WHOME
fi
#MYIP=$(ip addr show wlan1 | grep 'inet ' | cut -d' ' -f6 | cut -d'/' -f1)
HOUR=$(date +%H)

wget -q -O /tmp/geo.html $GEOURL
ZIPCODE=$(grep -A 1 Postcode /tmp/geo.html | tail -n 1 | cut -d' ' -f1)

if [[ ! -r $WHOME/$ZIPCODE ]]; then
    # zip code file does not exist
    wget -q -O /tmp/weather.html $WEAURL$ZIPCODE
    TEMP=$(grep 'myforecast-current-lrg' /tmp/weather.html| cut -d'&' -f1 | cut -d'>' -f2)
elif [[ $(stat $WHOME/$ZIPCODE | grep -i modify | cut -d' ' -f3 | cut -d':' -f1) -lt $HOUR ]]; then
    # Older than one hour
    wget -q -O /tmp/weather.html $WEAURL$ZIPCODE
    TEMP=$(grep 'myforecast-current-lrg' /tmp/weather.html| cut -d'&' -f1 | cut -d'>' -f2)
else
    # load weather from cache
    TEMP=$(head -n1 $WHOME/$ZIPCODE)
fi
echo $TEMP > $WHOME/$ZIPCODE

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
