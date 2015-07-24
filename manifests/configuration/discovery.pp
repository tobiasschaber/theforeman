

class theforeman::configuration::discovery {

	Exec['restart-service-proxy'] ->
	Exec['hammer-refresh-proxy-features'] ->
	Notify['finished-installation']

	
	exec {'restart-service-proxy':
		command => "service foreman-proxy restart",
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
	}

	exec { 'hammer-refresh-proxy-features':
		environment => ["HOME=/home/server"],
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
		command => "echo refreshing hammer proxy features",
		onlyif => "hammer proxy refresh-features --id 1",
	}

	notify { 'finished-installation':
	
	}
}
