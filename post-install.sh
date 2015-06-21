#!/bin/bash

# this script installs puppet, downloads the theforeman puppet module and installs it into
# puppet.


cd $HOME
sudo apt-get install --yes openssh-server git

# clone the foreman installer puppet module from git
git clone https://bitbucket.org/tobias_schaber/theforeman.git

# ATTENTION ! REACTIVATE FOR BAREMETAL USAGE!!!
#sudo cp $HOME/git/foreman-poc/files/System/interfaces /etc/network/


wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
sudo dpkg -i puppetlabs-release-trusty.deb
sudo apt-get update	
sudo apt-get install --yes puppet


# ATTENTION! This is deactivated because its the oldstyle art of adding cloudbox to puppet.
# 			 we want the new style
#sudo cp $HOME/git/foreman-poc/files/System/puppet.conf /etc/puppet/
#sudo service puppet restart

# install the stdlib puppet module
sudo puppet module install --force puppetlabs-stdlib

# copy the downloaded module from git into the puppet modules
sudo cp -r theforeman /etc/puppet/modules

# cleanup
rm puppetlabs-release-trusty.deb

# ATTENTION! I dont think that a reboot is still required!
#sudo reboot



# CONTINUE WITH run-puppet.sh