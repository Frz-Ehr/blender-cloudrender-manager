#!/bin/bash
set -e
clear

# The main menu
function main_menu {
    echo "=========================================="
    echo "Welcome to the Mega file management!"
    echo "=========================================="
    echo "Please select an option:"
    echo "1. Import .blend or .zip files from Mega"
    echo "2. Export rendered files to Mega"
    echo "3. Change Mega ID/password"
    echo "4. Reinstall Mega"
    echo "5. Exit"
}

# Import function
function import_files {
    echo "Please enter the Mega URL of the file you want to import:"
    read mega_url
    megadl $mega_url

    # Get the filename from the Mega URL
    filename=$(basename $mega_url)

    # If the file is a .zip file, unzip it, move the contents to the media directory, and delete the original .zip file
    if [[ $filename == *.zip ]]; then
        unzip $filename -d blender-3.5.1-linux-x64/media
        rm $filename
    # If the file is a .blend file, move it to the media directory
    elif [[ $filename == *.blend ]]; then
        mv $filename blender-3.5.1-linux-x64/media
    else
        echo "File type not supported. Please import either .blend or .zip files."
    fi
}

# Export function
function export_files {
    echo "Exporting rendered files to Mega..."
    megaput --path /Root blender-3.5.1-linux-x64/output/*
}

# Change Mega ID/password function
function change_mega_credentials {
    nano ~/.megarc
}

# Change Mega ID/password function
function reinstall_mega {
    sudo apt-get install -y megatools
    echo "Megatools installed successfully"
    echo "Please enter your Mega email:"
    read email
    echo "Please enter your Mega password:"
    read -s password
    echo -e "[Login]\nUsername = $email\nPassword = $password" > ~/.megarc
    chmod 600 ~/.megarc
    echo "Mega credentials stored successfully"
    clear
}

# Main loop
while true; do
    # Display the main menu
    main_menu

    # Get the user's selection
    read -p "Enter your choice: " choice

    # Perform the chosen action
    case $choice in
        1) # Import
            import_files
            ;;
        2) # Export
            export_files
            ;;
        3) # Change Mega ID/password
            change_mega_credentials
            ;;
        4) # Reinstall Mega
            reinstall_mega
            exit 0
            ;;
        5) # Exit
            echo "Exiting..."
            ./main.sh
            ;;
        *) # Invalid choice
            echo "Invalid choice, please try again."
            ;;
    esac

    # Wait for the user to press enter before showing the menu again
    read -p "Press enter to continue..."
done
