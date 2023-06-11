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
    echo "1. [___Generate SCP command to import .blend files____]"
    echo ""
    echo "2. [___Generate SCP command to export rendered files__]"
    echo ""
    echo "3. [_________Check media and output directory_________]"
    echo ""
    echo "4. [_______________Return to main menu________________]"
    echo ""
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
            echo "Please enter the username of this remote machine:"
            read remote_user
            echo "Please enter the full path to the .blend / .zip file on your local machine:"
            read remote_path
            echo "Please enter the SSH port of this remote machine:"
            read remote_port
            echo "If you import a zip file : select the option [Check media and output directory]:"
            echo "Here is your SCP command" 
            echo "scp -P $remote_port -v $remote_path $remote_user@$ip:blender-cloudrender-manager/blender-3.5.1-linux-x64/media/"
            ;;
        2) # Generate SCP command to export rendered files
            clear
            echo "Please enter the username of this remote machine:"
            read remote_user
            echo "Please enter the full path to the directory where you want to store the rendered files on your local machine:"
            read remote_path
            echo "Please enter the SSH port of this remote machine:"
            read remote_port
            echo "Here is your SCP command, :"
            echo "scp -P $remote_port -v '$remote_user@$ip:blender-cloudrender-manager/blender-3.5.1-linux-x64/output/*' $remote_path"
            ;;
        3) # Check .blend files
            clear
            echo "Select which directory to check:"
            echo "1. media"
            echo "2. output"
            read dir_choice
            if [ "$dir_choice" == "1" ]; then
                for file in ./blender-3.5.1-linux-x64/media/*.zip; do
                   if [ -f "$file" ]; then
                        unzip "$file" -d ./blender-3.5.1-linux-x64/media/
                        rm "$file"
                   fi
                done
                echo "Content of the media directory:"
                ls ./blender-3.5.1-linux-x64/media/
            elif [ "$dir_choice" == "2" ]; then
                echo "Content of the output directory:"
                ls ./blender-3.5.1-linux-x64/output/
            else
                echo "Invalid choice, please try again."
            fi
            ;;
        4) # Return to main menu
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
