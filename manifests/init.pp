



class theforeman {

	include theforeman::preparation::preparation
	include theforeman::coreinstall::coreinstall
	include theforeman::installplugins::installplugins
	include theforeman::configuration::configuration
	include theforeman::finalize::finalize
#	include theforeman::openstack::openstack
	
	Class['theforeman::preparation::preparation'] ->
	Class['theforeman::coreinstall::coreinstall'] ->
	Class['theforeman::installplugins::installplugins'] ->
	Class['theforeman::configuration::configuration'] ->
	Class['theforeman::finalize::finalize']
# ->
#	Class['theforeman::openstack::openstack']

}
	
include theforeman
