import bpy

def get_all_devices():
    preferences = bpy.context.preferences
    cycles_preferences = preferences.addons["cycles"].preferences
    optix_devices, cuda_devices = cycles_preferences.get_devices()
    return optix_devices, cuda_devices

def enable_gpus(device_type, use_cpus=False):
    optix_devices, cuda_devices = get_all_devices()

    if device_type == "OPTIX":
        devices = optix_devices
    elif device_type == "CUDA":
        devices = cuda_devices
    else:
        raise RuntimeError("Unsupported device type")

    activated_gpus = []

    for device in devices:
        if device.type == "CPU":
            device.use = use_cpus
        else:
            device.use = True
            activated_gpus.append(device.name)

    cycles_preferences.compute_device_type = device_type
    bpy.context.scene.cycles.device = "GPU"

    return activated_gpus

# Print all available devices
optix_devices, cuda_devices = get_all_devices()
print("Available CUDA devices: ", [device.name for device in cuda_devices])
print("Available OPTIX devices: ", [device.name for device in optix_devices])

# Request user input for device type
device_type = input("Enter device type (CUDA/OPTIX): ")

# Request user input for CPU usage
use_cpu = input("Do you want to use CPUs for rendering as well? (yes/no): ")
use_cpu = use_cpu.lower() == "yes"

# Enable GPUs
activated_gpus = enable_gpus(device_type, use_cpu)

# Print activated GPUs
print("Activated GPUs: ", activated_gpus)
