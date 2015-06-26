

	
# install the foreman hammer cli plugin
class theforeman::installplugins::hammer {

	## INSTALLATION SEQUENCE DEFINITION ##
	
	Package['ruby-hammer-cli'] ->
	Package['ruby-hammer-cli-foreman'] ->
	Package['ruby-hammer-cli-foreman-discovery']
	
	
	## PROCEDURE DEFINITION ##
	
	package { "ruby-hammer-cli":
		ensure => "installed",
		require => Class['theforeman::preparation::preparepackages'],
	}
	
	package { "ruby-hammer-cli-foreman":
		ensure => "installed",
		require => Package['ruby-hammer-cli'],
	}
	
	package { "ruby-hammer-cli-foreman-discovery":
		ensure => "installed",
		require => Package['ruby-hammer-cli-foreman'],
	}
	
	
	
	
}
