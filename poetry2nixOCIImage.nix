{ pkgs ? import <nixpkgs> { } }:
let
  poetry2nixOCIImage = import ./poetry2nix.nix { inherit pkgs; };

  nonRootShadowSetup = { user, uid, group, gid }: with pkgs; [
    (
      writeTextDir "etc/shadow" ''
        ${user}:!:::::::
      ''
    )
    (
      writeTextDir "etc/passwd" ''
        ${user}:x:${toString uid}:${toString gid}::/home/${user}:${runtimeShell}
      ''
    )
    (
      writeTextDir "etc/group" ''
        ${group}:x:${toString gid}:
      ''
    )
    (
      writeTextDir "etc/gshadow" ''
        ${group}:x::
      ''
    )
  ];

in
pkgs.dockerTools.buildLayeredImage {
  name = "numtild-dockertools-poetry2nix";
  tag = "0.0.1";
  contents = [
              poetry2nixOCIImage
              pkgs.bashInteractive
              pkgs.coreutils
             ]
  ++
  (nonRootShadowSetup { user = "app_user"; uid = 12345; group = "app_group"; gid = 6789; });
  config.Entrypoint = [ "${pkgs.bashInteractive}/bin/bash" ];
    config = {
  #Cmd = [ "${pkgs.bashInteractive}/bin/bash" ];

  #    Entrypoint = [ entrypoint ];
      Env = [
          "SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bunle.crt"
      ];
    };
}
