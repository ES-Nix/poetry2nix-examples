{
  description = "A usefull description";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: {

    packages.myExampleFlake = import ./default.nix {
      pkgs = nixpkgs.legacyPackages.${system};
    };

    packages.myExampleFlake2 = import ./default2.nix {
      pkgs = nixpkgs.legacyPackages.${system};
    };

    defaultPackage = self.packages.${system}.myExampleFlake;

    packages.${system} = self.packages.myExampleFlake2;
  });

}