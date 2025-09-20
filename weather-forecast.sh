#!/bin/bash
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
LOCATION_FILE="$SCRIPT_DIR/current_location"
if [ -f "$LOCATION_FILE" ]; then
  LOCATION=$(cat "$LOCATION_FILE")
else
  LOCATION="London"
fi
curl -s "wttr.in/$LOCATION?n"
