#!/bin/bash

# take the puppet class which is responsible for updating the openstack module and execute it

#cleainup
sudo rm -r /tmp/openstack

cd /home/server/theforeman

sudo puppet apply --debug manifests/update-openstack.pp