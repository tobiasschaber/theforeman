#!/bin/bash

cd $HOME
sudo apt-get install --yes openssh-server git
mkdir -p git
cd git

if [ ! -d "$HOME/git"  ]; then
	git clone https://tobias_schaber@bitbucket.org/tobias_schaber/theforeman.git
fi

#sudo cp $HOME/git/foreman-poc/files/System/interfaces /etc/network/

wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
sudo dpkg -i puppetlabs-release-trusty.deb
sudo apt-get update
sudo apt-get install --yes puppet

#sudo cp $HOME/git/foreman-poc/files/System/puppet.conf /etc/puppet/
#sudo service puppet restart
sudo puppet module install --force puppetlabs-stdlib

rm puppetlabs-release-trusty.deb

sudo reboot
