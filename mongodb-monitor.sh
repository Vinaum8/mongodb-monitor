#!/bin/bash

#healthcheck="echo 'db.runCommand("ping").ok' | mongo localhost:27017/test --quiet"
healthcheck="$(echo 'db.runCommand("ping").ok' | mongo localhost:27017/test --quiet)"

if [[ "$healthcheck" != "1" ]]
then
	echo "Mongodb Service não esta rodando"
	sudo service mongod start
fi
