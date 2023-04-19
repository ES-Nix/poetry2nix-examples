{
  description = "A nix flake minimal flask example with podman rootless";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    podman-rootless.url = "github:ES-Nix/podman-rootless";
  };

  outputs = { self, nixpkgs, flake-utils, podman-rootless }:
    flake-utils.lib.eachDefaultSystem (system:
      let

        pkgsAllowUnfree = import nixpkgs {
          system = "x86_64-linux";
          config = { allowUnfree = true; };
        };

        poetryEnv = import ./mkPoetryEnv.nix {
          pkgs = nixpkgs.legacyPackages.${system};
        };

        config = {
          projectDir = ./.;
        };

        hook = pkgsAllowUnfree.writeShellScriptBin "hook" ''
          # TODO:
          export TMPDIR=/tmp

          # TODO:
          podman-setup-script
          podman-capabilities

          ${build_and_load}/bin/build_and_load
          ${podmanTestFlaskAPI}/bin/podman-test-flask-API
        '';

        build_and_load_dev = pkgsAllowUnfree.writeShellScriptBin "build_and_load_dev" ''
          nix build .#poetry2nixOCIImage
          podman load < result
        '';

        build_and_load = pkgsAllowUnfree.writeShellScriptBin "build_and_load" ''
          nix build github:ES-Nix/poetry2nix-examples/flask-hello-in-oci-podman-rootless#poetry2nixOCIImage
          podman load < result
        '';

        podmanTestFlaskAPI = pkgsAllowUnfree.writeShellScriptBin "podman-test-flask-API" ''
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
        packages.poetry2nixOCIImage = import ./poetry2nixOCIImage.nix {
          pkgs = nixpkgs.legacyPackages.${system};
        };

        env = pkgsAllowUnfree.poetry2nix.mkPoetryEnv config;

        devShell = pkgsAllowUnfree.mkShell {
          buildInputs = with pkgsAllowUnfree; [
            curl
            # (pkgsAllowUnfree.poetry2nix.mkPoetryEnv config)
            poetryEnv
            podman-rootless.defaultPackage.${system}
            poetry
            ripgrep
            hook
          ];

          shellHook = ''
            # TODO:
            export TMPDIR=/tmp
            echo "Entering the nix devShell"
          '';
        };
      });
}
