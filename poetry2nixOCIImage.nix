{ pkgs ?  import <nixpkgs> {} }:
let
    poetry2nixOCI = import ./poetry2nix.nix { inherit pkgs; };

    glibcLocalesPtBRUTF8 = (pkgs.glibcLocales.override {
        allLocales = false;
        locales = [ "pt_BR.UTF-8/UTF-8" ];
        # locales = [ "en_US.UTF-8/UTF-8" ];
      }
    );
   troubleshootHelpers = with pkgs; [
      # file
      # gcc
      # gzip
      # glibc.bin
      # which
      # shadow
      # nano
   ];
in
    pkgs.dockerTools.buildImage {
    name = "numtild-dockertools-poetry2nix";
    tag = "0.0.1";
    contents = with pkgs; [
      # poetry2nixOCI
      # bashInteractive
      # coreutils

      glibcLocalesPtBRUTF8

    ];

    config = {
      # Entrypoint = [ "${pkgs.bashInteractive}/bin/bash" ];
      Cmd = [ "${poetry2nixOCI}/bin/brazilian_money_format" ];
      Env = [
              "LOCALE_ARCHIVE=${glibcLocalesPtBRUTF8}/lib/locale/locale-archive"
            ];
    };
}