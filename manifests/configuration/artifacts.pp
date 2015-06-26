

class theforeman::configuration::artifacts {

	## INSTALLATION SEQUENCE DEFINITION ##
	
	Exec['hammer-create-installation-media'] ->
	Exec['hammer-create-architecture'] ->
	Exec['hammer-create-domain'] ->
	Exec['test-env-variable'] ->
	Exec['test-output']
	
	
	## PROCEDURE DEFINITION ##
	
	
	
	exec { 'hammer-create-installation-media':
		command => "echo installation media created",
		onlyif 	=> "hammer medium create --name 'Local Mirror' --path http://172.16.0.2:3142/apt-cacher/ubuntu --os-family Debian",
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
		environment	=> ["HOME=/home/server"],
		timeout	=> 1000,
	}
	
	
	exec { 'hammer-create-architecture':
		command => "echo architecture x86_64 created",
		onlyif 	=> "hammer architecture create --name x86_64",
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
		environment	=> ["HOME=/home/server"],
		timeout	=> 1000,
	}
	
	exec { 'hammer-create-domain':
		command => "echo domain local.cloud created",
		onlyif 	=> "hammer domain create --name \"local.cloud\" --description \"Base cloud domain\"",
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
		environment	=> ["HOME=/home/server"],
		timeout	=> 1000,
	}
	
	exec { 'test-env-variable':
		environment => [ "ptable_id=$(hammer partition-table list | /bin/grep \"Preseed default\" | /usr/bin/cut -d' ' -f1)" ]
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
	}
	
	exec { 'test-output':
		command => "echo $ptable_id",
		requires => Exec['test-env-variable'],
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
	}
	
	
	
}
