#!/bin/bash
set -e

# Update the system and install necessary packages
sudo apt-get update
sudo apt-get install -y vim netcat curl libglu1-mesa-dev libxi6 libxrender1 libfontconfig1 libxxf86vm-dev libxfixes-dev libgl1-mesa-glx xz-utils nvidia-cuda-toolkit nano

# Download and extract Blender
curl -OL https://download.blender.org/release/Blender3.5/blender-3.5.1-linux-x64.tar.xz
unxz blender-3.5.1-linux-x64.tar.xz
tar -xvf blender-3.5.1-linux-x64.tar

# Create necessary directories
cd blender-3.5.1-linux-x64
mkdir media output

# Create gpu.py
echo "import bpy
scene = bpy.context.scene
scene.cycles.device = 'OPTIX'
prefs = bpy.context.preferences
cprefs = prefs.addons['cycles'].preferences
cprefs.compute_device_type = 'OPTIX'
for device in cprefs.devices:
    if device.type == 'OPTIX':
        device.use = True" > gpu.py

clear
# Ask the user if they want to install and use Mega
read -p "Do you want to install and use Mega for importing .blend files? (y/n): " use_mega
if [[ $use_mega == "y" ]]; then
    sudo apt-get install -y megatools
    echo "Megatools installed successfully"
    echo " ! USE A DEDICATED MEGA ACCOUNT. FOR SECURITY REASONS, DO NOT USE YOUR PERSONAL ACCOUNT ! "
    echo "Please enter your Mega email:"
    read email
    echo "Please enter your Mega password:"
    read -s password
    echo -e "[Login]\nUsername = $email\nPassword = $password" > ~/.megarc
    chmod 600 ~/.megarc
    echo "Mega credentials stored successfully"

    clear
    echo "Installation complete! If you want to import your .blend files via Mega : run import script, if not, import your .blend files in blender-3.5.1-linux-x64/media directory."
    ./main.sh
else
    clear
    echo "Installation complete! You chose not to install Google Drive. Please import your .blend files in blender-3.5.1-linux-x64/media directory."
    ./main.sh
fi
