
# update starter class to update the openstack puppet module sources
class update-openstack {

	include theforeman::openstack::openstack
}

include update-openstack