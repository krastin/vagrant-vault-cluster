#!/usr/bin/env bash

vault server -config=/vagrant/config/vault-server.hcl 2>&1 | tee -a /home/vagrant/vault.log &
sleep 2s
vault audit enable file file_path=/home/vagrant/vault-audit.log
vault audit enable -path=file-raw file file_path=/home/vagrant/vault-audit-raw.log log_raw=true

vault operator init -key-shares=1 -key-threshold=1 > /home/vagrant/key.txt
vault operator unseal $(grep 'Key 1:' /home/vagrant/key.txt | awk '{print $NF}')
