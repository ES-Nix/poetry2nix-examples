


```
nix build github:ES-Nix/poetry2nix-examples/424f84dbc089f448a7400292f78b903e44c7f074#poetry2nixOCIImage
```

1)
```
nix build github:ES-Nix/poetry2nix-examples/ed9e9bee7b58e9ceee4d453c72e799bee838a92b#poetry2nixOCIImage
```


2)
```
nix build github:ES-Nix/poetry2nix-examples/ed9e9bee7b58e9ceee4d453c72e799bee838a92b#poetry2nixOCIImage
```

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

Broke:
`nix flake clone github:ES-Nix/poetry2nix-examples --dest poetry2nix-examples`
