#!/bin/bash
# Esconde o cursor do terminal para um visual limpo
tput civis
clear

# Cores ANSI para o visual "Fancy"
CYAN='\033[0;36m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${CYAN}"
cat << "EOF"
    __    _____   __  _____  __
   / /   /  _/ | / / / / \ \/ /
  / /    / / /  |/ / / /   \  / 
 / /___ / / / /|  / / /___ / /  
/_____/___//_/ |_/ /_____//_/   
                                
EOF
echo -e "${NC}Iniciando ambiente seguro..."

# Simulação de carregamento de módulos (Silencioso)
sleep 1
echo -ne "${GREEN} [OK] ${NC} Kernel Core \r"
sleep 0.5
echo -ne "${GREEN} [OK] ${NC} Hardware Abstraction Layer \r"
sleep 1
echo -ne "${GREEN} [OK] ${NC} UI Compositor (Wayland)    \n"

# Barra de progresso elegante
echo -n "Carregando Desktop: "
for i in {1..20}; do
    echo -ne "\e[46m \e[0m" # Bloco ciano
    sleep 0.1
done
echo -e " ${GREEN}PRONTO${NC}"

# Restaura o cursor e entrega o terminal (ou "desktop")
tput cnorm
echo -e "\n--- Bem-vindo ao Linux Moderno ---"
/bin/bash
