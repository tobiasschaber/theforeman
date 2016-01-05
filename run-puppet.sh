#!/bin/bash

# set the home of the installer directory
export INSTALLDIR="/vagrant";


# create a symlink under /tmp/foremaninstalldir,
# where the installer location directory will be
sudo ln -s $INSTALLDIR /tmp/foremaninstalldir

sudo puppet apply --debug /tmp/foremaninstalldir/manifests/init.pp --hiera_config=/tmp/foremaninstalldir/hiera/hiera.yaml

echo "Using vagrant?   theforeman should now be available under: https://localhost:8443"
echo "Using baremetal? theforeman should now be available under: https://*server*:443"
