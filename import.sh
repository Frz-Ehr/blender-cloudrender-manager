#!/bin/bash
set -e

# List the available files in Google Drive
echo "Listing available files in Google Drive:"
gdrive_list_output=$(gdrive list)

# Create an array to store file IDs
file_ids=()
file_names=()

# Read each line of the output from `gdrive list`
while IFS= read -r line; do
    if [[ $line != "Id"* ]]; then  # Ignore the header
        file_id=$(echo $line | awk '{print $1}')  # Extract the first field (Id)
        file_name=$(echo $line | awk '{$1=""; print $0}')  # Extract everything but the first field (file name)
        file_ids+=($file_id)
        file_names+=("$file_name")
    fi
done <<< "$gdrive_list_output"

# Display each file with a number
for i in "${!file_names[@]}"; do
    echo "$((i+1)). ${file_names[$i]}"
done

# Ask the user to select a file
read -p "Select the number of the file to import: " file_num
file_id=${file_ids[$((file_num-1))]}
file_name=${file_names[$((file_num-1))]}

# Download the file to the current directory
gdrive download $file_id

# Check that the file has been downloaded
if [ -f "$file_name" ]; then
    echo "File $file_name has been successfully imported."
    # Check if the file is a .zip file
    if [[ $file_name == *.zip ]]; then
        echo "Unzipping $file_name..."
        unzip -d ./media/ $file_name
        echo "$file_name has been unzipped into ./media/"
        echo "Deleting $file_name..."
        rm $file_name
    elif [[ $file_name == *.blend ]]; then
        mv $file_name ./media/
        echo "$file_name has been moved to ./media/"
    else
        echo "File $file_name is not a .blend or .zip file."
    fi
else
    echo "An error occurred while importing the file."
fi
