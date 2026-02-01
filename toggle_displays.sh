#!/bin/bash

# Replace eDP-1 and HDMI-1 with your actual displays
PRIMARY="eDP"
SECONDARY="HDMI-A-0"
#!/bin/bash

# File to store current mode
MODE_FILE="$HOME/.display_mode"

# Read current mode or default to single
MODE=$(cat "$MODE_FILE" 2>/dev/null || echo "single")

# Cycle modes
case "$MODE" in
    "single")
        # Single → Mirror
        xrandr --output $PRIMARY --auto --output $SECONDARY --auto --same-as $PRIMARY
        NEXT_MODE="mirror"
        ;;
    "mirror")
        # Mirror → Extended
        xrandr --output $PRIMARY --auto --output $SECONDARY --auto --right-of $PRIMARY
        NEXT_MODE="extended"
        ;;
    "extended")
        # Extended → Single
        xrandr --output $SECONDARY --off --output $PRIMARY --auto
        NEXT_MODE="single"
        ;;
esac


# Save next mode for next run
echo "$NEXT_MODE" > "$MODE_FILE"
