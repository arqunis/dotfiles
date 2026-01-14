{ config, lib, ... }:
{
  options.hardware.isGpuAMD = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Sets graphics options for AMD GPUs";
  };

  config = {
    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true;
    hardware.amdgpu.initrd.enable = config.hardware.isGpuAMD;
  };
}
