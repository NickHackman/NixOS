# Shell for Linux Kernel Development
#
# Permits `$ make menuconfig` and building the kernel, but not xconfig or gconfig.
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
