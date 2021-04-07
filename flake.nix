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

        pkgs = import nixpkgs { inherit system; overlays = [ poetry2nix-src.overlay ]; };

        config = {
          projectDir = ./.;
        };
    in
    {
      devShell = pkgsAllowUnfree.mkShell {
        buildInputs = with pkgsAllowUnfree; [
                       poetry
                       (pkgsAllowUnfree.poetry2nix.mkPoetryEnv config)
                     ];

          shellHook = ''
            unset SOURCE_DATE_EPOCH
            echo 'Entering the nix develop!'
          '';
        };
  });
}
