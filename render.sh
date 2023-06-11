#!/bin/bash
set -e

cd blender-3.5.1-linux-x64

# Check for .blend files and prompt user to select one
while true; do
    echo "Checking for .blend files..."
    blend_files=$(ls media/*.blend 2> /dev/null)
    if [[ -z "$blend_files" ]]; then
        echo "No .blend files found in media/ directory. Will check again in 5 seconds. Import your .blend files via SSH or Mega"
        sleep 5
        continue
    fi

    echo "Found the following .blend files:"
    i=1
    for file in $blend_files; do
        echo "$i: $file"
        ((i++))
    done

    read -p "Please enter the number of the .blend file you want to render: " blend_file_number
    blend_file=$(sed "${blend_file_number}q;d" <<< "$blend_files")
    if [[ ! -f "$blend_file" ]]; then
        echo "File not found: $blend_file. Please make sure you entered the correct file number."
        continue
    fi

    # Ask user for the render type
    read -p "Enter 1 for image render, 2 for video render: " render_type

    # Ask user for the device type
    echo "Enter 1 to use CUDA, 2 to use OptiX"
    read -p "Please enter the number of the device type you want to use for rendering: " device_type

    if [[ $device_type -eq 1 ]]; then
        device_flag="CUDA"
    elif [[ $device_type -eq 2 ]]; then
        device_flag="OPTIX"
    else
        echo "Invalid device type entered. Please enter 1 to use CUDA, 2 to use OptiX."
        continue
    fi

    if [[ $render_type -eq 1 ]]; then
        # Ask user for the frame to render
        read -p "Please enter the frame number you want to render: " frame_number

        # Start rendering
        echo "Rendering frame $frame_number using $device_flag..."
        ./blender -b $blend_file -E CYCLES -o output/ -f $frame_number -- --cycles-device $device_flag
    elif [[ $render_type -eq 2 ]]; then
        echo "Rendering animation using $device_flag..."
        ./blender -b $blend_file -E CYCLES -o output/ -a -- --cycles-device $device_flag
    else
        echo "Invalid render type entered. Please enter 1 for image render, 2 for video render."
        continue
    fi

    echo "Rendering complete. The output can be found in the output/ directory."
    cd ..
    ./main.sh
done
