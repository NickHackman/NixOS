# Configuration file that contains boot configuration
{ config, lib, pkgs, ... }:

{
  boot = {

    # Linux Kernel Parameters
    #
    # Dell XPS 13 (7390) requires "i915.enable_psr=0" otherwise the screen will get random graphical
    # glitches that freeze the screen after extended use.
    kernelParams = [ "i915.enable_psr=0" "quiet" "splash" ];

    loader = {
      # EFI Support
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };

      # Systemd-boot and Grub configuration
      systemd-boot.enable = true;
      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        efiSupport = true;
        enableCryptodisk = true;
        configurationLimit = 30;
        copyKernels = true;
      };
    };

    # LUKS configuration
    initrd.luks.devices = {
      root = {
        device =
          "/dev/disk/by-uuid/8b805b0b-110a-42a0-bcf4-443855b7455d"; # uuid of device that contains LUKS volumes
        preLVM = true;
        allowDiscards = true;
      };
    };
  };
}
