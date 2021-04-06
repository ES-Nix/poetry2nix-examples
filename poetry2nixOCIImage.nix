{ pkgs ?  import <nixpkgs> {} }:
let
    poetry2nixOCI = import ./poetry2nix.nix { inherit pkgs; };
in
    pkgs.dockerTools.buildImage {
    name = "poetry2nix-dockertools";
    tag = "0.0.1";
    contents = with pkgs; [
      poetry2nixOCI
    ];

    config.Entrypoint = [ "${pkgs.bashInteractive}/bin/bash" ];
}


