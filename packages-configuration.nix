# Configuration file that contains packages installed for all users
#
# To search for a particular package, run:
# $ nix search ${pkg_name}
{ config, lib, pkgs, ... }:

let
  unstableTarball = fetchTarball
    "https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz";

  unstable = import unstableTarball { config = config.nixpkgs.config; };

in {
  imports = [ ./configs/fish.nix ];

  nixpkgs.config = {
    # Allow unfree software
    allowUnfree = true;

    packageOverrides = pkgs: { unstable = unstable; };
  };

  # System packages
  environment.systemPackages = with pkgs; [

    # Emacs
    ((unstable.emacsPackagesNgGen unstable.emacs).emacsWithPackages
      (epkgs: [ epkgs.vterm ]))

    # System maintenance and productivity tools
    wget
    curl
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
    unstable.lorri
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

  programs.light.enable = true;
  programs.nm-applet.enable = true;

  # Fonts
  fonts.fonts = with pkgs; [
    fira-code
    fira-code-symbols
    noto-fonts
    nerdfonts
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
    unstable.zoom-us
    libreoffice
    steam
  ];
}
