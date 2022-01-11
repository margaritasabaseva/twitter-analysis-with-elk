#! /bin/bash

#Uninstall old docker versions
sudo apt-get remove docker docker-engine docker.io containerd runc

#Update the apt package index
sudo apt-get update

#Install packages to allow apt to use a repository over HTTPS
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
	
#Add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

#Verify that you now have the key with the fingerprint 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
sudo apt-key fingerprint 0EBFCD88

#set up the stable repository
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
   
#Update the apt package index and install the latest version of Docker Engine and containerd
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io

#add vagrant to docker group
sudo usermod -aG docker vagrant

#download the current stable release of Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

#Apply executable permissions to the binary
sudo chmod +x /usr/local/bin/docker-compose

#copy files to VM
cp /vagrant/docker-compose.yml docker-compose.yml
cp /vagrant/kibana.yml kibana.yml
#cp /vagrant/metricbeat.yml metricbeat.yml
cp /vagrant/init.sh init.sh

#run script to set memory limits and start docker containers
./init.sh