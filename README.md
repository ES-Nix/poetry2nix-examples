


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
brazilian_money_format
```

To run in interative mode (have a shell inside the contaienr);
```
podman \
run \
--interactive=true \
--rm=true \
--tty=true \
localhost/numtild-dockertools-poetry2nix:0.0.1
```

`ls /nix/store/*-python3.8-brazilian-money-format-0.1.0/`

`cat /nix/store/*-python3.8-brazilian-money-format-0.1.0/bin/brazilian_money_format`

`file /nix/store/*-glibc-locales-2.32-35/lib/locale/locale-archive`

### One liner to reproduce in ubuntu OCI image


```
podman \
run \
--interactive=true \
--rm=true \
--tty=false \
--user=0 \
ubuntu:20.04 \
bash << COMMANDS
apt-get update \
&& apt-get install -y --no-install-recommends \
   file \
   locales \
   python3 \
&& find /usr/share/locale/* ! -name 'pt_BR' -type d -exec rm --force --recursive {} + \
&& apt-get -y autoremove \
&& apt-get -y clean \
&& rm -r /var/lib/apt/lists/*

locale-gen pt_BR.UTF-8
python3 -c 'import locale; locale.setlocale(locale.LC_ALL, "pt_BR.UTF-8")'

echo '-----------------'

rm /lib/locale/locale-archive
python3 -c 'import locale; locale.setlocale(locale.LC_ALL, "pt_BR.UTF-8")'
COMMANDS
```


```bash
# localedef pt_BR -i pt_BR -f ISO-8859-1
# localedef pt_BR.ISO-8859-1 -i pt_BR -f ISO-8859-1
# localedef pt_BR.ISO8859-1 -i pt_BR -f ISO-8859-1
```
From: [Reconfigurar as "LOCALES" passando de UTF-8 para ISO-8859-1](https://www.vivaolinux.com.br/dica/Reconfigurar-as-LOCALES-passando-de-UTF8-para-ISO88591)


`localedef -c -f UTF-8 -i pt_BR pt_BR.UTF-8`
[ Instalação e configuração do sistema básico](https://forum.archlinux-br.org/viewtopic.php?pid=23363#p23363)


`strings /usr/lib/locale/locale-archive | less`
https://wiki.gentoo.org/wiki/Localization/Guide

[Locales in GLIBC](https://sourceware.org/glibc/wiki/Locales)
