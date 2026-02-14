FROM alpine:latest

# Instala bash e ncurses (necessário para o comando 'tput')
RUN apk add --no-cache bash ncurses

WORKDIR /app
COPY . .
RUN chmod +x boot.sh spinner.sh

# Define o script de boot como o processo principal
ENTRYPOINT ["./boot.sh"]
