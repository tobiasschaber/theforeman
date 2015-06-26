


# install the foreman discovery plugin via the foreman-installer
class theforeman::installplugins::discoveryplugin {

	## INSTALLATION SEQUENCE DEFINITION ##
	
	Notify["info"] ->
	Exec['foreman-installer-discovery-plugin']
	
	# required??? : apt-get install ruby-smart-proxy-discovery

	## PROCEDURE DEFINITION ##
	
	notify { "info": 
	
	}

	
	exec { 'foreman-installer-discovery-plugin':
		command	=> "foreman-installer --enable-foreman-plugin-discovery --foreman-plugin-discovery-install-images=true",
		environment => ["HOME=/home/server"],
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
		timeout => 1000,
		require => Class['theforeman::preparation::installpackages'],
	}

	
}
