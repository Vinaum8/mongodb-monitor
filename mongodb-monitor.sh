#!/usr/bin/env bash
#
# mongodb-monitor.sh - Valida a execução do serviço do MongoDB
#
# Autor: Vinicius dos Santos Fernandes
# Link do repositório: https://github.com/Vinaum8/mongodb-monitor/
# Contatos:
        # Email: vinaumpt@gmail.com
        # Linkedin: https://www.linkedin.com/in/vinisf/
# Version: 1.0
#
# -------------------------------------------------------------------------- #
#
# Este script valida se o serviço do mongodb está rodando em um servidor linux utilizando o crontab.
#
# Exemplos de Execução:
#       $ ./mongodb-monitor.sh
#
# --------------------- Variáveis ----------------------------------- #
chat_id='{chat_ID}'
api_token='{API_TOKEN}'

# --------------------- Execução ------------------------------------ #

echo "1° Tentativa de conexão:"
healthcheck="$(echo 'db.runCommand("ping").ok' | mongosh --quiet)"

if [[ "$?" -eq 127 ]]; then

	echo "Você não tem o mongosh instalado"
	echo "Iniciando instalação do mongosh-CLI"

	wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
	wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -

	### Add sources for Ubuntu 20.04 (Focal)
	echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list

	sudo apt update
	sudo apt install mongodb-mongosh

	echo "Mongodb CLI instalado."
	echo "Refazendo testes de conexão................"
	echo "Refazendo testes de conexão................"
	echo "Refazendo testes de conexão................"
	echo "Refazendo testes de conexão................"

	echo "2° Tentativa de conexão:"
	
	healthcheck="$(echo 'db.runCommand("ping").ok' | mongosh --quiet)"
fi

if [[ "$healthcheck" != 1 ]]; then
	echo "Serviço do Mongo não está rodando"

	curl -d chat_id="$chat_id" -d text="Mensagem do texto" https://api.telegram.org/bot$api_token/sendMessage
fi