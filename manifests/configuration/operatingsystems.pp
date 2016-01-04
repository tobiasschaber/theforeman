

class theforeman::configuration::operatingsystems {

	## INSTALLATION SEQUENCE DEFINITION ##
	
	$homedir = hiera('foreman::home_dir')

	Exec['hammer-create-ubuntu-trusty'] ->
	Exec['hammer-set-template-preseed-default'] ->
	Exec['hammer-set-template-preseed-finish'] ->
	Exec['hammer-set-template-preseed-pxelinux'] ->
	Exec['hammer-os-set-default-template-provision'] ->
	Exec['hammer-os-set-default-template-finish'] ->
	Exec['hammer-os-set-default-template-pxelinux'] ->
	File['/tmp/preseed_default_finish'] ->
	Exec['hammer-os-update-preseed-default-finish-template']
	
	
	## PROCEDURE DEFINITION ##
	
	
	exec { 'hammer-create-ubuntu-trusty':
		environment	=> ["HOME=$homedir"],
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
		command => "echo created OS ubuntu trusty",
		onlyif => "hammer os create --name Ubuntu --major 14 --minor 04 --family Debian --release-name trusty --architecture-ids $(hammer architecture list | grep \"x86_64\" | /usr/bin/cut -d' ' -f1) --medium-ids $(hammer medium list | grep \"Local Mirror\" | cut -d' ' -f1),$(hammer medium list | grep \"Ubuntu mirror\" | cut -d' ' -f1) --partition-table-ids $(hammer partition-table list | grep \"Preseed default  \" | cut -d' ' -f1) --config-template-ids $(hammer template list --search \"Preseed default\" | grep \"Preseed default  \" | cut -c 1,2 ),$(hammer template list --search \"Preseed default finish\" | grep \"Preseed default finish\" | cut -d' ' -f1) ",
	}

	# update the domain: enter the dns entry id. us OS-id 1 because there is only one OS at the beginning
	exec { 'hammer-set-template-preseed-default':
		environment	=> ["HOME=$homedir"],
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
		command => "hammer template update --id $(hammer template list --search \"Preseed default\" | grep \"Preseed default  \" | cut -c 1-2) --operatingsystem-ids 1",
	}
	
	# update the domain: enter the dns entry id. us OS-id 1 because there is only one OS at the beginning
	exec { 'hammer-set-template-preseed-finish':
		command => "echo subnet created",
		onlyif 	=> "hammer template update --id $(hammer template list --search \"Preseed default finish\" | /bin/grep \"Preseed default finish\" | /usr/bin/cut -d' ' -f1) --operatingsystem-ids 1",
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
		environment => [
			"HOME=$homedir",
		],
		timeout	=> 1000,
	}
	
	# update the domain: enter the dns entry id. us OS-id 1 because there is only one OS at the beginning
	exec { 'hammer-set-template-preseed-pxelinux':
		environment => [
			"HOME=$homedir",
		],
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
		command => "hammer template update --id $(hammer template list --search \"Preseed default PXELinux\" | /bin/grep \"Preseed default PXELinux\" | /usr/bin/cut -d' ' -f1) --operatingsystem-ids 1",
	}
	

	exec { 'hammer-os-set-default-template-provision':
		environment	=> ["HOME=$homedir"],
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
		command => "echo added provision template to OS",
		onlyif => "hammer os set-default-template --id 1 --config-template-id $(hammer template list --search \"Preseed default\" | grep \"Preseed default  \" | cut -c 1,2 )",
	}

	exec { 'hammer-os-set-default-template-finish':
		environment	=> ["HOME=$homedir"],
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
		command => "echo added finish template to OS",
		onlyif => "hammer os set-default-template --id 1 --config-template-id $(hammer template list --search \"Preseed default finish\" | grep \"Preseed default finish\" | cut -d' ' -f1)",
	}
	
	exec { 'hammer-os-set-default-template-pxelinux':
		environment	=> ["HOME=$homedir"],
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
		command => "echo added pxelinux template to OS",
		onlyif => "hammer os set-default-template --id 1 --config-template-id $(hammer template list --search \"Preseed default PXELinux\" | grep \"Preseed default PXELinux\" | cut -d' ' -f1)",
	}
	
	file {'/tmp/preseed_default_finish':
		ensure	=> present,
		source 	=> 'puppet:///modules/theforeman/configuration/preseed_default_finish.txt',
	}
	
	exec { 'hammer-os-update-preseed-default-finish-template':
		environment	=> ["HOME=$homedir"],
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
		command => "echo updated preseed default finish template",
		onlyif => "hammer template update --id $(hammer template list --search \"Preseed default finish\" | grep \"Preseed default finish\" | cut -d' ' -f1) --file /tmp/preseed_default_finish",
	}	

	


	
}
