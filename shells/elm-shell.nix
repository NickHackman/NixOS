{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell {
  buildInputs = with pkgs; [
    elmPackages.elm
    nodePackages.elm-oracle
    elmPackages.elm-format
    elmPackages.elm-test
    elmPackages.elm-language-server

    # Markdown
    pandoc
    nodePackages.prettier
  ];
}
