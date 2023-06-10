#!/bin/bash
set -e
clear

# Get the IP address of this instance
ip=$(curl -s http://checkip.amazonaws.com/)

# The main menu
function main_menu {
    echo "=========================================="
    echo "Welcome to the Blender Cloud Render Manager!"
    echo "=========================================="
    echo "Please select an option:"
    echo "1. Generate SCP command to import .blend files"
    echo "2. Generate SCP command to export rendered files"
    echo "3. Return to main menu"
}

# Loop until the user chooses to return to main menu
while true; do
    # Display the main menu
    main_menu

    # Get the user's selection
    read -p "Enter your choice: " choice

    # Perform the chosen action
    case $choice in
        1) # Generate SCP command to import .blend files
            clear
            echo "Please enter the username on the remote machine:"
            read remote_user
            echo "Please enter the full path to the .blend file(s) on the remote machine:"
            read remote_path
            echo "Here is your SCP command:"
            echo "scp $remote_user@$ip:$remote_path ./blender-3.5.1-linux-x64/media/"
            ;;
        2) # Generate SCP command to export rendered files
            clear
            echo "Please enter the username on the remote machine:"
            read remote_user
            echo "Please enter the full path to the directory where you want to store the rendered files on the remote machine:"
            read remote_path
            echo "Here is your SCP command:"
            echo "scp ./blender-3.5.1-linux-x64/output/* $remote_user@$ip:$remote_path"
            ;;
        3) # Return to main menu
            echo "Returning to main menu..."
            ./main.sh
            ;;
        *) # Invalid choice
            echo "Invalid choice, please try again."
            ;;
    esac

    # Wait for the user to press enter before showing the menu again
    read -p "Press enter to continue..."
done
