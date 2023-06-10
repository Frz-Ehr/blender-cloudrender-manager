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

# Import gpu.py
mv /root/blender-cloudrender-manager/gpu.py /root/blender-cloudrender-manager/blender-3.5.1-linux-x64/gpu.py

clear
echo "Installation complete! You can now import your .blend files (don't forget to pack external data or import a .zip file)"
cd ..
./main.sh
fi
