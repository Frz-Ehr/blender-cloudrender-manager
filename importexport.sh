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
    echo ""
    echo "1. [______Generate SCP command to import .blend files_______]"
    echo ""
    echo "2. [______Generate SCP command to export rendered files_____]"
    echo ""
    echo "3. [_____Check media/output directory & Unzip .zip files____]"
    echo ""
    echo "4. [______________Change remote user or port________________]"
    echo ""
    echo "5. [__________________Return to main menu___________________]"
    echo ""
    
}

# Function to generate SCP command to import .blend files
function generate_import_command {
    clear
    # Get the remote user and port from the config file
    remote_user=$(cat ./config | grep remote_user | cut -d'=' -f2)
    remote_port=$(cat ./config | grep remote_port | cut -d'=' -f2)
    echo "Please enter the full path to the .blend file(s) on your local machine:"
    read remote_path
    echo "Here is your SCP command:"
    echo "scp -P $remote_port -v $remote_path $remote_user@$ip:blender-cloudrender-manager/blender-3.6.0-linux-x64/media/"
    # Wait for the user to press enter before showing the menu again
    read -p "Press enter to continue..."
}

# Function to generate SCP command to export rendered files
function generate_export_command {
    clear
    # Get the remote user and port from the config file
    remote_user=$(cat ./config | grep remote_user | cut -d'=' -f2)
    remote_port=$(cat ./config | grep remote_port | cut -d'=' -f2)
    echo "Please enter the full path to the directory where you want to store the rendered files on your local machine:"
    read remote_path
    echo "Here is your SCP command:"
    echo "scp -P $remote_port -v '$remote_user@$ip:blender-cloudrender-manager/blender-3.6.0-linux-x64/output/*' $remote_path"
    # Wait for the user to press enter before showing the menu again
    read -p "Press enter to continue..."
}

# Function to change the remote user or port
function change_remote_user_or_port {
    echo "Please enter the new remote username:"
    read remote_user
    echo "Please enter the new SSH port:"
    read remote_port
    echo "remote_user=$remote_user" > ./config
    echo "remote_port=$remote_port" >> ./config
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
            generate_import_command
            ;;
        2) # Generate SCP command to export rendered files
            generate_export_command
            ;;
        3) # Check .blend files / Unzip .zip files
            clear
            echo "Select which directory to check:"
            echo "1. media"
            echo "2. output"
            read dir_choice
            if [ "$dir_choice" == "1" ]; then
                for file in ./blender-3.6.0-linux-x64/media/*.zip; do
                   if [ -f "$file" ]; then
                        unzip "$file" -d ./blender-3.6.0-linux-x64/media/
                        rm "$file"
                   fi
                done
                echo "Content of the media directory:"
                ls ./blender-3.6.0-linux-x64/media/
            elif [ "$dir_choice" == "2" ]; then
                echo "Content of the output directory:"
                ls ./blender-3.6.0-linux-x64/output/
            else
                echo "Invalid choice, please try again."
            fi
            ;;
        4) # Change remote user or port
            change_remote_user_or_port
            ;;
        5) # Return to main menu
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
