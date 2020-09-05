# Configuration file that contains packages installed for all users
#
# To search for a particular package, run:
# $ nix search ${pkg_name}
{ config, lib, pkgs, ... }:

let
  unstableTarball = (builtins.fetchTarball {
    url =
      "https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz";
  });

in {
  imports = [ ./configs/fish.nix ];

  nixpkgs.config = {
    # Allow unfree software
    allowUnfree = true;

    # Package Overrides
    packageOverrides = pkgs: {
      unstable = import unstableTarball { config = config.nixpkgs.config; };
    };
  };

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
    ytop
    zip
    unzip
    tokei
    du-dust
    hyperfine
    tealdeer
    killall
    xclip
    procs
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

    # Graphical applications
    kitty
    google-chrome

    # Golang
    go
    golangci-lint
    goimports
    gocode
    gotests
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

    # X11 Keybinds
    xbindkeys
    playerctl

    # Themes
    numix-cursor-theme
    papirus-icon-theme
    lxappearance

    # Applications
    discord
    dmenu
    gimp
    rofi
    slack
    spotify
    tdesktop # telegram-desktop
    zoom-us
    polybar
    libreoffice
    steam
  ];
}
