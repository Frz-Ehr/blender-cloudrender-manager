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
echo "
import bpy

# Trigger GPU device detection
bpy.context.preferences.addons['cycles'].preferences.get_devices()

# Print the compute device type
print(bpy.context.preferences.addons['cycles'].preferences.compute_device_type)

# Set all detected devices to be used
for device in bpy.context.preferences.addons['cycles'].preferences.devices:
    device['use'] = 1
    print(device['name'], device['use'])

# Set the render engine to CYCLES and the device to GPU
bpy.context.scene.render.engine = 'CYCLES'
bpy.context.scene.cycles.device = 'GPU'
" > gpu.py

clear
echo "Installation complete! You can now import your .blend files (don't forget to pack external data or import a .zip file)"
cd ..
./main.sh
fi
