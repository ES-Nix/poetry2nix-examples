#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

sudo rm --force poetry2nixOCIImage.tar.gz

nix build .#poetry2nixOCIImage --out-link poetry2nixOCIImage.tar.gz

podman load < poetry2nixOCIImage.tar.gz
 

#podman \
#run \
#--interactive=true \
#--rm=true \
#--tty=true \
#numtild-dockertools-poetry2nix:0.0.1 \
#brazilian_money_format


#ls -al /nix/store/*-glibc-2.32-35/share/i18n/charmaps/
#file /nix/store/*-glibc-2.32-35/lib/locale/locale-archive
#
#cd /nix/store/*-glibc-2.32-35/share/i18n/charmaps/
#gzip -dk ISO-8859-1.gz
#/nix/store/*-glibc-2.32-35-bin/bin/localedef pt_BR -i pt_BR -f ISO-8859-1


sudo rm --force poetry2nixOCIImage.tar.gz

podman rm oci_container
podman \
run \
--interactive=true \
--name=oci_container \
--rm=false \
--tty=false \
numtild-dockertools-poetry2nix:0.0.1 <<COMMANDS
cd /nix/store/*-glibc-2.32-35/share/i18n/charmaps/
gzip -dk ISO-8859-1.gz
/nix/store/*-glibc-2.32-35-bin/bin/localedef pt_BR -i pt_BR -f ISO-8859-1
/nix/store/*-glibc-2.32-35-bin/bin/localedef pt_BR.ISO-8859-1 -i pt_BR -f ISO-8859-1
/nix/store/*-glibc-2.32-35-bin/bin/localedef pt_BR.ISO8859-1 -i pt_BR -f ISO-8859-1
/nix/store/*-glibc-2.32-35-bin/bin/locale --all
env

echo

gzip -dk UTF-8
/nix/store/*-glibc-2.32-35-bin/bin/localedef -c -f UTF-8 -i pt_BR pt_BR.UTF-8
/nix/store/*-glibc-2.32-35-bin/bin/locale --all
env
python -c 'import locale; locale.setlocale(locale.LC_ALL, "pt_BR.UTF-8")'
COMMANDS