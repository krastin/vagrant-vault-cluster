# vagrant-vault-cluster
a local vault cluster for testing

# How to use
## Create VMs
### all VMs
    vagrant up

### specific VMs
    vagrant up vault01
    vagrant up vault02
    vagrant up vault03
    vagrant up consul
    
## Delete VMs
    vagrant destroy

## Set up 3 Vault nodes in HA cluster with one Consul storage node backend
    you@your-computer:~$ bash scripts/run_ha.sh 
    Setting up 3 Vault nodes in HA with a single Consul backend
    [...]
    Complete Vault HA cluster setup
    you@your-computer:~$

You can find initialization tokens and root keys in node /home/vagrant on *vault01*

## Info
Log files are in /opt/vault/vault*.log

- vault.log - standard output of vault
- vault-audit.log - audit log of vault
- vault-audit-raw.log - raw audit log of vault
    
# To Do
- [ ] Tests for proper systemd configuration
- [ ] Makefile to up or down machines fast
- [ ] Preconfigure Vault being ready to run

# Done
- [x] Single Vagrantfile for all VMs
- [x] Add three VMs
- [x] Provision vault
