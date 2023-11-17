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

  troubleshootPackages = with pkgs; [
    # https://askubuntu.com/questions/16700/how-can-i-change-my-own-user-id#comment749398_167400
    # https://unix.stackexchange.com/a/693915
    acl

    file
    findutils
    # gzip
    hello
    btop
    iproute
    nettools # why the story name is with an -?
    nano
    netcat
    ripgrep
    patchelf
    binutils
    mount
    # bpftrace
    strace
    uftrace
    # gnutar
    wget
    which
  ];

in
pkgs.dockerTools.buildLayeredImage {
  name = "numtild-dockertools-poetry2nix";
  tag = "0.0.1";
  contents = [
              poetry2nixOCIImage
              # pkgs.bashInteractive
              # pkgs.coreutils
              pkgs.busybox
             ]
     ++
     (nonRootShadowSetup { user = "app_user"; uid = 12345; group = "app_group"; gid = 6789; })
    # ++
    # troubleshootPackages
    ;

  config = {
    # Cmd = [ "${pkgs.bashInteractive}/bin/bash" ];
    # Entrypoint = [ entrypoint ];
    # Entrypoint = [ "${pkgs.bashInteractive}/bin/bash" ];

    Env = with pkgs; [
            # "SSL_CERT_FILE=${cacert}/etc/ssl/certs/ca-bunle.crt"
            # TODO: it needs a big refactor
            # "PATH=/root/.nix-profile/bin:/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin:/nix/var/nix/profiles/default/sbin:/bin:/sbin:/usr/bin:/usr/sbin"
            # "MANPATH=/root/.nix-profile/share/man:/home/nixuser/.nix-profile/share/man:/run/current-system/sw/share/man"
            # "NIX_PAGER=cat" # TODO: document it
            # "NIX_PATH=nixpkgs=${nixFlakes}"
            # "NIX_SSL_CERT_FILE=${cacert}/etc/ssl/certs/ca-bundle.crt"
            # "ENV=/etc/profile"
            # "GIT_SSL_CAINFO=${cacert}/etc/ssl/certs/ca-bunle.crt"
            # "USER=root"
            # "HOME=/root"
      ];
    };
}
