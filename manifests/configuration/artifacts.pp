

class theforeman::configuration::artifacts {

	## INSTALLATION SEQUENCE DEFINITION ##
	
	Exec['hammer-create-installation-media'] ->
	Exec['hammer-create-architecture'] ->
	Exec['hammer-create-domain'] ->
	Exec['hammer-create-environment'] ->
	Exec['hammer-update-domain-dns'] ->
	Exec['hammer-create-subnet']
	
	
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

	exec { 'hammer-create-environment':
		command => "echo environment cloudbox created",
		onlyif 	=> "hammer environment create --name cloudbox",
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
		environment	=> ["HOME=/home/server"],
		timeout	=> 1000,
	}
	
	# update the domain: enter the dns entry id
	exec { 'hammer-update-domain-dns':
		path    => ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
		command => "hammer domain update --name local.cloud --dns-id $(hammer proxy list | grep 'server.local.cloud' | cut -d' ' -f1)",
		environment     => ["HOME=/home/server"],
	}

	exec { 'hammer-create-subnet':
		command => "echo subnet created",
		onlyif 	=> "hammer subnet create --name main --network 172.16.0.0 --mask 255.255.255.0 --gateway 172.16.0.2 --domain-ids $(hammer domain list | /bin/grep \"local.cloud\" | /usr/bin/cut -d' ' -f1) --dhcp-id $(hammer proxy list | grep \"server.local.cloud\" | cut -d' ' -f1) --tftp-id $(hammer proxy list | grep \"server.local.cloud\" | cut -d' ' -f1) --dns-id $(hammer proxy list | grep \"server.local.cloud\" | cut -d' ' -f1)",
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
		environment => ["HOME=/home/server"],
		timeout	=> 1000,
	}
	
}
