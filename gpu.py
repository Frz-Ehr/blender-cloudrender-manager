import bpy

def enable_gpus(device_type, use_cpus=False):
    preferences = bpy.context.preferences
    cycles_preferences = preferences.addons["cycles"].preferences
    device_info = cycles_preferences.get_devices()

    if device_info is None:
        raise RuntimeError("Failed to get device information")

    optix_devices, cuda_devices = device_info

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

try:
    enable_gpus("OPTIX")
except RuntimeError as e:
    print(str(e))
