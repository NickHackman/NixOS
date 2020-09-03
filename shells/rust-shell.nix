{ pkgs ? import <nixpkgs> { } }:

with pkgs;

let
  unstable = import (fetchTarball
    "https://github.com/nixos/nixpkgs/archive/nixpkgs-unstable.tar.gz") { };

  moz_overlay = import (builtins.fetchTarball
    "https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz");

  nixpkgs = import <nixpkgs> { overlays = [ moz_overlay ]; };

in mkShell {
  buildInputs = with pkgs; [
    unstable.rust-analyzer
    rustfmt
    clippy
    nixpkgs.latest.rustChannels.stable.rust
  ];
}
