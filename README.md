
# 

```bash
nix \
develop \
github:ES-Nix/poetry2nix-examples/bug-drf-spectacular-PyYAML-yaml \
--command \
"./run-tests.sh"
```


```bash
nix \
develop \
--command \
"./run-tests.sh"
```

```bash
nix \
develop \
--refresh \
github:ES-Nix/NixOS-environments/box \
--command \
nixos-box-volume \
&& nix develop --command ./run-tests.sh
```

```bash
nix \      
develop \
github:ES-Nix/NixOS-environments/box \
--command \
nix \
develop \
github:ES-Nix/poetry2nix-examples/bug-drf-spectacular-PyYAML-yaml \
--command \
"./run-tests.sh"
```

```bash
nix \
develop \
--refresh \
github:ES-Nix/NixOS-environments/box \
--command \
nixos-box-volume
```

```bash
nix store optimise --verbose \
&& nix store  --verbose
```
