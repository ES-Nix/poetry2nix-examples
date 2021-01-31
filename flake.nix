{
  description = "A usefull description";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
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
      packages.poetry2nixOCIImage = import ./poetry2nixOCIImage.nix {
        pkgs = nixpkgs.legacyPackages.${system};
      };


      devShell = pkgsAllowUnfree.mkShell {

        buildInputs = with pkgsAllowUnfree; [ poetry 

                       # http://ix.io/2mF9
                       ncurses
                       xorg.libX11
                       xorg.libXext
                       xorg.libXrender
                       xorg.libICE
                       xorg.libSM
                       glib
                       poetryEnv
                     ];

          shellHook = ''
            unset SOURCE_DATE_EPOCH
            echo 'Working!'
          '';
        };

  });

}
