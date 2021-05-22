#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail

sudo rm --force poetry2nixOCIImage.tar.gz

nix build .#poetry2nixOCIImage --out-link poetry2nixOCIImage.tar.gz

podman load < poetry2nixOCIImage.tar.gz
 

timeout \
10 \
podman \
run \
--interactive=true \
--rm=true \
--tty=true \
numtild-dockertools-poetry2nix:0.0.1 \
flask_minimal_example


sudo rm --force poetry2nixOCIImage.tar.gz
