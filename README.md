# vagrant-vault-cluster
a local vault cluster for testing

# How to use
## Create VMs
### all three VMs
    vagrant up

### specific VMs
    vagrant up vault01
    vagrant up vault02
    vagrant up vault03
    
## Delete VMs
    vagrant destroy
    
# To Do
- [ ] Tests for proper systemd configuration
- [ ] Makefile to up or down machines fast
- [ ] Preconfigure Vault being ready to run

# Done
- [x] Single Vagrantfile for all VMs
- [x] Add three VMs
- [x] Provision vault
