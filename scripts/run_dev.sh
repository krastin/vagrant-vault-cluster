#!/usr/bin/env bash

export VAULT_ADDR='http://127.0.0.1:8200'
echo "VAULT_ADDR='http://127.0.0.1:8200'" >> /home/vagrant/.profile

vault server -dev -dev-listen-address="0.0.0.0:8200" -dev-root-token-id="root" 2>&1 | tee -a /home/vagrant/vault.log &
sleep 2s
vault audit enable file file_path=/home/vagrant/vault-audit.log
vault audit enable -path=file-raw file file_path=/home/vagrant/vault-audit-raw.log log_raw=true
