
# Minimal example, work in progress

https://stackoverflow.com/a/59316578


Really cool: https://stackoverflow.com/a/67329452


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

TODO:
- take a long and deep look: https://github.com/python-poetry/poetry/discussions/1879
- it uses pip to install `.whl` duilt from poetry https://stackoverflow.com/a/57374374
- `ln -s /opt/poetry/bin/poetry` https://stackoverflow.com/a/66014079

About the include system: https://stackoverflow.com/a/66437801
https://python-poetry.org/docs/pyproject/#include-and-exclude
