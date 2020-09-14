# Fish Shell Configuration
{ config, lib, pkgs, ... }:

let
  environment-variables = ''
    set -x STARSHIP_CONFIG /etc/nixos/configs/starship.toml
    set -x NIX_SHELLS /etc/nixos/shells
    set -x GOPATH ~/.go'';

  # List of supported languages for Nix Shells and Lorri inits
  langs =
    [ "elm" "c" "go" "rust" "node" "java" "python" "markdown" "nix" "linux" ];

  # Maps `langs` to a Set of keys where each is of the form
  # "${lang}-shell" = "nix-shell $NIX_SHELLS/${lang}-shell.nix".
  #
  # Example:
  #
  # {
  #   c-shell = "nix-shell $NIX_SHELLS/c-shell.nix";
  #   go-shell = "nix-shell $NIX_SHELLS/go-shell.nix";
  #   ...
  # }
  shells = builtins.listToAttrs (map (lang: {
    name = "${lang}-shell";
    value = "nix-shell $NIX_SHELLS/${lang}-shell.nix";
  }) langs);

  # Maps `langs` to a Set of where each is of the form
  # "${lang}-init" = "cp $NIX_SHELLS/${lang}-shell.nix ./shell.nix; lorri init".
  #
  # Example:
  #
  # {
  #   c-init = "cp $NIX_SHELLS/c-shell.nix ./shell.nix; lorri init";
  #   go-init = "cp $NIX_SHELLS/go-shell.nix ./shell.nix; lorri init";
  #   ...
  # }
  inits = builtins.listToAttrs (map (lang: {
    name = "${lang}-init";
    value = "cp $NIX_SHELLS/${lang}-shell.nix ./shell.nix; lorri init";
  }) langs);

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

      # Nix aliases
      nix-config = "$EDITOR /etc/nixos/.";
      shell = "nix-shell --run fish";
    } // shells // inits;

    # Fish Initializing
    shellInit = ''
      ${environment-variables}

      fish_vi_key_bindings
      starship init fish | source'';
  };
}
