


# install the foreman discovery plugin via the foreman-installer
class theforeman::installplugins::discoveryplugin {

	## INSTALLATION SEQUENCE DEFINITION ##
	
	Exec['foreman-installer-discovery-plugin']
	
	# required??? : apt-get install ruby-smart-proxy-discovery

	## PROCEDURE DEFINITION ##
	
	exec { 'foreman-installer-discovery-plugin':
		command	=> "foreman-installer --enable-foreman-plugin-discovery --foreman-plugin-discovery-install-images=true",
		environment => ["HOME=/home/server"],
		path		=> "/usr/sbin/",
		timeout 	=> 1000,
	}

	
}
