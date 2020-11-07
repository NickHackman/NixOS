# Configuration file that contains packages installed for all users
#
# To search for a particular package, run:
# $ nix search ${pkg_name}
{ config, lib, pkgs, ... }:

let
  unstableTarball = fetchTarball
    "https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz";

  unstable = import unstableTarball { config = config.nixpkgs.config; };

  unstableChan = import <nixos-unstable> {};

in {
  imports = [ ./.config/fish.nix ];

  nixpkgs.config = {
    # Allow unfree software
    allowUnfree = true;

    packageOverrides = pkgs: { unstable = unstable; };
  };

  # System packages
  environment.systemPackages = with pkgs; [
    neovim
    nodejs

    # System maintenance and productivity tools
    wget
    curl
    bat
    fd
    exa
    ripgrep
    git
    unstable.gitAndTools.gh
    # HACK: unable to reference bottom with the unstable tarball, but from the channel
    unstableChan.bottom
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
    go
    tmux
    gnumake
    gcc
    pkg-config
    ccls
    clang
    cmake
    pandoc
    nodePackages.prettier
    pipenv
    (unstable.python3.withPackages
      (ps: with ps; [ flake8 mypy python-language-server isort black jedi]))
    openjdk11
    gradle
    nixfmt
    nodePackages.vim-language-server
    clang-tools
    thefuck

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
