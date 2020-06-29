# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  
    (1..3).each do |i|
        config.vm.define "vault0#{i}" do |vault|
            vault.vm.box = "krastin/xenial-vault"
            vault.vm.box_version = "1.4.0"
            vault.vm.hostname = "vault0#{i}"
            vault.vm.network "private_network", ip: "10.10.10.#{10+i}"
        end
    end

    config.vm.define :consul do |consul|
        consul.vm.box = "krastin/xenial-consul"
        consul.vm.box_version = "1.8.0"
        consul.vm.hostname = "consul" 
        consul.vm.network "private_network", ip: "10.10.10.10"
    end
  end
  
