# Fish Shell Configuration
{ config, lib, pkgs, ... }:

let
  environment-variables = ''
    set -x STARSHIP_CONFIG /etc/nixos/configs/starship.toml
    set -x NIX_SHELLS /etc/nixos/shells
    set -x GOPATH ~/.go'';

  shell = lang: "nix-shell $NIX_SHELLS/${lang}-shell.nix";

  init = lang: "cp $NIX_SHELLS/${lang}-shell.nix ./shell.nix; lorri init";

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

      # Language shells
      shell = "nix-shell --run fish";
      nix-shell = shell "nix";
      c-shell = shell "c";
      go-shell = shell "go";
      linux-shell = shell "linux";
      python-shell = shell "python";
      markdown-shell = shell "markdown";
      rust-shell = shell "rust";
      node-shell = shell "node";

      # Lorri project init
      nix-init = init "nix";
      c-init = init "c";
      go-init = init "go";
      linux-init = init "linux";
      python-init = init "python";
      markdown-init = init "markdown";
      rust-init = init "rust";
      node-init = init "node";
    };

    # Fish Initializing
    shellInit = ''
      ${environment-variables}

      fish_vi_key_bindings
      starship init fish | source'';
  };
}
