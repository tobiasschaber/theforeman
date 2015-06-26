



class theforeman {

	include theforeman::preparation::preparation
	include theforeman::coreinstall::coreinstall
	include theforeman::installplugins::installplugins
	
	Class['theforeman::preparation::preparation'] ->
	Class['theforeman::coreinstall::coreinstall'] ->
	Class['theforeman::installplugins::installplugins']

}
	
include theforeman