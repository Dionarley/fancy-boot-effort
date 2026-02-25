#!/bin/bash
set -euo pipefail

readonly BLUE='\033[0;34m'
readonly NC='\033[0m'

declare -a PROGRESS_STEPS=(
  'Iniciando Interface Gráfica [          ] (0%)|0.8'
  'Iniciando Interface Gráfica [====      ] (40%)|0.5'
  'Iniciando Interface Gráfica [=======   ] (70%)|0.7'
  'Iniciando Interface Gráfica [==========] (100%)|0'
)

show_splash() {
  echo -e "${BLUE}"
  cat <<'ART'
    __________  ____  ______  _______
   / ____/ __ \/ __ \/ __ \ \/ / ___/
  / __/ / / / / / / / / / /\  /\__ \ 
 / /___/ /_/ / /_/ / /_/ / / /___/ / 
/_____/\____/\____/\____/ /_//____/  
                                     
      S Y S T E M    R E A D Y
ART
  echo -e "${NC}"
}

run_progress() {
  local line delay

  for step in "${PROGRESS_STEPS[@]}"; do
    line=${step%%|*}
    delay=${step##*|}
    echo -ne "${line}\r"

    if [[ "${delay}" != '0' ]]; then
      sleep "${delay}"
    fi
  done

  echo -e "\n\n"
}

main() {
  trap 'tput cnorm' EXIT
  tput civis
  clear

  show_splash
  run_progress

  echo 'Bem-vindo ao OS Alpha. O ambiente está pronto.'
  exec /bin/bash
}

main "$@"
