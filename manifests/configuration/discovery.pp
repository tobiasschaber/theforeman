

class theforeman::configuration::discovery {

	$homedir = hiera('foreman::home_dir')

	Exec['restart-service-proxy'] ->
	Exec['hammer-refresh-proxy-features'] ->
	File['/tmp/pxelinux_global_default_template'] ->
	Exec['hammer-update-pxe-global-default-template'] ->
	Notify['finished-installation']

	
	exec {'restart-service-proxy':
		command => "service foreman-proxy restart",
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
	}

	exec { 'hammer-refresh-proxy-features':
		environment	=> ["HOME=$homedir"],
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
		command => "echo refreshing hammer proxy features",
		onlyif  => "hammer proxy refresh-features --id 1",
	}
	
	
	file {'/tmp/pxelinux_global_default_template':
		ensure	=> present,
		source 	=> 'puppet:///modules/theforeman/configuration/pxelinux_global_default_template.txt',
	}		

	exec { 'hammer-update-pxe-global-default-template':
		environment	=> ["HOME=$homedir"],
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
		command => "echo updated pxe global default template",
		onlyif  => "hammer template update --id $(hammer template list --search \"PXELinux global default\" | grep \"PXELinux global default\" | cut -c 1,1) --file /tmp/pxelinux_global_default_template",
		require => File['/tmp/pxelinux_global_default_template'],
	}
	

	notify { 'finished-installation':
	
	}
}
