




```
nix build github:ES-Nix/poetry2nix-examples/424f84dbc089f448a7400292f78b903e44c7f074#poetry2nixOCIImage
```


nix flake clone github:ES-Nix/poetry2nix-examples/424f84dbc089f448a7400292f78b903e44c7f074

git clone https://github.com/ES-Nix/poetry2nix-examples.git
cd poetry2nix-examples
git checkout 424f84dbc089f448a7400292f78b903e44c7f074
nix build .#poetry2nixOCIImage


Broke:
`nix flake clone github:ES-Nix/poetry2nix-examples --dest poetry2nix-examples`
