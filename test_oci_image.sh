#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

sudo rm --force poetry2nixOCIImage.tar.gz

nix build .#poetry2nixOCIImage --out-link poetry2nixOCIImage.tar.gz

podman load < poetry2nixOCIImage.tar.gz
 

podman \
run \
--interactive=true \
--rm=true \
--tty=true \
--user=app_user \
numtild-dockertools-poetry2nix:0.0.1 \
minimal_python_builtin_scrip


sudo rm --force poetry2nixOCIImage.tar.gz
