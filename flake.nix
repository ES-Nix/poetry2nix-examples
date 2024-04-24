{
  description = "A nix flake minimal flask example with podman rootless";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";
    podman-rootless.url = "github:ES-Nix/podman-rootless/from-nixpkgs";

    podman-rootless.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    allAttrs@{ self
    , nixpkgs
    , flake-utils
    , podman-rootless
    }:
    flake-utils.lib.eachDefaultSystem (system:
    let

      pkgsAllowUnfree = import nixpkgs {
        system = "x86_64-linux";
        config = { allowUnfree = true; };
      };

      # https://gist.github.com/tpwrules/34db43e0e2e9d0b72d30534ad2cda66d#file-flake-nix-L28
      pleaseKeepMyInputs = pkgsAllowUnfree.writeTextDir "bin/.please-keep-my-inputs"
        (builtins.concatStringsSep " " (builtins.attrValues allAttrs));

      poetryEnv = import ./mkPoetryEnv.nix {
        pkgs = nixpkgs.legacyPackages.${system};
      };

      hook = pkgsAllowUnfree.writeShellScriptBin "hook" ''
        # TODO:
        export TMPDIR=/tmp

        ${build_and_load}/bin/build_and_load
        ${podmanTestFlaskAPI}/bin/podman_test_flask_API
      '';

      hookDev = pkgsAllowUnfree.writeShellScriptBin "hook_dev" ''
        # TODO:
        export TMPDIR=/tmp

        git pull

        ${build_and_load_dev}/bin/build_and_load_dev
        ${podmanTestFlaskAPI}/bin/podman_test_flask_API
      '';

      build_and_load_dev = pkgsAllowUnfree.writeShellScriptBin "build_and_load_dev" ''
        nix build .#poetry2nixOCIImage
        podman load < result
      '';

      build_and_load = pkgsAllowUnfree.writeShellScriptBin "build_and_load" ''
        nix build github:ES-Nix/poetry2nix-examples/flask-hello-in-oci-podman-rootless#poetry2nixOCIImage
        podman load < result
      '';

      podmanTestFlaskAPI = pkgsAllowUnfree.writeShellScriptBin "podman_test_flask_API" ''
            set -e

            POD_NAME=play-with-flask

        	podman \
                pod \
                rm \
                --force \
                --ignore \
                $POD_NAME

        	podman \
                pod \
                create \
                --publish=5000:5000 \
                --name=$POD_NAME

            podman \
                run \
                --detach=true \
                --interactive=true \
                --pod=$POD_NAME \
                --rm=true \
                --tty=true \
                --user=app_user \
                localhost/numtild-dockertools-poetry2nix:0.0.1 \
                flask_minimal_example

            sleep 5

            curl localhost:5000 | rg 'Hello world!!'
            curl localhost:5000/pandas | rg '1.2.2'

            podman \
                pod \
                rm \
                --force \
                --ignore \
                $POD_NAME

            unset POD_NAME
      '';

    in
    {

      # nix fmt
      formatter = pkgsAllowUnfree.nixpkgs-fmt;

      packages.poetry2nixOCIImage = import ./poetry2nixOCIImage.nix {
        pkgs = nixpkgs.legacyPackages.${system};
      };

      devShells.default = pkgsAllowUnfree.mkShell {
        buildInputs = with pkgsAllowUnfree; [
          curl
          dive
          # poetryEnv
          podman-rootless.packages.${system}.podman
          poetry
          ripgrep
          # hook
          # hookDev
        ];

        shellHook = ''
          # TODO:
          export TMPDIR=/tmp
          echo "Entering the nix devShell"

          # echo "''\${poetryEnv}"
          # export PYTHONPATH="''$\{poetryEnv}"
          # python3 -c 'import flask'

          # test -d .venv || mkdir -v .venv
          # cp -Rv "''\${poetryEnv}" .venv
          # id -un
          # chown -Rv "$(id -un)":"$(id -gn)" .venv
          # ln -sfv "''\${poetryEnv}" .venv
          # ln -sfv "''\${poetryEnv}/''\${poetryEnv.sitePackages}" .venv

          test -d .profiles || mkdir -v .profiles

          test -L .profiles/dev \
          || nix develop .# --profile .profiles/dev --command true

          test -L .profiles/dev-shell-default \
          || nix build $(nix eval --impure --raw .#devShells."$system".default.drvPath) --out-link .profiles/dev-shell-"$system"-default

        '';
      };
    });
}
