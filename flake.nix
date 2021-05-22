{
  description = "Flake do income-back";

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

        config = {
          projectDir = ./.;
        };

        shellHookEntrypoint = pkgsAllowUnfree.writeShellScriptBin "shell-hook-entrypoint" ''
            # TODO:
            export TMPDIR=/tmp

            echo "Entering the nix devShell"

            # TODO:
            podman-setup-script
            podman-capabilities

            ${build}/bin/build
            ${podmanTestFlaskAPI}/bin/podman-test-flask-API
        '';

        build = pkgsAllowUnfree.writeShellScriptBin "build" ''
            nix build .#poetry2nixOCIImage
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
            --pod=$POD_NAME \
            --rm=true \
            --tty=true \
            --user=app_user \
            localhost/numtild-dockertools-poetry2nix:0.0.1 \
            nixfriday

            sleep 3

            curl localhost:500 | rg 'Hello world!!'

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
        #packages.${system} = self.packages.poetry2nixOCIImage;

        poetryEnv = import ./mkPoetryEnv.nix.nix {
          pkgs = nixpkgs.legacyPackages.${system};
        };

        env = pkgsAllowUnfree.poetry2nix.mkPoetryEnv config;

        devShell = pkgsAllowUnfree.mkShell {
          #buildInputs = with pkgs; [ env ]
          #  ++ minimalUtils;
          buildInputs = with pkgsAllowUnfree; [
            curl
            (pkgsAllowUnfree.poetry2nix.mkPoetryEnv config)
            podman-rootless.defaultPackage.${system}
            poetry
            ripgrep
            shellHookEntrypoint
          ];

          shellHook = ''
            shell-hook-entrypoint
          '';
        };
      });
}
