

class theforeman::configuration::operatingsystems {

	## INSTALLATION SEQUENCE DEFINITION ##
	
	Exec['hammer-set-template-preseed-default'] ->
	Exec['hammer-set-template-preseed-finish'] ->
	Exec['hammer-set-template-preseed-pxelinux']
	
	
	## PROCEDURE DEFINITION ##
	

	# update the domain: enter the dns entry id. us OS-id 1 because there is only one OS at the beginning
	exec { 'hammer-set-template-preseed-default':
		environment => [
			"template_id_default=$(hammer template list --search \"Preseed default\" | /bin/grep \"Preseed default\" | /usr/bin/cut -c 1-22 | /bin/grep \"[[:space:]]$\" | /usr/bin/cut -d' ' -f1)",
		],
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
		command => "hammer template update --id $template_id_default --operatingsystem-ids 1",
	}
	
	# update the domain: enter the dns entry id. us OS-id 1 because there is only one OS at the beginning
	exec { 'hammer-set-template-preseed-finish':
		environment => [
			"template_id_finish=$(hammer template list --search \"Preseed default finish\" | /bin/grep \"Preseed default finish\" | /usr/bin/cut -d' ' -f1)",
		],
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
		command => "hammer template update --id $template_id_finish --operatingsystem-ids 1",
	}
	
	# update the domain: enter the dns entry id. us OS-id 1 because there is only one OS at the beginning
	exec { 'hammer-set-template-preseed-pxelinux':
		environment => [
			"template_id_pxelinux=$(hammer template list --search \"Preseed default PXELinux\" | /bin/grep \"Preseed default PXELinux\" | /usr/bin/cut -d' ' -f1)",
		],
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
		command => "hammer template update --id $template_id_pxelinux --operatingsystem-ids 1",
	}
	
}
