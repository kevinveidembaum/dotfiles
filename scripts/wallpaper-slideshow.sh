#!/bin/bash

# Directory containing your wallpapers
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Interval in seconds between wallpaper changes
INTERVAL=600

# Loop forever
while true; do
  # Find all image files in the wallpaper directory with .jpg or .png extensions
  # and select one randomly
  feh --randomize --bg-scale "$WALLPAPER_DIR"/*.{jpg,png}
  
  # Wait for the specified interval before changing again
  sleep $INTERVAL
done

