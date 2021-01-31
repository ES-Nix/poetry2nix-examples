{ pkgs ? import <nixpkgs> {} }:
let
  pythonEnv = pkgs.poetry2nix.mkPoetryEnv {
    python = pkgs.python3;
    pyproject = ./pyproject.toml;
    poetrylock = ./poetry.lock;
  };
in
  pythonEnv

