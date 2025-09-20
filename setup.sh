#!/bin/bash

# A script to set up the Waybar weather module.
# Run this from the project's root directory after cloning.

set -e

# --- 1. Introduction and Pre-flight Checks ---

echo "super waybar weather"
echo "-------------------------------------"
echo "CERVEZA :)))))"
echo

# Check for required dependencies (wofi and curl)
echo "Checking for required dependencies..."
if ! command -v wofi &> /dev/null; then
    echo "Error: 'wofi' is not installed."
    echo "Please install wofi (e.g., 'sudo apt install wofi' or 'sudo pacman -S wofi') and run this script again."
    exit 1
fi

if ! command -v curl &> /dev/null; then
    echo "Error: 'curl' is not installed."
    echo "Please install curl (e.g., 'sudo apt install curl' or 'sudo pacman -S curl') and run this script again."
    exit 1
fi
echo "All required dependencies are installed."
echo

# --- 2. Set Permissions and Create Files ---

echo "Creating and setting executable permissions for the scripts..."

# Create weather-input.sh
cat << 'EOF' > weather-input.sh
#!/bin/bash
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
wofi_style="$SCRIPT_DIR/wofi-weather.css"
city_name=$(wofi -dmenu -s "$wofi_style" -p "Enter City, State (e.g., Baltimore,MD):")
if [ -n "$city_name" ]; then
    echo "$city_name" > "$SCRIPT_DIR/current_location"
fi
EOF
chmod +x weather-input.sh

# Create weather-display.sh
cat << 'EOF' > weather-display.sh
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
EOF
chmod +x weather-display.sh

# Create the new weather-forecast.sh
cat << 'EOF' > weather-forecast.sh
#!/bin/bash
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
LOCATION_FILE="$SCRIPT_DIR/current_location"
if [ -f "$LOCATION_FILE" ]; then
  LOCATION=$(cat "$LOCATION_FILE")
else
  LOCATION="London"
fi
curl -s "wttr.in/$LOCATION?n"
EOF
chmod +x weather-forecast.sh

# Create wofi-weather.css
cat << 'EOF' > wofi-weather.css
window {
  background-color: #3b4252;
  border: 2px solid #8fbcbb;
}
input {
  color: #eceff4;
  background-color: #4c566a;
}
#prompt {
  color: #a3be8c;
}
EOF

echo "All files created and permissions set successfully."
echo

# --- 3. Provide Waybar Configuration ---

# Get the absolute path of the current directory
SCRIPT_DIR=$(pwd)

echo "Please manually add the following configuration to your Waybar config file."
echo "Your Waybar config is usually located at ~/.config/waybar/config."
echo "----------------------------------------------------------------------"
echo "        \"custom/weather\": {"
echo "            \"format\": \"{}\","
echo "            \"tooltip\": true,"
echo "            \"on-click\": \"$SCRIPT_DIR/weather-input.sh\","
echo "            \"exec\": \"$SCRIPT_DIR/weather-display.sh\","
echo "            \"on-hover\": \"$SCRIPT_DIR/weather-forecast.sh\","
echo "            \"interval\": 1800"
echo "        }"
echo "----------------------------------------------------------------------"
echo "Copy and paste the above snippet into an appropriate section of your config (e.g., \"modules-left\")."
echo "!!! MAKE SURE IF YOU PLACE THIS MODULE BETWEEN OTHER MODULES THAT YOU PLACE A COMMA AFTER THE SQUIGGLY BRACKET !!!"
echo

# --- 4. Final Instructions ---

echo "Setup is complete."
echo "To see the changes, you must restart Waybar."
echo "You can do this by running 'killall waybar' and then 'waybar &'."
echo
echo "Thank you for using this module!"
