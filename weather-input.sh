#!/bin/bash

# Define the path to the directory this script is in
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

# Create a temporary wofi config file that points to the custom stylesheet
echo "style=$SCRIPT_DIR/wofi-weather.css" > "$SCRIPT_DIR/temp_wofi_config"

# Use wofi with the temporary config file
city_name=$(wofi -dmenu --config "$SCRIPT_DIR/temp_wofi_config" -p "Enter City, State (e.g., Baltimore,MD):")

# Clean up the temporary config file
rm "$SCRIPT_DIR/temp_wofi_config"

# If the user enters a value, save it to a file
if [ -n "$city_name" ]; then
    echo "$city_name" > "$SCRIPT_DIR/current_location"
fi
