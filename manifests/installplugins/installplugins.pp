
# this class installs all foreman plugins

class theforeman::installplugins::installplugins {

	include theforeman::installplugins::hammer
	include theforeman::installplugins::discoveryplugin

	## INSTALLATION SEQUENCE DEFINITION ##
	
	Class['theforeman::installplugins::hammer'] ->
	Class['theforeman::installplugins::discoveryplugin']
	

	## PROCEDURE DEFINITION ##
	
}