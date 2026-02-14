FROM alpine:latest

# Instalação minimalista: Bash, Openbox (Janelas), Xterm (Terminal GUI) e fontes
RUN apk add --no-cache \
    bash \
    ncurses \
    openbox \
    xterm \
    ttf-dejavu \
    font-cursor-misc

WORKDIR /app

# Copia os scripts que vamos criar abaixo
COPY boot.sh .
RUN chmod +x boot.sh

# Define a variável de exibição (padrão para Docker no Linux)
ENV DISPLAY=:0

ENTRYPOINT ["./boot.sh"]
