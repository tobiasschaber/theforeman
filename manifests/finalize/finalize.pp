
# finalize the foreman installation
class theforeman::finalize::finalize {

	Exec['restart-service-bind'] ->
	Exec['restart-service-dhcp']
	
	
	exec {'restart-service-bind':
		command => "service bind9 restart",
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
	}

	exec {'restart-service-dhcp':
		command => "service isc-dhcp-server restart",
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
	}	
	
}