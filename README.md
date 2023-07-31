## This is an nix flake example of an python application built using poetr2nix 


## 

```bash
nix flake clone github:ES-Nix/poetry2nix-examples --dest poetry2nix-examples
```




```bash
nix \
build \
--no-link \
--print-build-logs \
github:ES-Nix/poetry2nix-examples/flask-hello-in-oci-podman-rootless#poetry2nixOCIImage
```

```bash
nix \
build \
--max-jobs auto \
--no-link \
--print-build-logs \
github:ES-Nix/poetry2nix-examples/flask-hello-in-oci-podman-rootless#poetry2nixOCIImage \
--post-build-hook ./custom-build-hook.sh
```

```bash
git clone git@github.com:ES-Nix/poetry2nix-examples.git \
&& cd poetry2nix-examples \
&& git checkout flask-hello-in-oci-podman-rootless \
&& direnv allow 1>/dev/null 2>/dev/null
```


```bash
nix \
develop \
github:ES-Nix/poetry2nix-examples/flask-hello-in-oci-podman-rootless \
--command \
hook
```

```bash
nix \
develop \
github:ES-Nix/poetry2nix-examples/flask-hello-in-oci-podman-rootless \
--command \
python3 -c 'from flask import Flask'
```


```bash
nix \
develop \
github:ES-Nix/poetry2nix-examples/flask-hello-in-oci-podman-rootless \
--command \
python3 -c 'import flask; print(flask.__version__)'
```


### How to update


```bash
# github:NixOS/nixpkgs/fcb8252e87f3e149b7675efe1a9fdba84e36741d
nix flake update --override-input nixpkgs github:NixOS/nixpkgs/0a4206a51b386e5cda731e8ac78d76ad924c7125 \
&& git status \
&& git add .
```
