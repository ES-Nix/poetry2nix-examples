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
    in
    {
      packages.poetry2nixOCIImage = import ./poetry2nixOCIImage.nix {
        pkgs = nixpkgs.legacyPackages.${system};
      };

    #defaultPackage = self.packages.${system}.myExampleFlake;

    #packages.${system} = self.packages.myExampleFlake2;
  });

}
