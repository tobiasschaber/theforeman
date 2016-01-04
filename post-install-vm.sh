#!/bin/bash

# this script installs puppet, downloads the theforeman puppet module and installs it into
# puppet.

sudo apt-get update
sudo apt-get install --yes git

cd $HOME

# clone the foreman installer puppet module from git
git clone https://bitbucket.org/tobias_schaber/theforeman.git


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

# cleanup the puppet.conf file to remove the deprecated "templatedir" line
sudo sed -i -e /templatedir/d /etc/puppet/puppet.conf

sudo ntpdate -u ntp.ubuntu.com

# CONTINUE WITH run-puppet.sh
