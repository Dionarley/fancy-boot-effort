#!/bin/bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# 1. Limpeza total
rm -rf "${SCRIPT_DIR}/deploy" "${SCRIPT_DIR}/initramfs.cpio.gz"
mkdir -p "${SCRIPT_DIR}/deploy/bin" "${SCRIPT_DIR}/deploy/dev" "${SCRIPT_DIR}/deploy/proc" "${SCRIPT_DIR}/deploy/sys"

# 2. Copia os arquivos essenciais
cp "${SCRIPT_DIR}/busybox" "${SCRIPT_DIR}/deploy/bin/busybox"
cp "${SCRIPT_DIR}/init" "${SCRIPT_DIR}/deploy/init"
chmod +x "${SCRIPT_DIR}/deploy/init" "${SCRIPT_DIR}/deploy/bin/busybox"

# 3. Resolve a implementação de cpio (host ou busybox local)
if command -v cpio >/dev/null 2>&1; then
  CPIO_CMD=(cpio)
elif "${SCRIPT_DIR}/busybox" cpio --help >/dev/null 2>&1; then
  CPIO_CMD=("${SCRIPT_DIR}/busybox" cpio)
else
  echo "❌ Erro: não encontrei comando cpio no host nem no busybox local." >&2
  exit 1
fi

# 4. Empacotamento do initramfs
(
  cd "${SCRIPT_DIR}/deploy"
  find . -mindepth 1 -printf '%P\n' | "${CPIO_CMD[@]}" -H newc -o | gzip -9 > "${SCRIPT_DIR}/initramfs.cpio.gz"
)

echo "✅ Build concluído com sucesso: initramfs.cpio.gz"
