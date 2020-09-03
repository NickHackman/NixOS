# Fish Shell Configuration
{ config, lib, pkgs, ... }:

let
  environment-variables = ''
    set -x STARSHIP_CONFIG /etc/nixos/configs/starship.toml
    set -x GOPATH ~/.go'';
in {
  programs.fish = {

    # Shell aliases
    shellAliases = {
      ls = "exa --icons --git";
      l = "exa --icons --git -l";
      la = "exa --icons --git -la";
      cat = "bat";
      grep = "rg";
      du = "dust";
      rm = "rm -i";
      cp = "cp -i";
      mv = "mv -i";
      ps = "procs";
      top = "ytop";
      shell = "nix-shell --run fish";
      nix-shell = "nix-shell /etc/nixos/shells/nix-shell.nix";
      c-shell = "nix-shell  /etc/nixos/shells/c-shell.nix";
      python-shell = "nix-shell /etc/nixos/shells/python-shell.nix";
      markdown-shell = "nix-shell /etc/nixos/shells/markdown-shell.nix";
      rust-shell = "nix-shell /etc/nixos/shells/rust-shell.nix";
      emacs = "emacsclient";
      xclip = "xclip -selection clipboard";
      "..." = "cd ../..";
      nix-config = "$EDITOR /etc/nixos/.";
    };

    # Fish Initializing
    shellInit = ''
      ${environment-variables}

      fish_vi_key_bindings
      starship init fish | source'';
  };
}