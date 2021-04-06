


```
nix develop github:ES-Nix/poetry2nix-examples/a39f8cf6f06af754d440458b7e192e49c95795bb
```

```
nix build github:ES-Nix/poetry2nix-examples/a39f8cf6f06af754d440458b7e192e49c95795bb#poetry2nixOCIImage
```


nix develop github:ES-Nix/a39f8cf6f06af754d440458b7e192e49c95795bbpoetry2nix-examples --command poetry add pandas
nix develop github:ES-Nix/a39f8cf6f06af754d440458b7e192e49c95795bb/poetry2nix-examples --command poetry show --tree

```
git clone https://github.com/ES-Nix/poetry2nix-examples.git
cd poetry2nix-examples
git checkout a39f8cf6f06af754d440458b7e192e49c95795bb
nix build .#poetry2nixOCIImage
```

```
nix develop --command poetry show
```
