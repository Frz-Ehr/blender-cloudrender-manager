#!/bin/bash
set -e

# Ask the user if they want to export files to Google Drive
read -p "Do you want to export rendered files to Google Drive? (y/n): " use_gdrive
if [[ $use_gdrive == "y" ]]; then
    # Change to the directory containing the files to be exported
    cd ~/blender-3.5.1-linux-x64/output

    # Iterate over each file in the directory
    for file in *; do
        # Check if the file is a regular file (not a directory or link)
        if [[ -f $file ]]; then
            # Upload the file to Google Drive
            echo "Uploading $file to Google Drive..."
            gdrive upload $file
        fi
    done
    echo "All files have been uploaded to Google Drive."
else
    echo "You chose not to export files to Google Drive."
fi
