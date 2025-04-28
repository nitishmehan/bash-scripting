#!/bin/bash

# Prompt user for input
echo "Enter a color (red, yellow, green, orange):"
read color

# Convert input to lowercase (to handle case insensitivity)
color=$(echo "$color" | tr '[:upper:]' '[:lower:]')

# Switch case to determine the fruit
case "$color" in
    red | blue)
        echo "You might like Apples 🍎 or Strawberries 🍓!"
        ;;
    yellow)
        echo "You might like Bananas 🍌 or Mangoes 🥭!"
        ;;
    green)
        echo "You might like Green Grapes 🍇 or Kiwi 🥝!"
        ;;
    orange)
        echo "You might like Oranges 🍊 or Papayas!"
        ;;
    *)
        echo "Sorry, I don't know a fruit for that color! 🍍"
        ;;
esac
