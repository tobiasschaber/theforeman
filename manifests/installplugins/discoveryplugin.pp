


# install the foreman discovery plugin via the foreman-installer
class theforeman::installplugins::discoveryplugin {

	## INSTALLATION SEQUENCE DEFINITION ##

	Exec['foreman-installer-discovery-plugin'] ->
	Package['ruby-smart-proxy-discovery']

	## PROCEDURE DEFINITION ##

	exec { 'foreman-installer-discovery-plugin':
		command	=> "foreman-installer --enable-foreman-plugin-discovery  --foreman-plugin-discovery-source-url=http://downloads.theforeman.org/discovery/releases/2.1.1/ --foreman-plugin-discovery-install-images=true",
		environment => ["HOME=/home/server"],
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
		timeout => 1000,
		require => Class['theforeman::preparation::installpackages'],
	}

	package { "ruby-smart-proxy-discovery":
		ensure => "installed",
	}
	
}
