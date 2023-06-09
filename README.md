# Blender Cloud Rendering Automation

This repository contains a set of Bash scripts that automate the process of setting up a Blender rendering environment optimized for RTX GPUs (rendered with OPTIX) on a cloud-based instance. It provides options for importing and exporting .blend files using Mega, as well as rendering the .blend files on the instance. This can be particularly useful for 3D artists looking to leverage the power of cloud computing for their rendering needs.

## Installation on a cloud-based instance

To use these scripts on a cloud-based instance, you first need to install Git on your instance. Here's how you can do this on a Ubuntu-based instance:

1. Update the package list:

```bash
sudo apt-get update
```

2. Install Git:

```bash
sudo apt-get install git
```

3. Verify the installation:

```bash
git --version
```

After Git is installed, you can clone this repository to your instance using the following command:

```bash
git clone https://github.com/Frz-Ehr/blender-cloudrender-manager.git
```

After cloning, navigate into the directory of the repository:

```bash
cd blender-cloudrender-manager
```

And run the main script to start the setup:

```bash
chmod +x *.sh
./main.sh
```
