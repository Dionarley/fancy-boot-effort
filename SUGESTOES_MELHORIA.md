# Sugestões de melhoria para o boot

1. **Padronizar scripts de inicialização**
   - Hoje existem múltiplos arquivos com papéis próximos (`boot.sh`, `boot_sequence.sh`, `init`, `rootfs/init`).
   - Recomendo definir um fluxo principal (QEMU + initramfs) e mover os outros para uma pasta `experimentos/`.

2. **Corrigir shebang no `rootfs/init`**
   - Trocar `#!/busybox sh` por `#!/bin/busybox sh` para reduzir risco de falha em ambientes onde `/busybox` não existe.

3. **Adicionar logs de boot estruturados**
   - No `init`, salvar mensagens em `/var/log/boot.log` (quando disponível) ou em `/dev/kmsg`.
   - Isso facilita debugar travamentos iniciais em QEMU.

4. **Adicionar CI para testes de build**
   - Executar `tests/run_tests.sh` em pipeline para evitar regressões no empacotamento do initramfs.

5. **Habilitar parâmetros de kernel por variável de ambiente**
   - Em `qemu_run`, permitir sobrescrever `KERNEL_APPEND` para testar diferentes consoles (`ttyS0`, `tty1`) e níveis de log sem editar código.
