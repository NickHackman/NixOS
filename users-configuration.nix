{ config, lib, pkgs, ... }:

{
  users = {
    # Fish is the Default Shell
    defaultUserShell = "/run/current-system/sw/bin/fish";

    # Users
    users.nick = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "video" "docker" "adbusers" ];
    };
  };
}
