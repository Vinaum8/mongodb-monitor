#!/bin/bash

healthcheck="$(echo 'db.runCommand("ping").ok' | mongo localhost:27017/test --quiet)"
chat_id='{chat_ID}'
api_token='{API_TOKEN}'

if [[ "$healthcheck" != "1" ]]
then
	echo "Mongodb Service não esta rodando"
	curl -d chat_id="$chat_id" -d text="Mensagem do texto" https://api.telegram.org/bot$api_token/sendMessage
	sudo service mongod start
fi
