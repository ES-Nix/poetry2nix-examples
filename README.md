


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

## Only numpy

```
nix develop github:ES-Nix/poetry2nix-examples/2cb6663e145bbf8bf270f2f45c869d69c657fef2
```

```
nix build github:ES-Nix/poetry2nix-examples/2cb6663e145bbf8bf270f2f45c869d69c657fef2#poetry2nixOCIImage
```

```
nix develop github:davhau/mach-nix#shellWith.numpy
```

```
git clone https://github.com/ES-Nix/poetry2nix-examples.git
cd poetry2nix-examples
git checkout 2cb6663e145bbf8bf270f2f45c869d69c657fef2
nix build .#poetry2nixOCIImage
```

## The locale thing


```
nix build github:ES-Nix/poetry2nix-examples/d55b1d471dd3a7dba878352df465a23e22f60101#poetry2nixOCIImage --out-link poetry2nixOCIImage.tar.gz

podman load < poetry2nixOCIImage.tar.gz

podman \
run \
--interactive=true \
--rm=true \
--tty=true \
localhost/numtild-dockertools-poetry2nix:0.0.1 \
flask_minimal_example
```



nix-env -f '<nixpkgs>' -iA nix-direnv

echo 'source $HOME/.nix-profile/share/nix-direnv/direnvrc' >> $HOME/.direnvrc

 echo 'keep-outputs = true' >> $HOME/.config/nix/nix.conf
 echo 'keep-derivations = true' >> $HOME/.config/nix/nix.conf
 


mkdir play-nix-direnv

cd play-nix-direnv

file_string=$(echo -e "$(cat <<"EOF"
{
  description = "A very basic flake";
  # Provides abstraction to boiler-code when specifying multi-platform outputs.
  inputs.flake-utils.url = "github:numtide/flake-utils";
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShell = pkgs.mkShell {
        nativeBuildInputs = [ pkgs.hello ];
      };
    });
}
EOF
)")

echo "$file_string" > flake.nix


echo "use flake" >> .envrc


echo 'eval "$(direnv hook bash)"' >> ~/bashrc


git init
git add .

nix shell nixpkgs#direnv

sudo apt-get update

sudo apt-get install -y direnv


