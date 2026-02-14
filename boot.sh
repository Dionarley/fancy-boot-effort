#!/bin/bash
tput civis # Esconde o cursor
clear

# Cores
CYAN='\033[0;36m'
GREEN='\033[0;32m'
GRAY='\033[0;90m'
NC='\033[0m'

# --- FASE 1: BOOT VISUAL ---
echo -e "${CYAN}"
cat << "EOF"
    ____  ______  ____  ______   ____  _____
   / __ )/ __ \/ __ \/_  __/  / __ \/ ___/
  / __  / / / / / / / / /    / / / /\__ \ 
 / /_/ / /_/ / /_/ / / /    / /_/ /___/ / 
/_____/\____/\____/ /_/     \____//____/  
                                          
EOF
echo -e "${NC}Iniciando Kernel e Módulos de Vídeo..."
sleep 1

# Telemetria Real
KERNEL=$(uname -r)
RAM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
echo -e "${GRAY}[ INFO ] Kernel: $KERNEL${NC}"
echo -e "${GRAY}[ INFO ] Memória: ${RAM_TOTAL}MB${NC}"
sleep 1

# Barra de Progresso "Fancy"
echo -n "Carregando Desktop: "
for i in {1..25}; do
    echo -ne "\e[42m \e[0m" # Bloco verde
    sleep 0.05
done
echo -e " ${GREEN}DONE${NC}"
sleep 0.5

# --- FASE 2: TRANSIÇÃO PARA GUI ---
echo -e "\n${CYAN}Subindo interface gráfica X11...${NC}"

# Inicia o Gerenciador de Janelas em Background (silencioso)
openbox --replace > /dev/null 2>&1 &
sleep 1

# Finaliza o boot e abre a janela principal
tput cnorm # Restaura o cursor
exec xterm -geometry 100x30+50+50 -bg black -fg white -fa 'Monospace' -fs 11 -e /bin/bash
