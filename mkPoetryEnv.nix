{ pkgs ? import <nixpkgs> { } }:
let
  pythonEnv = pkgs.poetry2nix.mkPoetryEnv {
    python = pkgs.python3;
    poetrylock = ./poetry.lock;
    pyproject = ./pyproject.toml;

    projectDir = ./.;

  # https://github.com/nix-community/poetry2nix/issues/218#issuecomment-1511405519
  overrides = pkgs.poetry2nix.overrides.withDefaults (self: super: {

    blinker = super.blinker.overridePythonAttrs (
      old: {
        buildInputs = (old.buildInputs or [ ]) ++ [ self.flit-core ];
      }
    );

    werkzeug = super.werkzeug.overridePythonAttrs (
      old: {
        buildInputs = (old.buildInputs or [ ]) ++ [ self.flit-core ];
      }
    );

    # https://pypi.org/project/Flask/#history
    flask = super.flask.overridePythonAttrs (
      old: {
        buildInputs = (old.buildInputs or [ ]) ++ [ self.flit-core ];
      }
    );

    pandas = super.pandas.overridePythonAttrs (
      old: {
        buildInputs = (old.buildInputs or [ ]) ++ [ self.versioneer ];
      }
    );

  });

  };
in
pythonEnv

