{
  description = "A usefull description";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.poetry2nix-src.url = "github:nix-community/poetry2nix";

  outputs = { self, nixpkgs, flake-utils, poetry2nix-src }:
    flake-utils.lib.eachDefaultSystem (system:
    let
        pkgsAllowUnfree = import nixpkgs {
          system = "x86_64-linux";
          config = { allowUnfree = true; };
        };

        poetryEnv = import ./mkPoetryEnv.nix {
          pkgs = nixpkgs.legacyPackages.${system};
        };
      in
      {
        devShell = pkgsAllowUnfree.mkShell {
          buildInputs = with pkgsAllowUnfree; [
#            poetryEnv
            firefox
            geckodriver
            poetry
            python38
          ];

         shellHook = ''
            export TMPDIR=/tmp

            # Set SOURCE_DATE_EPOCH so that we can use python wheels.
            # This compromises immutability, but is what we need
            # to allow package installs from PyPI
            export SOURCE_DATE_EPOCH=$(date +%s)

            VENV_DIR="$PWD"/.venv

            export PATH="$VENV_DIR"/bin:"$PATH"
            export LANG=en_US.UTF-8

            # https://python-poetry.org/docs/configuration/
            export POETRY_VIRTUALENVS_CREATE=true
            export PIP_CACHE_DIR="$PWD"/.local/pip-cache

            # Dirty fix for Linux systems
            # https://nixos.wiki/wiki/Packaging/Quirks_and_Caveats
            export LD_LIBRARY_PATH=${pkgsAllowUnfree.stdenv.cc.cc.lib}/lib/:"$LD_LIBRARY_PATH"
          '';
        };
  });
}
