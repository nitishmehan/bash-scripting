#!/bin/bash

HISTORY_FILE="/tmp/clipboard_history.txt"
DELIM="__CLIPBOARD_ENTRY_DELIM__"
touch "$HISTORY_FILE"

# Clipboard watcher
clipboard_watcher() {
    LAST=""
    while true; do
        CLIP=$(xclip -selection clipboard -o 2>/dev/null)
        if [[ -n "$CLIP" && "$CLIP" != "$LAST" ]]; then
            echo "$CLIP" >> "$HISTORY_FILE"
            echo "$DELIM" >> "$HISTORY_FILE"
            LAST="$CLIP"
        fi
        sleep 2
    done
}

# Start clipboard watcher in background
clipboard_watcher &
WATCHER_PID=$!

# Show clipboard history
show_history_gui() {
    if [[ ! -s "$HISTORY_FILE" ]]; then
        zenity --info --text="Clipboard history is empty!" --width=500 --height=200
        return
    fi

    # Read and display each entry, separated by delimiter
    output=""
    entry=""
    while IFS= read -r line || [[ -n "$line" ]]; do
        if [[ "$line" == "$DELIM" ]]; then
            if [[ -n "$entry" ]]; then
                output+="$entry"
                output+="\n------------------------\n"
                entry=""
            fi
        else
            if [[ -n "$entry" ]]; then
                entry+=$'\n'
            fi
            entry+="$line"
        fi
    done < "$HISTORY_FILE"

    # Show in zenity
    echo -e "$output" | zenity --text-info \
        --title="Clipboard History" \
        --width=800 --height=600
}

# Select and copy from clipboard history
select_and_copy_from_history() {
    if [[ ! -s "$HISTORY_FILE" ]]; then
        zenity --info --text="Clipboard history is empty!" --width=500 --height=200
        return
    fi

    # Read entries into an array
    entries=()
    entry=""
    while IFS= read -r line || [[ -n "$line" ]]; do
        if [[ "$line" == "$DELIM" ]]; then
            if [[ -n "$entry" ]]; then
                entries+=("$entry")
                entry=""
            fi
        else
            if [[ -n "$entry" ]]; then
                entry+=$'\n'
            fi
            entry+="$line"
        fi
    done < "$HISTORY_FILE"

    if [[ ${#entries[@]} -eq 0 ]]; then
        zenity --info --text="Clipboard history is empty!" --width=500 --height=200
        return
    fi

    # Prepare previews for zenity list
    choices=()
    for i in "${!entries[@]}"; do
        sno=$((i+1))
        preview=$(echo "${entries[$i]}" | head -c 60 | tr '\n' ' ')
        choices+=("$sno" "$preview")
    done

    SELECTED_INDEX=$(zenity --list \
        --title="Select Clipboard Entry" \
        --text="Select an entry to copy to clipboard:" \
        --column="S.no" --column="Preview" \
        --width=800 --height=600 \
        "${choices[@]}")

    if [[ -n "$SELECTED_INDEX" ]]; then
        idx=$((SELECTED_INDEX-1))
        echo -n "${entries[$idx]}" | xclip -selection clipboard
        zenity --info --text="Selected entry copied to clipboard!" --width=400 --height=200
    fi
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
            --width=600 --height=400 \
            "Select & Copy" "Select and copy from history" \
            "Show" "View clipboard history" \
            "Clear" "Clear clipboard history" \
            "Minimize" "Hide menu temporarily" \
            "Exit" "Exit the application")

        case "$CHOICE" in
            "Show")
                show_history_gui
                ;;
            "Select & Copy")
                select_and_copy_from_history
                ;;
            "Clear")
                clear_history
                ;;
            "Minimize")
                # Exit the menu loop, but leave clipboard watcher running
                break
                ;;
            "Exit" | "" )
                kill $WATCHER_PID 2>/dev/null
                exit 0
                ;;
        esac
    done
}

# Start GUI menu
menu
