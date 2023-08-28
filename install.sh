#!/bin/bash
set -e

# Update the system and install necessary packages
sudo apt-get update
sudo apt-get install -y vim netcat curl libglu1-mesa-dev libxi6 libxrender1 libfontconfig1 libxxf86vm-dev libxfixes-dev libgl1-mesa-glx xz-utils unzip nvidia-cuda-toolkit nano

# Download and extract Blender
curl -OL https://ftp.halifax.rwth-aachen.de/blender/release/Blender3.6/blender-3.6.0-linux-x64.tar.xz
unxz blender-3.6.0-linux-x64.tar.xz
tar -xvf blender-3.6.0-linux-x64.tar

# Create necessary directories
cd blender-3.6.0-linux-x64
mkdir media output

clear
echo "Installation complete! You can now import your .blend files (don't forget to pack external data or import a .zip file)"
# Get the remote user and port
echo "Information required to generate import and export commands via ssh : "
read -p "Please enter the username of this remote machine: " remote_user
read -p "Please enter the SSH port of this remote machine: " remote_port

# Create the config.sh file
echo '#!/bin/bash' > ./config
echo "export REMOTE_USER=\"$remote_user\"" >> ./config
echo "export REMOTE_PORT=\"$remote_port\"" >> ./config
cd ..
./main.sh
