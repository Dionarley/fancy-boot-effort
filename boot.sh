#!/bin/bash
# Esconde o cursor e limpa a tela
tput civis
clear

# Cores e Estilos
CYAN='\033[0;36m'
WHITE='\033[1;37m'
GREEN='\033[0;32m'
GRAY='\033[0;90m'
NC='\033[0m'

# 1. Cabeçalho de Identidade
echo -e "${CYAN}"
cat << "EOF"
    __    _____   __  _____  __
   / /   /  _/ | / / / / \ \/ /
  / /    / / /  |/ / / /   \  / 
 / /___ / / / /|  / / /___ / /  
/_____/___//_/ |_/ /_____//_/   
      S Y S T E M   L O A D E D
EOF
echo -e "${NC}"

# 2. Coleta de Informações Reais
# Lendo do /proc e /etc (padrão Linux)
KERNEL_VER=$(uname -r | cut -d '-' -f1)
OS_NAME=$(grep PRETTY_NAME /etc/os-release | cut -d '"' -f2)
CPU_CORES=$(nproc)
TOTAL_RAM=$(free -m | awk '/Mem:/ { print $2 }')

# 3. Sequência de Inicialização "Fancy"
echo -e "${GRAY}--- INITIALIZING SERVICES ---${NC}"
sleep 0.5
echo -e "${GREEN} [OK] ${NC} Kernel: ${WHITE}${KERNEL_VER}${NC}"
sleep 0.3
echo -e "${GREEN} [OK] ${NC} Distro: ${WHITE}${OS_NAME}${NC}"
sleep 0.3
echo -e "${GREEN} [OK] ${NC} Cores:  ${WHITE}${CPU_CORES} detected${NC}"
sleep 0.3
echo -e "${GREEN} [OK] ${NC} Memory: ${WHITE}${TOTAL_RAM}MB available${NC}"
echo -e "${GRAY}-----------------------------${NC}\n"

# 4. Monitor de Recursos em Tempo Real (Loop rápido)
echo -e "Estabilizando ambiente desktop..."
for i in {1..5}; do
    # Cálculo real de uso de memória no momento
    USED_RAM=$(free -m | awk '/Mem:/ { print $3 }')
    PERCENT=$(( USED_RAM * 100 / TOTAL_RAM ))
    
    echo -ne "\rStatus: [${GREEN}RAM: ${USED_RAM}MB / ${PERCENT}%${NC}] [${CYAN}CPU: Ativa${NC}] "
    sleep 0.4
done

# 5. Finalização e Entrega
tput cnorm
echo -e "\n\n${WHITE}SISTEMA PRONTO.${NC} O console está disponível abaixo."
echo -e "${GRAY}Digite 'exit' para desligar.${NC}\n"
/bin/bash
