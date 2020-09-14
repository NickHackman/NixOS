{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell {
  buildInputs = with pkgs; [
    haskellPackages.elm-make
    haskellPackages.elm-repl
    haskellPackages.elm-reactor
    haskellPackages.elm-package
    nodePackages.elm-oracle
    elmPackages.elm-format
    elmPackages.elm-test

    # Markdown
    pandoc
    nodePackages.prettier
  ];
}
