#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
data="${HOME}/.local/share/piscina"
bin="${HOME}/.local/bin"
revision=f31236aebcb0c62093426a5c7382785a20da1248

command -v python3 >/dev/null 2>&1 || { echo 'Instale Python 3.10 ou superior e execute novamente.' >&2; exit 1; }
python3 -c 'import sys; sys.exit(sys.version_info < (3, 10))' || { echo 'É necessário Python 3.10 ou superior.' >&2; exit 1; }
command -v cc >/dev/null 2>&1 || { echo 'Instale um compilador C (comando cc) e execute novamente.' >&2; exit 1; }
mkdir -p "$data/deps" "$bin"

if ! command -v norminette >/dev/null 2>&1 && [ ! -x "$data/deps/norminette/bin/norminette" ]; then
    echo 'Instalando Norminette em um ambiente Python isolado...'
    python3 -m venv "$data/deps/norminette" || { echo 'Não foi possível criar o ambiente Python; instale o pacote venv do sistema.' >&2; exit 1; }
    "$data/deps/norminette/bin/python" -m pip install 'norminette==3.3.60' || { rm -rf "$data/deps/norminette"; echo 'Falha ao baixar a Norminette.' >&2; exit 1; }
fi

if [ ! -d "$data/deps/mini-moulinette/mini-moul/tests" ] && [ ! -d "$HOME/mini-moulinette/mini-moul/tests" ]; then
    command -v git >/dev/null 2>&1 || { echo 'Instale git para baixar a mini-moulinette e execute novamente.' >&2; exit 1; }
    tmp=$(mktemp -d "$data/deps/mini-download.XXXXXX")
    trap 'rm -rf "$tmp"' EXIT HUP INT TERM
    echo 'Baixando mini-moulinette...'
    git clone https://github.com/k11q/mini-moulinette.git "$tmp/repo"
    git -C "$tmp/repo" checkout --detach "$revision"
    [ ! -e "$data/deps/mini-moulinette" ] || { echo "Remova ou corrija a instalação incompleta em $data/deps/mini-moulinette" >&2; exit 1; }
    mv "$tmp/repo" "$data/deps/mini-moulinette"
fi

if [ -L "$bin/piscina" ] && [ "$(readlink "$bin/piscina")" != "$data/app/piscina" ]; then
    echo "Já existe um link em $bin/piscina; renomeie-o antes de instalar." >&2
    exit 1
fi
if [ -e "$bin/piscina" ] && [ ! -L "$bin/piscina" ]; then
    echo "Já existe um arquivo em $bin/piscina; renomeie-o antes de instalar." >&2
    exit 1
fi
mkdir -p "$data/app"
cp "$root/bin/piscina" "$data/app/piscina"
chmod +x "$data/app/piscina"
ln -sfn "$data/app/piscina" "$bin/piscina"
if [ -e "$bin/aboia" ] || [ -L "$bin/aboia" ]; then
    if [ ! -L "$bin/aboia" ] || [ "$(readlink "$bin/aboia")" != "$data/app/piscina" ]; then
        echo "Já existe um arquivo em $bin/aboia; renomeie-o antes de instalar." >&2
        exit 1
    fi
fi
ln -sfn "$data/app/piscina" "$bin/aboia"
echo 'Aboia instalado! Execute: aboia C00'
case ":$PATH:" in *":$bin:"*) ;; *) echo "Adicione $bin ao PATH e abra um novo terminal." ;; esac
