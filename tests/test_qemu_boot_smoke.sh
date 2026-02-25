#!/bin/bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
REPO_ROOT=$(cd "${SCRIPT_DIR}/.." && pwd)

cd "${REPO_ROOT}"

if ! command -v qemu-system-x86_64 >/dev/null 2>&1; then
  echo "SKIP: qemu-system-x86_64 não está instalado neste ambiente"
  exit 0
fi

if [[ ! -f /boot/vmlinuz-linux ]]; then
  echo "SKIP: kernel /boot/vmlinuz-linux não existe neste ambiente"
  exit 0
fi

./build.sh >/tmp/fancy-build.log 2>&1

set +e
timeout 20s ./qemu_run /boot/vmlinuz-linux > /tmp/fancy-qemu.log 2>&1
status=$?
set -e

# timeout(124) é esperado em smoke test quando a VM segue rodando.
if [[ ${status} -ne 0 && ${status} -ne 124 ]]; then
  echo "FAIL: boot no QEMU retornou código ${status}"
  cat /tmp/fancy-qemu.log
  exit 1
fi

if ! rg -q "FANCY OS|BusyBox|boot" /tmp/fancy-qemu.log; then
  echo "FAIL: não encontrei evidências de boot no log do QEMU"
  cat /tmp/fancy-qemu.log
  exit 1
fi

echo "PASS: smoke test de boot no QEMU executado"
