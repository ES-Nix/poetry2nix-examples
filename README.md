
# Minimal example, work in progress

https://stackoverflow.com/a/59316578

```bash
nix develop
nix shell nixpkgs#poetry --command poetry build --format=wheel
```

```bash
nix develop
poetry build --format=wheel
```

```bash
podman \
build \
--file Containerfile \
--tag poetry:0.0.1
```


```bash
podman \
run \
--interactive=true \
--tty=true \
--rm=true \
--user='0' \
--volume="$(pwd)":/code:rw \
--workdir=/code \
poetry:0.0.1 \
bash \
-c \
"python -c 'from my_package.log_revision import start; start()'"
```

