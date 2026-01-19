#!/usr/bin/env bash

player=$(playerctl -l 2>/dev/null | head -n1)

if [ -z "$player" ]; then
  echo '{"text": "", "tooltip": "No media"}'
  exit 0
fi

status=$(playerctl status 2>/dev/null)
artist=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)

case "$status" in
  Playing) icon="" ;;
  Paused)  icon="" ;;
  *)       icon="" ;;
esac

text="$artist - $title"

jq -nc --arg text "$text" --arg icon "$icon" \
'{
  text: $text,
  icon: $icon,
  tooltip: $text
}'
