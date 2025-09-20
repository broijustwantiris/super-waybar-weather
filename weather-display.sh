#!/bin/bash
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
LOCATION_FILE="$SCRIPT_DIR/current_location"
if [ -f "$LOCATION_FILE" ]; then
  LOCATION=$(cat "$LOCATION_FILE")
else
  LOCATION="London"
fi
LOCATION_NAME=$(curl -s "wttr.in/$LOCATION?format=%l")
WEATHER_DATA=$(curl -s "wttr.in/$LOCATION?format=%t")
CONDITION_CODE=$(curl -s "wttr.in/$LOCATION?format=%C")
echo "$LOCATION_NAME: $WEATHER_DATA ($CONDITION_CODE)"
