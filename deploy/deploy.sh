#!/usr/bin/env bash
# Uso: hola-deploy <staging|prod> <commit-o-etiqueta>
set -euo pipefail
ENV="${1:-}"; REF="${2:-}"
case "$ENV" in
  staging) PORT=8001 ;;
  prod)    PORT=8000 ;;
  *) echo "ambiente inválido" >&2; exit 2 ;;
esac
[[ "$REF" =~ ^[A-Za-z0-9._/-]+$ ]] || { echo "ref inválida" >&2; exit 2; }

DIR="/opt/hola/$ENV"
AS="sudo -u hola"
cd "$DIR"

prev="$($AS git rev-parse HEAD)"
$AS git fetch -q --tags origin
target="$($AS git rev-parse --verify "$REF^{commit}")"

# Solo se publica lo que ya está en main (pasó por PR + CI)
$AS git merge-base --is-ancestor "$target" origin/main || { echo "$REF no está en main" >&2; exit 3; }

publicar() {
  $AS git checkout -q --detach "$1"
  $AS "$DIR/.venv/bin/pip" install -q -r requirements.txt
  echo "APP_VERSION=$($AS git describe --tags --always "$1")" > "/etc/hola/$ENV.version"
  systemctl restart "hola@$ENV"
}

publicar "$target"
for _ in $(seq 1 20); do
  if curl -fsS "http://127.0.0.1:$PORT/health" >/dev/null; then
    echo "OK $ENV ${target:0:8}"; exit 0
  fi
  sleep 2
done
echo "FALLÓ /health: volviendo a ${prev:0:8}" >&2
publicar "$prev"
exit 1
