{ pkgs ? import <nixpkgs> { } }:
pkgs.poetry2nix.mkPoetryApplication {
  poetrylock = ./poetry.lock;
  pyproject = ./pyproject.toml;
  python = pkgs.python3;
  # python = pkgs.rustpython;
  # python = pkgs.pypy3;
  # python = pkgs.pkgsStatic.python3;
  /*
  python = pkgs.python3Minimal.overrideAttrs
        (oldAttrs: {
          tzdata = pkgs.tzdata;
          rebuildBytecode = false;
          stripTests = true;
          stripIdlelib = true;
          stripConfig = true;
          stripTkinter = true;
          reproducibleBuild = true;
          static = true;

          nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ pkgs.gcc pkgs.openssl ];
           }
      );
  */
  src = pkgs.lib.cleanSource ./.;

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
}
