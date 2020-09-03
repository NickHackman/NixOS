# Fish Shell Configuration
{ config, lib, pkgs, ... }:

let
  environment-variables = ''
    set -x STARSHIP_CONFIG /etc/nixos/configs/starship.toml
    set -x NIX_SHELLS /etc/nixos/shells
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
      emacs = "emacsclient";
      xclip = "xclip -selection clipboard";
      "..." = "cd ../..";

      nix-config = "$EDITOR /etc/nixos/.";

      # Base language shells
      shell = "nix-shell --run fish";
      nix-shell = "nix-shell $NIX_SHELLS/nix-shell.nix";
      c-shell = "nix-shell  $NIX_SHELLS/c-shell.nix";
      python-shell = "nix-shell $NIX_SHELLS/python-shell.nix";
      markdown-shell = "nix-shell $NIX_SHELLS/markdown-shell.nix";
      rust-shell = "nix-shell $NIX_SHELLS/rust-shell.nix";

      # Lorri project init
      c-init = "cp $NIX_SHELLS/c-shell.nix ./shell.nix; lorri init";
      rust-init = "cp $NIX_SHELLS/rust-shell.nix ./shell.nix; lorri init";
      python-init = "cp $NIX_SHELLS/python-shell.nix ./shell.nix; lorri init";
      nix-init = "cp $NIX_SHELLS/nix-shell.nix ./shell.nix; lorri init";
      markdown-init =
        "cp $NIX_SHELLS/markdown-shell.nix ./shell.nix; lorri init";
    };

    # Fish Initializing
    shellInit = ''
      ${environment-variables}

      fish_vi_key_bindings
      starship init fish | source'';
  };
}
