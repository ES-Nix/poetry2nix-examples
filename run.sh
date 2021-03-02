#!/usr/bin/env bash

# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


#git add .

#git commit --message 'Save flake state'

#nix flake update --commit-lock-file

#nix build --out-link oci_image


#cp --no-dereference --recursive --verbose $(nix-store --query --requisites oci_image) oci_image_out \
#&& mv oci_image_out oci_image


./test_oci_image.sh
