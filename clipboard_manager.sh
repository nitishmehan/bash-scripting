#!/bin/bash

HISTORY_FILE="/tmp/clipboard_history.txt"
touch "$HISTORY_FILE"

# Clipboard watcher
clipboard_watcher() {
    LAST=""
    while true; do
        CLIP=$(xclip -selection clipboard -o 2>/dev/null)

        if [[ -n "$CLIP" && "$CLIP" != "$LAST" ]]; then
            echo "$CLIP" >> "$HISTORY_FILE"
            echo "------------------------" >> "$HISTORY_FILE"
            LAST="$CLIP"
        fi
        sleep 2
    done
}

# Show clipboard history
show_history_gui() {
    if [[ ! -s "$HISTORY_FILE" ]]; then
        zenity --info --text="Clipboard history is empty!" --width=500 --height=200
        return
    fi

    zenity --text-info \
        --filename="$HISTORY_FILE" \
        --title="Clipboard History" \
        --width=800 --height=600
}

# Clear clipboard history
clear_history() {
    > "$HISTORY_FILE"
    zenity --info --text="Clipboard history cleared!" --width=400 --height=200
}

# Main menu with clean GUI
menu() {
    while true; do
        CHOICE=$(zenity --list \
            --title="Clipboard Manager" \
            --text="Choose an option:" \
            --column="Action" --column="Description" \
            --width=600 --height=300 \
            "Show" "View clipboard history" \
            "Clear" "Clear clipboard history" \
            "Exit" "Exit the application")

        case "$CHOICE" in
            "Show")
                show_history_gui
                ;;
            "Clear")
                clear_history
                ;;
            "Exit" | "" )
                kill $WATCHER_PID 2>/dev/null
                break
                ;;
        esac
    done
}

# Start clipboard watcher in background
clipboard_watcher &
WATCHER_PID=$!

# Start GUI menu
menu
