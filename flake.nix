{
  description = "This is the nix flake package";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let

        pkgsAllowUnfree = import nixpkgs {
          system = "x86_64-linux";
          config = { allowUnfree = true; };
        };

        config = {
          projectDir = ./.;
        };

        # Provides a script that copies required files to ~/
        podmanSetupScript =
          let
            registriesConf = pkgsAllowUnfree.writeText "registries.conf" ''
              [registries.search]
              registries = ['docker.io']
              [registries.block]
              registries = []
            '';
          in
          pkgsAllowUnfree.writeShellScriptBin "podman-setup-script" ''
            # Dont overwrite customised configuration
            if ! test -f ~/.config/containers/policy.json; then
              install -Dm555 ${pkgsAllowUnfree.skopeo.src}/default-policy.json ~/.config/containers/policy.json
            fi

            if ! test -f ~/.config/containers/registries.conf; then
              install -Dm555 ${registriesConf} ~/.config/containers/registries.conf
            fi
          '';

      in
      {
        packages.poetry2nixOCIImage = import ./poetry2nixOCIImage.nix {
          pkgs = nixpkgs.legacyPackages.${system};
        };

        poetryEnv = import ./mkPoetryEnv.nix.nix {
          pkgs = nixpkgs.legacyPackages.${system};
        };

        env = pkgsAllowUnfree.poetry2nix.mkPoetryEnv config;

        devShell = pkgsAllowUnfree.mkShell {
          buildInputs = with pkgsAllowUnfree; [
            #(pkgsAllowUnfree.poetry2nix.mkPoetryEnv config)
            podman
            podmanSetupScript
            poetry
          ];

          shellHook = ''
            # TODO: document this or solve, it is spreading not done either
            export TMPDIR=/tmp

            # podman may need this
            podman-setup-script

            echo "Entering the nix devShell no income back"

          '';
        };
      });
}
