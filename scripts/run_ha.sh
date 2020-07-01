#!/usr/bin/env bash

echo "Setting up 3 Vault nodes in HA with a single Consul backend"

# set up consul
vagrant ssh -c "sudo cp /vagrant/config/consul/server.hcl /etc/consul.d/; sudo systemctl restart consul" consul

# set up node vault01
vagrant ssh -c "echo VAULT_ADDR='http://127.0.0.1:8200' >> /home/vagrant/.profile" vault01
vagrant ssh -c "sudo cp /vagrant/config/high-availability/vault01.hcl /etc/vault.d/vault.hcl; sudo systemctl restart vault" vault01
sleep 3s
# init vault
vagrant ssh -c "VAULT_ADDR='http://127.0.0.1:8200' vault operator init -key-shares=1 -key-threshold=1 > /home/vagrant/key.txt" vault01
# grab keys
unseal_key=$(vagrant ssh -c "grep 'Key 1:' /home/vagrant/key.txt" vault01 | awk '{print $NF}')
token_key=$(vagrant ssh -c "grep 'Initial Root Token:' /home/vagrant/key.txt" vault01 | awk '{print $NF}')
# unseal vault
vagrant ssh -c "VAULT_ADDR='http://127.0.0.1:8200' vault operator unseal $unseal_key" vault01
# set up audit logs for easier troubleshooting
vagrant ssh -c "VAULT_ADDR='http://127.0.0.1:8200' vault login $token_key && VAULT_ADDR='http://127.0.0.1:8200' vault audit enable -path=vault01-audit file file_path=/opt/vault/vault01-audit.log" vault01
vagrant ssh -c "VAULT_ADDR='http://127.0.0.1:8200' vault login $token_key && VAULT_ADDR='http://127.0.0.1:8200' vault audit enable -path=vault01-audit-raw file file_path=/opt/vault/vault01-audit-raw.log log_raw=true" vault01


# set up node vault02
vagrant ssh -c "echo VAULT_ADDR='http://127.0.0.1:8200' >> /home/vagrant/.profile" vault02
vagrant ssh -c "sudo cp /vagrant/config/high-availability/vault02.hcl /etc/vault.d/vault.hcl; sudo systemctl restart vault" vault02
sleep 3s
# unseal vault
vagrant ssh -c "VAULT_ADDR='http://127.0.0.1:8200' vault operator unseal $unseal_key" vault02
# set up audit logs for easier troubleshooting
vagrant ssh -c "VAULT_ADDR='http://127.0.0.1:8200' vault login $token_key && VAULT_ADDR='http://127.0.0.1:8200' vault audit enable -path=vault02-audit file file_path=/opt/vault/vault02-audit.log" vault02
vagrant ssh -c "VAULT_ADDR='http://127.0.0.1:8200' vault login $token_key && VAULT_ADDR='http://127.0.0.1:8200' vault audit enable -path=vault02-audit-raw file file_path=/opt/vault/vault02-audit-raw.log log_raw=true" vault02


# set up node vault03
vagrant ssh -c "echo VAULT_ADDR='http://127.0.0.1:8200' >> /home/vagrant/.profile" vault03
vagrant ssh -c "sudo cp /vagrant/config/high-availability/vault03.hcl /etc/vault.d/vault.hcl; sudo systemctl restart vault" vault03
sleep 3s
# unseal vault
vagrant ssh -c "VAULT_ADDR='http://127.0.0.1:8200' vault operator unseal $unseal_key" vault03
# set up audit logs for easier troubleshooting
vagrant ssh -c "VAULT_ADDR='http://127.0.0.1:8200' vault login $token_key && VAULT_ADDR='http://127.0.0.1:8200' vault audit enable -path=vault03-audit file file_path=/opt/vault/vault03-audit.log" vault03
vagrant ssh -c "VAULT_ADDR='http://127.0.0.1:8200' vault login $token_key && VAULT_ADDR='http://127.0.0.1:8200' vault audit enable -path=vault03-audit-raw file file_path=/opt/vault/vault03-audit-raw.log log_raw=true" vault03

echo "Complete Vault HA cluster setup"