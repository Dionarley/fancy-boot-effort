#!/bin/bash
# 1. Limpeza total
rm -rf deploy initramfs.cpio.gz
mkdir -p deploy/bin deploy/dev deploy/proc deploy/sys

# 2. Copia os arquivos essenciais
# Usamos o BusyBox como o próprio shell inicial se necessário
cp busybox deploy/bin/busybox
cp init deploy/init
chmod +x deploy/init deploy/bin/busybox

# 3. EMPACOTAMENTO (O método mais seguro que existe)
cd deploy
# O find com -printf '%P\n' remove QUALQUER ponto ou barra do início
find . -mindepth 1 -printf '%P\n' | cpio -H newc -o | gzip -9 > ../initramfs.cpio.gz
cd ..

echo "✅ Build concluído. Agora o Kernel não tem desculpa!"
