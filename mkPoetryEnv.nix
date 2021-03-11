{ pkgs }:
let
  pythonEnv = pkgs.poetry2nix.mkPoetryEnv {
    python = pkgs.python3;
    pyproject = ./pyproject.toml;
    poetrylock = ./poetry.lock;
  };
in
  pkgs.mkShell {
  buildInputs = [ pythonEnv pkgs.glibcLocales ];
}

