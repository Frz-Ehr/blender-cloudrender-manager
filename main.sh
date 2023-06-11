#!/bin/bash
set -e
clear

# The main menu
function main_menu {
    echo "=========================================="
    echo "Welcome to the Blender Cloud Render Manager!"
    echo "=========================================="
    echo "Please select an option:"
    echo ""
    echo "1. [___Install Blender and necessary packages___]"
    echo ""
    echo "2. [______________Import / Export_______________]"
    echo ""
    echo "3. [_______________Launch Render________________]"
    echo ""
    echo "4. [____________________Exit____________________]"
}

# Loop until the user chooses to exit
while true; do
    # Display the main menu
    main_menu

    # Get the user's selection
    read -p "Enter your choice: " choice

    # Perform the chosen action
    case $choice in
        1) # Install Blender and necessary packages
            clear
            ./install.sh
            ;;
        2) # Import/Export .blend files
            clear
            ./importexport.sh
            ;;
        3) # Launch Render
            clear
            ./render.sh
            ;;
        4) # Exit
            echo "Exiting..."
            exit 0
            ;;
        *) # Invalid choice
            echo "Invalid choice, please try again."
            ;;
    esac

    # Wait for the user to press enter before showing the menu again
    read -p "Press enter to continue..."
done
