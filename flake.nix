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

        env = pkgsAllowUnfree.poetry2nix.mkPoetryEnv {
          poetrylock = ./poetry.lock;
          # TODO: is it correct or we should use lib clean source?
          projectDir = ./.;
          python = pkgsAllowUnfree.python3;
        };
    in
    {
      devShell = pkgsAllowUnfree.mkShell {
        buildInputs = with pkgsAllowUnfree; [
                       env
                       poetry
                       python3
                     ];

          shellHook = ''
            unset SOURCE_DATE_EPOCH
          '';
        };
  });
}
