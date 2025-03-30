#!/bin/bash

# Define color codes
BLUE='\033[1;34m'  # Bold Blue
NC='\033[0m'        # No Color (reset)

# Read words into an array from Categories.txt
mapfile -t WORDS < Categories.txt

# Display available categories
echo -e "Select an option:"
for i in "${!WORDS[@]}"; do
    echo -e "${BLUE}$((i + 1)). ${WORDS[i]}${NC}"
done

# Loop until a valid choice is entered
while true; do
    read -p "Enter the number of your choice: " CHOICE

    # Check if input is a valid number and within range
    if [[ "$CHOICE" =~ ^[0-9]+$ ]] && (( CHOICE > 0 && CHOICE <= ${#WORDS[@]} )); then
        SELECTED_WORD=${WORDS[$((CHOICE - 1))]}
        echo -e "\nYou selected: ${BLUE}$SELECTED_WORD${NC}"
        
        # Run the Makefile command with the selected category
        echo -e "\nRunning: ${BLUE}make -f Make_Dataset CATEGORY=${SELECTED_WORD}${NC}"
        make -f Make_Dataset CATEGORY="$SELECTED_WORD"
        
        break  # Exit loop on valid selection
    else
        echo -e "\n${BLUE}Invalid choice! Please enter a valid number.${NC}"
    fi
done
