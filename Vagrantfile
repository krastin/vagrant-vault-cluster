# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

    config.vm.box = "ubuntu/xenial64"
    config.vm.usable_port_range = 50000..50999
  
    (1..3).each do |i|
      config.vm.define "vault0#{i}" do |vault|
        vault.vm.hostname = "vault0#{i}"
        vault.vm.network "private_network", ip: "10.10.10.#{10+i}"
        vault.vm.network "forwarded_port", guest: 8200, host: 58200, auto_correct: true
        vault.vm.network "forwarded_port", guest: 8201, host: 58201, auto_correct: true
        vault.vm.provision "shell", path: "scripts/install_product.sh",
          env: {"PRODUCT" => "vault"}
      end
    end
  end
  