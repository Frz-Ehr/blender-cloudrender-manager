#!/bin/bash
set -e

# Update the system and install necessary packages
sudo apt-get update
sudo apt-get install -y vim netcat curl libglu1-mesa-dev libxi6 libxrender1 libfontconfig1 libxxf86vm-dev libxfixes-dev libgl1-mesa-glx xz-utils nvidia-cuda-toolkit

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

# Ask the user if they want to install and use Google Drive
read -p "Do you want to install and use Google Drive for importing .blend files? (y/n): " use_gdrive
if [[ $use_gdrive == "y" ]]; then
    # Install gdrive
    cd ~  
    wget https://docs.google.com/uc?id=0B3X9GlR6EmbnWksyTEtCM0VfaFE&export=download  
    mv uc?id=0B3X9GlR6EmbnWksyTEtCM0VfaFE gdrive  
    chmod +x gdrive  
    sudo install gdrive /usr/local/bin/gdrive  

    # Connect gdrive
    echo "Please authenticate gdrive by following the instructions in the terminal. I RECOMMEND LOGGING IN WITH A DEDICATED GOOGLE ACCOUNT. FOR SECURITY REASONS, DO NOT USE YOUR PERSONAL GOOGLE ACCOUNT."
    gdrive list

    echo "Installation complete! If you want to import your .blend files via Google Drive : run ggimport.sh, if not, import your .blend files in blender-3.5.1-linux-x64/media directory."
else
    echo "Installation complete! You chose not to install Google Drive. Please import your .blend files in blender-3.5.1-linux-x64/media directory."
fi