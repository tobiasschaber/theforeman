
# finalize the foreman installation
class theforeman::finalize::finalize {

	Exec['restart-service-bind'] ->
	Exec['restart-service-dhcp'] ->
	Exec['restart-foreman-final']
	
	
	exec {'restart-service-bind':
		command => "service bind9 restart",
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
		require => Notify['finished-installation']
	}

	exec {'restart-service-dhcp':
		command => "service isc-dhcp-server restart",
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
	}	


	
	exec {'restart-foreman-final':
		command => "touch ~foreman/tmp/restart.txt",
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
	}		
	

	
}

