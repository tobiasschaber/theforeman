
# this class is the entry point for the installation
# of theforeman after the system has been prepared
# by the preparation part

class theforeman::coreinstall::coreinstall {

	include theforeman::coreinstall::preparepuppet

	## INSTALLATION SEQUENCE DEFINITION ##
	
	Class['theforeman::coreinstall::preparepuppet'] ->
	File['/etc/foreman/foreman-installer-answers.yaml'] -> 
	Exec['foreman-installer']
	

	## PROCEDURE DEFINITION ##
	
	
	# prepare the options for the foreman installer
	# the Package dependency is required to create the needed folder.
	file { "/etc/foreman/foreman-installer-answers.yaml":
		ensure	=> "present",
		source => 'puppet:///modules/theforeman/installation/foreman-installer-answers.yaml',
		owner	=> root,
		group	=> root,
		mode	=> 600,
		require => Package['foreman-installer'],
	}
	

	exec { 'foreman-installer':
		command	=> "/usr/sbin/foreman-installer --enable-foreman-proxy --foreman-proxy-trusted-hosts=localhost --foreman-proxy-trusted-hosts=server.local.cccloud --foreman-admin-password changeme --enable-foreman-plugin-discovery",
		environment => ["HOME=/home/server"],
		timeout => 1000,
	}

}