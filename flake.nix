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

        #poetryEnv = import ./mkPoetryEnv.nix {
        #  pkgs = nixpkgs.legacyPackages.${system};
        #};
        config = {
          projectDir = ./.;
          #propagatedBuildInputs = runtimeDeps;
        };
    in
    {

      poetryEnv = import ./mkPoetryEnv.nix {
        pkgs = nixpkgs.legacyPackages.${system};
      };

      packages.poetry2nixOCIImage = import ./poetry2nixOCIImage.nix {
        pkgs = nixpkgs.legacyPackages.${system};
      };


      devShell = pkgsAllowUnfree.mkShell {

        buildInputs = with pkgsAllowUnfree; [
                       poetry

                       # http://ix.io/2mF9
                       #ncurses
                       #xorg.libX11
                       #xorg.libXext
                       #xorg.libXrender
                       #xorg.libICE
                       #xorg.libSM
                       #glib

                       #poetryEnv
                       (pkgsAllowUnfree.poetry2nix.mkPoetryEnv config)
 
                       # Lets see
                       #commonsCompress
                       #gnutar
                       #lzma.bin
                       #git
                       
                       neovim
                     ];

          shellHook = ''
            unset SOURCE_DATE_EPOCH
            echo 'Working!'
          '';
        };

  });

}
