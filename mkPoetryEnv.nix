{ pkgs ? import <nixpkgs> { } }:
let
  pythonEnv = pkgs.poetry2nix.mkPoetryEnv {
    python = pkgs.python3;
    poetrylock = ./poetry.lock;
    projectDir = ./.;

    overrides = [
      pkgs.poetry2nix.defaultPoetryOverrides
      (self: super: {
        selenium = super.selenium.override { preferWheel = true; };
      })
      (self: super: {
        numpy = super.numpy.override {
          preferWheel = true;
          checkPhase = ''
            # https://github.com/NixOS/nixpkgs/issues/16144#issuecomment-225422439
            export HOME=$TMP
          '';
        };
      })
    ];

  };
in
pythonEnv

