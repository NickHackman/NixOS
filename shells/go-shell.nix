{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell {
  buildInputs = with pkgs; [
    go
    golangci-lint
    goimports
    gocode
    gotests
    richgo

    # Markdown
    pandoc
    nodePackages.prettier
  ];
}
