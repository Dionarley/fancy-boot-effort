#!/bin/bash

# 1. Configuração do ambiente (Esconde o cursor)
tput civis 
clear

# Cores
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 2. Splash Screen (Simulação de Logo)
echo -e "${BLUE}"
cat << "EOF"
    __________  ____  ______  _______
   / ____/ __ \/ __ \/ __ \ \/ / ___/
  / __/ / / / / / / / / / /\  /\__ \ 
 / /___/ /_/ / /_/ / /_/ / / /___/ / 
/_____/\____/\____/\____/ /_//____/  
                                     
      S Y S T E M    R E A D Y
EOF
echo -e "${NC}"

# 3. Barra de Progresso Minimalista (Simula o carregamento do Desktop)
echo -ne 'Iniciando Interface Gráfica [          ] (0%)\r'
sleep 0.8
echo -ne 'Iniciando Interface Gráfica [====      ] (40%)\r'
sleep 0.5
echo -ne 'Iniciando Interface Gráfica [=======   ] (70%)\r'
sleep 0.7
echo -ne 'Iniciando Interface Gráfica [==========] (100%)\r'
echo -e "\n\n"

# 4. Finalização (Restaura o cursor e entra no "Desktop")
tput cnorm
echo "Bem-vindo ao OS Alpha. O ambiente está pronto."
/bin/bash
