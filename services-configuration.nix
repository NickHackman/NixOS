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
        configFile = "/home/nick/.config/bspwm/bspwmrc";
        sxhkd.configFile = "/home/nick/.config/sxhkd/sxhkdrc";
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

    # Logind
    logind.extraConfig = "IdleAction=lock";

    # Redshift
    redshift.enable = true;

    geoclue2.enable = true;
  };

  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-20.03";
  };

  location.provider = "geoclue2";

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  virtualisation.docker.enable = true;
}
