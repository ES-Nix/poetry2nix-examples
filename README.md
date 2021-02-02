


```
nix build github:ES-Nix/poetry2nix-examples/424f84dbc089f448a7400292f78b903e44c7f074#poetry2nixOCIImage
```

```
nix develop github:ES-Nix/poetry2nix-examples/a39f8cf6f06af754d440458b7e192e49c95795bb
```

nix build github:ES-Nix/poetry2nix-examples/a39f8cf6f06af754d440458b7e192e49c95795bb#poetry2nixOCIImage


```
git clone https://github.com/ES-Nix/poetry2nix-examples.git
cd poetry2nix-examples
git checkout ed9e9bee7b58e9ceee4d453c72e799bee838a92b
nix build .#poetry2nixOCIImage
```

```
nix develop --command poetry show
```


nix develop github:ES-Nix/poetry2nix-examples --command poetry add pandas

Broken:
`nix flake clone github:ES-Nix/poetry2nix-examples --dest poetry2nix-examples`

nix flake clone git+ssh://git@github.com/ES-Nix/poetry2nix-examples.git --dest poetry2nix-examples

Super thread about mach nix:
https://discourse.nixos.org/t/mach-nix-create-python-environments-quick-and-easy/6858/78