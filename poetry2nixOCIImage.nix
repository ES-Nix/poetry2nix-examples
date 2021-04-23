{ pkgs ?  import <nixpkgs> {} }:
let
    poetry2nixOCI = import ./poetry2nix.nix { inherit pkgs; };
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
    pkgs.dockerTools.buildImage {
    name = "minimal-python-builtin-script";
    tag = "0.0.1";
    contents = with pkgs; [
      poetry2nixOCI
      coreutils
    ]
   ++
  (nonRootShadowSetup { user = "app_user"; uid = 12345; group = "app_group"; gid = 6789; });

    config.Entrypoint = [ "${pkgs.bashInteractive}/bin/bash" ];
}


