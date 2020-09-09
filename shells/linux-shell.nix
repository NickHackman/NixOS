{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell {
  buildInputs = with pkgs; [
    gnumake
    gcc
    ncurses
    pkg-config
    elfutils
    bc
    flex
    bison
  ];
}
