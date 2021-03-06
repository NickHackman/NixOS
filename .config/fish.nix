# Fish Shell Configuration
{ config, lib, pkgs, ... }:

let
  # Shell environment variables
  envVariables = {
    STARSHIP_CONFIG = "/etc/nixos/.config/starship.toml";
    NIX_SHELLS = "/etc/nixos/shells";
    EDITOR = "nvim";
  };

  # Colorscheme for Fish modeled after Vim One Dark
  #
  # https://github.com/joshdick/onedark.vim#color-reference
  colorscheme = {
    fish_color_normal = "#282C34";
    fish_color_command = "#61AFEF";
    fish_color_error = "#E06C75";
    fish_color_comment = "#ABB2BF";
    fish_color_quote = "#98C379";
    fish_color_end = "#C678DD";
    fish_color_param = "#56B6C2";
    fish_color_redirection = "#E5C07B";
  };

  # Maps and folds `colorscheme` into a String of the form
  #
  # ''
  # set -U fish_color_normal 282C34
  # set -U fish_color_command 61AFEF
  # set -U fish_color_error E06C75
  # set -U fish_color_comment ABB2BF
  # set -U fish_color_quote 98C379
  # set -U fish_color_end C678DD
  # set -U fish_color_param 56B6C2
  # set -U fish_color_redirection E5C07B
  # '';
  colors = with builtins; 
  lib.fold(a: b: a + b) "" (attrValues (mapAttrs (cmd: color: ''
    set -U ${cmd} ${substring 1 (stringLength color) color}
  '') colorscheme));

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
      fk = "fuck";
      l = "exa --icons --git -l";
      tls = "tmux ls";
      la = "exa --icons --git -la";
      cat = "bat";
      grep = "rg";
      find = "fd";
      du = "dust";
      ps = "procs";
      top = "btm";
      vim = "nvim";
      vi = "nvim";
      ta = "tmux a -t (env FZF_DEFAULT_COMMAND='tmux ls -F \"#S\"' fzf -1 --no-multi --prompt=\"Select a session: \")";

      # Interactive destructive commands
      rm = "rm -i";
      cp = "cp -i";
      mv = "mv -i";

      xclip = "xclip -selection clipboard";
      "..." = "cd ../..";

      # Nix aliases
      nix-config = "$EDITOR /etc/nixos/.";
      shell = "nix-shell --run fish";
    } // shells // inits;

    # Fish Initializing
    shellInit = ''
      ${fish-environment-variables}

      ${colors}

      fish_vi_key_bindings
      starship init fish | source'';
  };
}
