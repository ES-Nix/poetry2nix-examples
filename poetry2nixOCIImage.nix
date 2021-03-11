{ pkgs ?  import <nixpkgs> {} }:
let
    poetry2nixOCI = import ./poetry2nix.nix { inherit pkgs; };
in
    pkgs.dockerTools.buildImage {
    name = "numtild-dockertools-poetry2nix";
    tag = "0.0.1";
    contents = with pkgs; [
      poetry2nixOCI

      #coreutils
      #file
      #glibcLocales
      #which
      #python38Full
      #neovim
    ];

    config.Entrypoint = [ "${pkgs.bashInteractive}/bin/bash" ];
}


