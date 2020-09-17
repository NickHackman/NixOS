# Configuration file that contains system services and Xorg configuration
{ config, lib, pkgs, ... }:

let unstable = import <nixos-unstable> { };

in {
  services = {

    # Xorg Configuration
    xserver = {

      # Base configuration
      enable = true;
      layout = "us";
      libinput.enable = true;
      displayManager.defaultSession = "none+bspwm";

      # Switch capslock and escape
      xkbOptions = "caps:swapescape";

      # Desktop Environments and Window Managers
      windowManager.bspwm = {
        enable = true;
        configFile = "/etc/nixos/configs/bspwmrc.sh";
        sxhkd.configFile = "/etc/nixos/configs/sxhkdrc.sh";
      };
    };

    # Services
    openssh.enable = true;
    printing.enable = true;
    blueman.enable = true;

    # Emacs
    emacs = {
      defaultEditor = true;
      enable = true;
      package = unstable.emacs;
    };

    lorri.enable = true;

    logind.extraConfig = "IdleAction=lock";

    redshift.enable = true;
    geoclue2.enable = true;
  };

  # Automatic upgrading
  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-20.03";
  };

  # Automatic system cleaning
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  powerManagement.powertop.enable = true;

  location.provider = "geoclue2";
  sound.enable = true;

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  virtualisation.docker.enable = true;
}
