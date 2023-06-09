#!/bin/bash
set -e
clear

# The main menu
function main_menu {
    echo "=========================================="
    echo "Welcome to the Blender Cloud Render Manager!"
    echo "=========================================="
    echo "Please select an option:"
    echo "1. Install Blender and necessary packages"
    echo "2. Import .blend files from Mega"
    echo "3. Launch Render"
    echo "4. Export rendered files to Mega"
    echo "5. Exit"
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
        2) # Import .blend files from Google Drive
            clear
            ./import.sh
            ;;
        3) # Launch Render
            clear
            ./render.sh
            ;;
        4) # Export rendered files to Google Drive
            clear
            ./export.sh
            ;;
        5) # Exit
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
