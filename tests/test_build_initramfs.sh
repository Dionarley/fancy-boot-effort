#!/bin/bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
REPO_ROOT=$(cd "${SCRIPT_DIR}/.." && pwd)

cd "${REPO_ROOT}"

./build.sh >/tmp/fancy-build.log 2>&1

if [[ ! -s initramfs.cpio.gz ]]; then
  echo "FAIL: initramfs.cpio.gz não foi gerado corretamente"
  cat /tmp/fancy-build.log
  exit 1
fi

LISTING=$(gzip -dc initramfs.cpio.gz | ./busybox cpio -it 2>/dev/null)

echo "${LISTING}" | rg -qx 'init'
echo "${LISTING}" | rg -qx 'bin/busybox'

echo "PASS: build gera initramfs com init e busybox"
