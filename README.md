## This is an nix flake example of an python application using poetr2nix 


```bash
nix build github:ES-Nix/poetry2nix-examples/424f84dbc089f448a7400292f78b903e44c7f074#poetry2nixOCIImage
```

```bash
nix develop github:ES-Nix/poetry2nix-examples/a39f8cf6f06af754d440458b7e192e49c95795bb
```

```bash
nix build github:ES-Nix/poetry2nix-examples/a39f8cf6f06af754d440458b7e192e49c95795bb#poetry2nixOCIImage
```

```bash
git clone https://github.com/ES-Nix/poetry2nix-examples.git \
&& cd poetry2nix-examples \
&& git checkout ed9e9bee7b58e9ceee4d453c72e799bee838a92b \
&& nix build .#poetry2nixOCIImage
```

```bash
nix develop --command poetry show
```

```bash
nix develop github:ES-Nix/poetry2nix-examples --command poetry add pandas
```

Broken:
```bash
nix flake clone github:ES-Nix/poetry2nix-examples --dest poetry2nix-examples
```

```bash
nix flake clone git+ssh://git@github.com/ES-Nix/poetry2nix-examples.git --dest poetry2nix-examples
```

Super thread about mach nix:
https://discourse.nixos.org/t/mach-nix-create-python-environments-quick-and-easy/6858/78

## Only numpy

```bash
nix develop github:ES-Nix/poetry2nix-examples/2cb6663e145bbf8bf270f2f45c869d69c657fef2
```

```bash
nix build github:ES-Nix/poetry2nix-examples/2cb6663e145bbf8bf270f2f45c869d69c657fef2#poetry2nixOCIImage
```

```bash
nix develop github:davhau/mach-nix#shellWith.numpy
```

```bash
git clone https://github.com/ES-Nix/poetry2nix-examples.git \
&& cd poetry2nix-examples \
&& git checkout 2cb6663e145bbf8bf270f2f45c869d69c657fef2 \
&& nix build .#poetry2nixOCIImage
```

## The locale thing

```bash
nix \
build \
github:ES-Nix/poetry2nix-examples/d55b1d471dd3a7dba878352df465a23e22f60101#poetry2nixOCIImage \
--out-link \
poetry2nixOCIImage.tar.gz

podman load < poetry2nixOCIImage.tar.gz

podman \
run \
--interactive=true \
--rm=true \
--tty=true \
localhost/numtild-dockertools-poetry2nix:0.0.1 \
flask_minimal_example
```


## 


```bash
git clone https://github.com/ES-Nix/poetry2nix-examples.git \
&& cd poetry2nix-examples \
&& git checkout flask-hello-in-oci-podman-rootless
```


```bash
nix \
develop \
github:ES-Nix/poetry2nix-examples/flask-hello-in-oci-podman-rootless \
--command \
hook
```
