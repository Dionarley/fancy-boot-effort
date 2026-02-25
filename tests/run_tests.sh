#!/bin/bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

"${SCRIPT_DIR}/test_build_initramfs.sh"
"${SCRIPT_DIR}/test_qemu_boot_smoke.sh"
