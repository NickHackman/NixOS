{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell {
  buildInputs = with pkgs; [
    openjdk11
    gradle

    # Markdown
    pandoc
    nodePackages.prettier
  ];
}
