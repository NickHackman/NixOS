{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell { buildInputs = with pkgs; [ nixfmt pandoc nodePackages.prettier ]; }
