### Super Waybar Weather

A custom Waybar module that displays weather for a specified location. The module features an interactive `wofi` prompt to change the city or ZIP code, and the setting persists across reboots.

-----

### Prerequisites

You need the following programs installed on your system:

  * **`waybar`**: The main bar.
  * **`wofi`**: A program launcher used for user input.
  * **`curl`**: A tool to fetch data from the web.

On Arch Linux, you can install these with:

```bash
sudo pacman -S waybar wofi curl
```

-----

### Installation

1.  **Clone the repository:**
    Open your terminal and clone the project to a location you prefer.

    ```bash
    git clone https://github.com/broijustwantiris/super-waybar-weather.git
    cd super-waybar-weather
    ```

2.  **Run the setup script:**
    This script will create all the necessary files and set the correct permissions.

    ```bash
    chmod +x setup.sh
    ./setup.sh
    ```

-----

### Configuration

The setup script will print a configuration snippet. You must **manually copy and paste** this snippet into your Waybar config file.

1.  Open your Waybar configuration file, typically located at `~/.config/waybar/config` (or a file specified with the `--config` flag).
2.  Add the `custom/weather` module to your desired position in the `modules-left`, `modules-center`, or `modules-right` section.

<!-- end list -->

```json
"modules-right": [
    "custom/weather",
    "clock",
    "tray"
]
```

3.  Add the module's full configuration, which the setup script printed for you. It should look like this:

<!-- end list -->

```json
    "custom/weather": {
        "format": "{}",
        "on-click": "/home/reagan/super-waybar-weather/weather-input.sh",
        "exec": "/home/reagan/super-waybar-weather/weather-display.sh",
        "interval": 1800
    }
```

**Important:** Ensure your path is correct and that the full JSON object is placed correctly, with a comma `,` at the end if it's not the last module.

-----

### Usage

1.  **Restart Waybar:**
    After saving your configuration file, restart Waybar to apply the changes.

    ```bash
    pkill waybar
    waybar &
    ```

2.  **Set Your Location:**
    Click the new weather module on your bar. A `wofi` prompt will appear. Type your city and state (e.g., `Baltimore,MD`) or a ZIP code and press Enter.

Your weather will now be displayed and will update automatically every 30 minutes.
