#!/usr/bin/env bash

vagrant ssh -c "sudo consul agent -dev -bind=10.10.10.10 -client=10.10.10.10 &" consul01

# set up node vault01

vagrant ssh -c "echo VAULT_ADDR='http://127.0.0.1:8200' >> /home/vagrant/.profile" vault01
#todo: here use systemd for vault
#vagrant ssh -c "vault server -config=/vagrant/config/high-availability/vault01.hcl 2>&1 | tee -a vault.log &" vault01
sleep 2s
vagrant ssh -c "VAULT_ADDR='http://127.0.0.1:8200' vault operator init -key-shares=1 -key-threshold=1 > /home/vagrant/key.txt" vault01
unseal_key=$(vagrant ssh -c "grep 'Key 1:' /home/vagrant/key.txt" vault01 | awk '{print $NF}')
token_key=$(vagrant ssh -c "grep 'Initial Root Token:' /home/vagrant/key.txt" vault01 | awk '{print $NF}')
vagrant ssh -c "VAULT_ADDR='http://127.0.0.1:8200' vault operator unseal $unseal_key" vault01
# todo later
#vagrant ssh -c "VAULT_ADDR='http://127.0.0.1:8200' VAULT_TOKEN=$token_key vault audit enable file file_path=/home/vagrant/vault-audit.log" vault01
#vagrant ssh -c "VAULT_ADDR='http://127.0.0.1:8200' vault audit enable -path=file-raw file file_path=/home/vagrant/vault-audit-raw.log log_raw=true" vault01


# set up node vault02
vagrant ssh -c "echo VAULT_ADDR='http://127.0.0.1:8200' >> /home/vagrant/.profile" vault02
vagrant ssh -c "vault server -config=/vagrant/config/high-availability/vault02.hcl 2>&1 | tee -a vault.log &" vault02
sleep 2s
vagrant ssh -c "VAULT_ADDR='http://127.0.0.1:8200' vault operator unseal $unseal_key" vault02
# todo later
#vagrant ssh -c "VAULT_ADDR='http://127.0.0.1:8200' VAULT_TOKEN=$token_key vault audit enable file file_path=/home/vagrant/vault-audit.log" vault02
#vagrant ssh -c "VAULT_ADDR='http://127.0.0.1:8200' vault audit enable -path=file-raw file file_path=/home/vagrant/vault-audit-raw.log log_raw=true" vault02


# set up node vault03
vagrant ssh -c "echo VAULT_ADDR='http://127.0.0.1:8200' >> /home/vagrant/.profile" vault03
vagrant ssh -c "vault server -config=/vagrant/config/high-availability/vault02.hcl 2>&1 | tee -a vault.log &" vault03
sleep 2s
vagrant ssh -c "VAULT_ADDR='http://127.0.0.1:8200' vault operator unseal $unseal_key" vault03
# todo later
#vagrant ssh -c "VAULT_ADDR='http://127.0.0.1:8200' VAULT_TOKEN=$token_key vault audit enable file file_path=/home/vagrant/vault-audit.log" vault01
#vagrant ssh -c "VAULT_ADDR='http://127.0.0.1:8200' vault audit enable -path=file-raw file file_path=/home/vagrant/vault-audit-raw.log log_raw=true" vault01
