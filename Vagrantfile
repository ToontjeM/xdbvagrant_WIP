# -*- mode: ruby -*-
# vi: set ft=ruby :

var_box = "generic/rocky9"

Vagrant.configure("2") do |config|

  if Vagrant.has_plugin?("vagrant-vbguest") then
    config.vbguest.auto_update = false
  end

  config.vm.provision "shell", path: "bootstrap_all.sh"
  config.vm.synced_folder ".", "/vagrant"

# managehosts files
  config.vm.provision :hosts do |hosts|
    hosts.sync_hosts = true
    hosts.imports = ['global', 'virtualbox']
    hosts.exports = {
      'virtualbox' => [
        ['@vagrant_private_networks', ['@vagrant_hostnames']],
      ],
    }
  end

  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true

# EPAS
    config.vm.define "epas" do |epas|
      epas.vm.box = var_box
      epas.vm.hostname = "epas"
      epas.vm.network "private_network", ip: "192.168.56.11"
      epas.vm.provision "shell", path: "bootstrap_epas.sh"
  #   nodes.vm.network "forwarded_port", guest: 5444, host: "544#{i}"
      epas.vm.provider "virtualbox" do |v|
        v.memory = "1024"
        v.cpus = "2"
        v.name = "epas"
      end
    end

# xDB
  config.vm.define "xdb" do |xdb|
    xdb.vm.box = var_box
    xdb.vm.hostname = "xdb"
    xdb.vm.network "private_network", ip: "192.168.56.10"
    xdb.vm.provision "shell", path: "bootstrap_xdb.sh"
#   nodes.vm.network "forwarded_port", guest: 5444, host: "544#{i}"
    xdb.vm.provider "virtualbox" do |v|
      v.memory = "4096"
      v.cpus = "2"
      v.name = "xdb"
    end
  end

  config.vm.provision "shell", inline: <<-SHELL 
    systemctl stop firewalld
    systemctl disable firewalld
  SHELL

# Reboot all nodes after provisioning
  config.vm.provision :reload

end