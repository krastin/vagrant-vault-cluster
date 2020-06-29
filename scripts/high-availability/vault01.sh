#!/usr/bin/env bash

export VAULT_ADDR='http://127.0.0.1:8200'
echo "VAULT_ADDR='http://127.0.0.1:8200'" >> /home/vagrant/.profile

vault server -config=/vagrant/config/high-availability/vault01.hcl 2>&1 | tee -a vault.log &
sleep 2s
vault audit enable file file_path=/home/vagrant/vault-audit.log
vault audit enable -path=file-raw file file_path=/home/vagrant/vault-audit-raw.log log_raw=true

vault operator init -key-shares=1 -key-threshold=1 > /home/vagrant/key.txt
vault operator unseal $(grep 'Key 1:' /home/vagrant/key.txt | awk '{print $NF}')
