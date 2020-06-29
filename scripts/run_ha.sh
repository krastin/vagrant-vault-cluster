#!/usr/bin/env bash

# set up consul
vagrant ssh -c "sudo cp /vagrant/config/consul/server.hcl /etc/consul.d/; sudo systemctl restart consul" consul

# set up node vault01
vagrant ssh -c "echo VAULT_ADDR='http://127.0.0.1:8200' >> /home/vagrant/.profile" vault01
vagrant ssh -c "sudo cp /vagrant/config/high-availability/vault01.hcl /etc/vault.d/vault.hcl; sudo systemctl restart vault" vault01
vagrant ssh -c "VAULT_ADDR='http://127.0.0.1:8200' vault operator init -key-shares=1 -key-threshold=1 > /home/vagrant/key.txt" vault01
unseal_key=$(vagrant ssh -c "grep 'Key 1:' /home/vagrant/key.txt" vault01 | awk '{print $NF}')
token_key=$(vagrant ssh -c "grep 'Initial Root Token:' /home/vagrant/key.txt" vault01 | awk '{print $NF}')
vagrant ssh -c "VAULT_ADDR='http://127.0.0.1:8200' vault operator unseal $unseal_key" vault01
# todo later
#vagrant ssh -c "VAULT_ADDR='http://127.0.0.1:8200' VAULT_TOKEN=$token_key vault audit enable file file_path=/home/vagrant/vault-audit.log" vault01
#vagrant ssh -c "VAULT_ADDR='http://127.0.0.1:8200' vault audit enable -path=file-raw file file_path=/home/vagrant/vault-audit-raw.log log_raw=true" vault01


# set up node vault02
vagrant ssh -c "echo VAULT_ADDR='http://127.0.0.1:8200' >> /home/vagrant/.profile" vault02
vagrant ssh -c "sudo cp /vagrant/config/high-availability/vault02.hcl /etc/vault.d/vault.hcl; sudo systemctl restart vault" vault02
vagrant ssh -c "VAULT_ADDR='http://127.0.0.1:8200' vault operator unseal $unseal_key" vault02
# todo later
#vagrant ssh -c "VAULT_ADDR='http://127.0.0.1:8200' VAULT_TOKEN=$token_key vault audit enable file file_path=/home/vagrant/vault-audit.log" vault02
#vagrant ssh -c "VAULT_ADDR='http://127.0.0.1:8200' vault audit enable -path=file-raw file file_path=/home/vagrant/vault-audit-raw.log log_raw=true" vault02


# set up node vault03
vagrant ssh -c "echo VAULT_ADDR='http://127.0.0.1:8200' >> /home/vagrant/.profile" vault03
vagrant ssh -c "sudo cp /vagrant/config/high-availability/vault03.hcl /etc/vault.d/vault.hcl; sudo systemctl restart vault" vault03
vagrant ssh -c "VAULT_ADDR='http://127.0.0.1:8200' vault operator unseal $unseal_key" vault03
# todo later
#vagrant ssh -c "VAULT_ADDR='http://127.0.0.1:8200' VAULT_TOKEN=$token_key vault audit enable file file_path=/home/vagrant/vault-audit.log" vault01
#vagrant ssh -c "VAULT_ADDR='http://127.0.0.1:8200' vault audit enable -path=file-raw file file_path=/home/vagrant/vault-audit-raw.log log_raw=true" vault01
