{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell {
  buildInputs = with pkgs;
    [
      (python3.withPackages
        (ps: with ps; [ black flake8 mypy python-language-server isort ]))
    ];
}
