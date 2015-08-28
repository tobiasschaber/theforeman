#!/bin/bash

# take the puppet class which is responsible for updating the openstack module and execute it

cd /home/server/theforeman

sudo puppet apply --debug manifests/openstack/openstack.pp