{ pkgs ?  import <nixpkgs> {} }:
let
    poetry2nixOCI = import ./poetry2nix.nix { inherit pkgs; };
in
    pkgs.dockerTools.buildLayeredImage {
    name = "numtild-dockertools-poetry2nix";
    tag = "0.0.1";
    contents = [ poetry2nixOCI ];

    config.Entrypoint = [ "${pkgs.bashInteractive}/bin/bash" ];
}