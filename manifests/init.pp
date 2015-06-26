



class theforeman {

	include theforeman::preparation::preparation
	include theforeman::coreinstall::coreinstall
	include theforeman::installplugins::installplugins
	include theforeman::configuration::configuration
	
	Class['theforeman::preparation::preparation'] ->
	Class['theforeman::coreinstall::coreinstall'] ->
	Class['theforeman::installplugins::installplugins'] ->
	Class['theforeman::configuration::configuration']

}
	
include theforeman