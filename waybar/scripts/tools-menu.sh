#!/usr/bin/env bash
chosen=$(printf "%s\n" \
  "  Color Picker" \
  "  Screenshot" \
  "  Clipboard History" \
  "  Audio Visualizer" \
  "  Displays" |
  wofi --dmenu --prompt "Tools" --width 280 --height 260)

case "$chosen" in
*"Color Picker"*)
  sleep 0.2
  hyprpicker -a
  ;;
*"Screenshot"*) hyprshot -m region ;;
*"Clipboard History"*) cliphist list | wofi --dmenu | cliphist decode | wl-copy ;;
*"Audio Visualizer"*) kitty --class cava-float -e cava ;;
*"Displays"*) wdisplays ;;
esac
