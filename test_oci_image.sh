#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


nix build .#poetry2nixOCIImage


cp result poetry2nixOCIImage.tar.gz

docker load < poetry2nixOCIImage.tar.gz

docker \                               
run \
--interactive \
--publish=5000:5000 \
--rm \
--tty \
numtild-dockertools-poetry2nix:0.0.1 \
nixfriday

