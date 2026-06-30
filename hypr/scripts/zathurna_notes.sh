#!/usr/bin/env bash

# Set the path to your central notes file
NOTES_FILE="$HOME/Documents/zathura_notes.md"

# 1. Grab text from the primary clipboard (selection)
# Use wl-paste for Wayland, or xclip for X11
if [ -n "$WAYLAND_DISPLAY" ]; then
    TEXT=$(wl-paste --primary)
else
    TEXT=$(xclip -o -selection primary)
fi

# 2. Check if the selection is empty to avoid blank entries
if [ -z "$TEXT" ]; then
    exit 0
fi

# 3. Append to the Markdown file with a neat format
{
    echo "### Snippet saved on $(date '+%Y-%m-%d %H:%M')"
    echo ""
    echo "> $TEXT"
    echo ""
    echo "---"
    echo ""
} >> "$NOTES_FILE"
