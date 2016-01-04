
# this class is the entry point for the installation
# of theforeman after the system has been prepared
# by the preparation part

class theforeman::coreinstall::coreinstall {

	include theforeman::coreinstall::preparepuppet

	## INSTALLATION SEQUENCE DEFINITION ##
	
        $primary_interface = hiera('foreman::primary_interface', 'eth1')

	Class['theforeman::coreinstall::preparepuppet'] ->
        File['/etc/foreman/xxxxx.yaml'] ->
	File['/etc/foreman/foreman-installer-answers.yaml'] -> 
	Exec['foreman-installer']
	

	## PROCEDURE DEFINITION ##
	
	
	# prepare the options for the foreman installer
	# the Package dependency is required to create the needed folder.
	file { "/etc/foreman/foreman-installer-answers.yaml":
		ensure	=> "present",
                content => template("/tmp/foremaninstalldir/files/installation/foreman-installer-answers.erb"),
		owner	=> root,
		group	=> root,
		mode	=> 600,
		require => Package['foreman-installer'],
	}

	# prepare the options for the foreman installer
	# the Package dependency is required to create the needed folder.
	file { "/etc/foreman/xxxxx.yaml":
		ensure	=> "present",
                content => "$primary_interface",
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
