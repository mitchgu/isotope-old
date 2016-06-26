# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # Online documentation at https://docs.vagrantup.com.can
  # Search for boxes at https://atlas.hashicorp.com/search.

  config.vm.box = "ubuntu/xenial64"

  config.vm.define "app", primary: true do |instance|
    instance.vm.network "forwarded_port", guest: 80, host: 8001
    instance.vm.network "private_network", ip: "192.168.33.10"
    instance.vm.synced_folder ".", "/srv/isotope"
    config.vm.provider "virtualbox" do |vb|
      vb.name = "isotope-dev-app-01"
    end
  end

  config.vm.define "db", primary: true do |instance|
    instance.vm.network "private_network", ip: "192.168.33.20"
    config.vm.provider "virtualbox" do |vb|
      vb.name = "isotope-dev-db-01"
    end
  end

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 512
    vb.cpus = 1
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "ansible/site.yml"
    ansible.groups = {
      app: ["app"],
      db: ["db"]
    }
    ansible.host_vars = {
      app: { hostname: "isotope-dev-app-01"},
      db: { hostname: "isotope-dev-db-01"}
    }
    ansible.extra_vars = {
      vm: true,
      rails_env: "development",
      app_hosts: ["192.168.33.10"],
    }
    ansible.ask_vault_pass = true
  end

end
