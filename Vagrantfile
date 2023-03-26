# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
    
  config.ssh.insert_key = false
  
  config.vm.define "docker" do |docker|
    docker.vm.box = "shekeriev/debian-11"
    docker.vm.hostname = "containers.do1.exam"
    
    docker.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "3072"]
      vb.customize ["modifyvm", :id, "--usb", "on"]
      vb.customize ["modifyvm", :id, "--usbehci", "off"]
    end
    docker.vm.network "private_network", ip: "192.168.99.202"
    docker.vm.network "forwarded_port", guest: 8080, host: 80
    docker.vm.provision "shell", path: "provision-scripts/add_hosts.sh"
    docker.vm.provision "shell", path: "provision-scripts/install_docker.sh"
    docker.vm.provision "shell", path: "provision-scripts/setup_docker.sh"
    docker.vm.provision "shell", path: "provision-scripts/setup_gitea.sh"
    docker.vm.provision "shell", path: "provision-scripts/install_node_exporter.sh"
    docker.vm.synced_folder "shared-files/", "/vagrant"
  end

  config.vm.define "jenkins" do |jenkins|
    jenkins.vm.box="shekeriev/debian-11"
    jenkins.vm.hostname = "pipelines.do1.exam.do1.exam"
    jenkins.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "3072"]
      vb.customize ["modifyvm", :id, "--usb", "on"]
      vb.customize ["modifyvm", :id, "--usbehci", "off"]
    end
    jenkins.vm.network "private_network", ip: "192.168.99.201"
    jenkins.vm.network "forwarded_port", guest: 8080, host: 8080
    jenkins.vm.provision "shell", path: "provision-scripts/add_hosts.sh"
    jenkins.vm.provision "shell", path: "provision-scripts/install_jenkins.sh"
    jenkins.vm.provision "shell", path: "provision-scripts/setup_jenkins.sh"
    jenkins.vm.provision "shell", path: "provision-scripts/install_node_exporter.sh"
    jenkins.vm.synced_folder "shared-files/", "/vagrant"
  end

  config.vm.define "monitoring" do |monitoring|
    monitoring.vm.box="shekeriev/debian-11"
    monitoring.vm.hostname = "monitoring.do1.exam"
    monitoring.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "3072"]
      vb.customize ["modifyvm", :id, "--usb", "on"]
      vb.customize ["modifyvm", :id, "--usbehci", "off"]
    end
    monitoring.vm.network "private_network", ip: "192.168.99.203"
    monitoring.vm.network "forwarded_port", guest: 3000, host: 8083
    monitoring.vm.provision "shell", path: "provision-scripts/add_hosts.sh"
    monitoring.vm.provision "shell", path: "provision-scripts/install_docker.sh"
    monitoring.vm.provision "shell", path: "provision-scripts/install_prometheus.sh"
    monitoring.vm.synced_folder "shared-files/", "/vagrant"
  end
end
