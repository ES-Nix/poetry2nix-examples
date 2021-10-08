



```bash
git clone https://github.com/ES-Nix/poetry2nix-examples.git
cd poetry2nix-examples
git checkout pytchat
```

```bash
poetry config virtualenvs.in-project true \
&& poetry config virtualenvs.path . \
&& poetry init --no-interaction \
&& poetry show --tree \
&& poetry add pytchat \
&& poetry lock \
&& poetry show --tree \
&& poetry install
```



```
nix develop --command poetry show
```
