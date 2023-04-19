{ pkgs ? import <nixpkgs> { } }:
let
  pythonEnv = pkgs.poetry2nix.mkPoetryEnv {
    python = pkgs.python3;
    poetrylock = ./poetry.lock;
    pyproject = ./pyproject.toml;

    projectDir = ./.;
  };
in
pythonEnv

