# Fish Shell Configuration
{ config, lib, pkgs, ... }:

let
  # Shell environment variables
  envVariables = {
    STARSHIP_CONFIG = "/etc/nixos/.config/starship.toml";
    NIX_SHELLS = "/etc/nixos/shells";
    EDITOR = "nvim";
    GOPATH = "~/.go";
  };

  # List of supported languages for Nix Shells and Lorri inits
  langs =
    [ "elm" "c" "go" "rust" "node" "java" "python" "markdown" "nix" "linux" ];

  # Maps and folds `envVariables` into a String of the form
  #
  # ''
  # set -x STARSHIP_CONFIG /etc/nixos/.config/starship.toml
  # set -x NIX_SHELLS /etc/nixos/shells
  # ...
  # '';
  fish-environment-variables = with builtins;
    lib.fold (a: b: a + b) "" (attrValues (mapAttrs (variable: value: ''
      set -x ${variable} ${value}
    '') envVariables));

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
    enable = true;

    # Shell aliases
    shellAliases = {
      # Rust replacements for GNU Coreutils
      ls = "exa --icons --git";
      l = "exa --icons --git -l";
      la = "exa --icons --git -la";
      cat = "bat";
      grep = "rg";
      find = "fd";
      du = "dust";
      ps = "procs";
      top = "ytop";
      vim = "nvim";
      vi = "nvim";

      # Interactive destructive commands
      rm = "rm -i";
      cp = "cp -i";
      mv = "mv -i";

      emacs = "emacsclient";
      xclip = "xclip -selection clipboard";
      "..." = "cd ../..";

      # Nix aliases
      nix-config = "$EDITOR /etc/nixos/.";
      shell = "nix-shell --run fish";
    } // shells // inits;

    # Fish Initializing
    shellInit = ''
      ${fish-environment-variables}

      fish_vi_key_bindings
      starship init fish | source'';
  };
}
