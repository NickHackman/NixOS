# Configuration file that contains packages installed for all users
#
# To search for a particular package, run:
# $ nix search ${pkg_name}
{ config, lib, pkgs, ... }:

{
  imports = [ ./configs/fish.nix ];

  nixpkgs.config = {
    # Allow unfree software
    allowUnfree = true;

    # Package Overrides
    packageOverrides = pkgs: {
      emacs = pkgs.emacs.override {
        withGTK3 = true;
        withGTK2 = false;
      };
    };
  };

  # System packages
  environment.systemPackages = with pkgs; [

    # System maintenance and productivity tools
    wget
    curl
    emacs
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

    # Networking
    networkmanager
    networkmanagerapplet
    networkmanager-openconnect

    # NixOS maintenance
    nixfmt

    # Stylized customization applications
    starship
    neofetch

    # Shells
    zsh
    fish
    shellcheck

    # Graphical applications
    kitty
    google-chrome

    # Programming
    gnumake

    # Markdown
    pandoc
    nodePackages.prettier

    # Ruby
    ruby
    rubocop

    # Rust
    rustup

    # Python
    (python3.withPackages
      (ps: with ps; [ black flake8 mypy python-language-server isort ]))

    # Golang
    go
    golangci-lint
    goimports
    gocode
    gotests

    # C/C++
    gcc
    pkg-config
    ccls
    clang
  ];

  programs.zsh.enable = true;
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
