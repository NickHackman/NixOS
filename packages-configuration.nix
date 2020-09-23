# Configuration file that contains packages installed for all users
#
# To search for a particular package, run:
# $ nix search ${pkg_name}
{ config, lib, pkgs, ... }:

let unstable = import <nixos-unstable> { };

in {
  imports = [ ./configs/fish.nix ];

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = with pkgs; [

    # System maintenance and productivity tools
    wget
    curl

    # Emacs
    ((unstable.emacsPackagesNgGen unstable.emacs).emacsWithPackages
      (epkgs: [ epkgs.vterm ]))

    vim
    bat
    fd
    exa
    ripgrep
    git
    unstable.gitAndTools.gh
    ytop
    zip
    unzip
    unstable.tokei
    du-dust
    hyperfine
    tealdeer
    killall
    xclip
    procs
    jq
    acpi
    which
    starship
    neofetch
    fish

    # Networking
    networkmanager
    networkmanagerapplet
    networkmanager-openconnect

    # Development
    direnv
    lorri
    docker
    docker-compose

    # Bspwm
    kitty
    google-chrome
    feh
    scrot
    xbindkeys
    playerctl
    numix-cursor-theme
    papirus-icon-theme
    unstable.rofi
    polybar
  ];

  programs.fish.enable = true;
  programs.light.enable = true;
  programs.nm-applet.enable = true;

  # Fonts
  fonts.fonts = with pkgs; [
    fira-code
    fira-code-symbols
    noto-fonts
    noto-fonts-emoji
    fantasque-sans-mono
    hack-font
    font-awesome_5
  ];

  # Nick's packages
  users.extraUsers.nick.packages = with pkgs; [

    # Applications
    discord
    dmenu
    gimp
    slack
    spotify
    lxappearance
    tdesktop # telegram-desktop
    zoom-us
    libreoffice
    steam
  ];
}
