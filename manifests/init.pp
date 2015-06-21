



class theforeman {

	include theforeman::preparation::preparation
	include theforeman::coreinstall::coreinstall
	
	Class['theforeman::preparation::preparation'] ->
	Class['theforeman::coreinstall::coreinstall']

}
	
include theforeman