
# Minimal reproducer


```bash
git clone https://github.com/ES-Nix/poetry2nix-examples.git \
&& cd poetry2nix-examples \
&& git checkout bug-drf-spectacular-PyYAML-yaml \
&& nix \
develop \
--command \
./run-tests.sh
```


A few references:

- The import of the `yaml` in drf-spectacular https://github.com/tfranzel/drf-spectacular/blame/4b8975d6d2b34a961506d9f20f226818f2c88495/drf_spectacular/renderers.py#L5
- The `propagatedBuildInputs` list importing the `pyyaml` https://github.com/NixOS/nixpkgs/blob/b16c74abd3b149b09613629219716202c5436427/pkgs/tools/admin/awscli2/default.nix#L83
- Might be related https://github.com/NixOS/nixpkgs/issues/42903 and https://github.com/NixOS/nixpkgs/issues/28325



### Other commands not so reliable, WIP


```bash
nix \
develop \
--command \
"./run-tests.sh"
```

Does not work:
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

Useful sometimes:
```bash
nix store optimise --verbose \
&& nix store  --verbose
```
