

class theforeman::configuration::operatingsystems {

	## INSTALLATION SEQUENCE DEFINITION ##
	
	Exec['hammer-create-ubuntu-trusty'] ->
	Exec['hammer-set-template-preseed-default'] ->
	Exec['hammer-set-template-preseed-finish'] ->
	Exec['hammer-set-template-preseed-pxelinux']
	
	
	## PROCEDURE DEFINITION ##
	
	
	exec { 'hammer-create-ubuntu-trusty':
		environment => ["HOME=/home/server"],
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
		command => "",
	}

	# update the domain: enter the dns entry id. us OS-id 1 because there is only one OS at the beginning
	exec { 'hammer-set-template-preseed-default':
		environment => ["HOME=/home/server"],
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
		command => "hammer template update --id $(hammer template list --search \"Preseed default\" | grep \"Preseed default\" | cut -c 1-30 | grep \"[[:space:]]$\" | cut -d' ' -f1) --operatingsystem-ids 1",
	}
	
	# update the domain: enter the dns entry id. us OS-id 1 because there is only one OS at the beginning
	exec { 'hammer-set-template-preseed-finish':
		command => "echo subnet created",
		onlyif 	=> "hammer template update --id $(hammer template list --search \"Preseed default finish\" | /bin/grep \"Preseed default finish\" | /usr/bin/cut -d' ' -f1) --operatingsystem-ids 1",
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
		environment => [
			"HOME=/home/server",
		],
		timeout	=> 1000,
	}
	
	
	
	
	
	# update the domain: enter the dns entry id. us OS-id 1 because there is only one OS at the beginning
	exec { 'hammer-set-template-preseed-pxelinux':
		environment => [
			"HOME=/home/server",
		],
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
		command => "hammer template update --id $(hammer template list --search \"Preseed default PXELinux\" | /bin/grep \"Preseed default PXELinux\" | /usr/bin/cut -d' ' -f1) --operatingsystem-ids 1",
	}
	
}
