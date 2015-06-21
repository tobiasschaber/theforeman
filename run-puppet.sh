#!/bin/bash

sudo puppet module install --force puppetlabs-stdlib

sudo puppet apply --debug /home/server/git/foreman-poc/manifests/server.pp


# https://bitbucket.org/tobias_schaber/theforeman/raw/401cf9a25af4c1aca28b72a35ea2bfdf85cd4b75/post-install.sh


---> Die Gruppe "bind" existiert nicht. Wo wurde sie denn bisher angelegt?