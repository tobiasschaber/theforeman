
# this class is user to create all needed users

class theforeman::preparation::createusers {

	## INSTALLATION SEQUENCE DEFINITION ##
	
	Group['bind'] ->
	User['foreman-proxy'] ->
	File_Line['sudo_rule_v1'] ->
	File_Line['sudo_rule_v2'] ->
	File_Line['sudo_rule_v3']
	
	
	## PROCEDURE DEFINITION ##
	
	group { "bind":
		ensure => "present",
	}

	# adding user 'foreman-proxy' to group 'bind', as this users needs to read the keyfile
	user { "foreman-proxy":
		ensure	=> present,
		groups	=> ['bind'],
	}
	
	file_line { 'sudo_rule_v1':
		path	=> '/etc/sudoers',
		line	=> 'Defaults:foreman-proxy !requiretty',		
	}

	file_line { 'sudo_rule_v2':
		path	=> '/etc/sudoers',
		line	=> 'foreman-proxy ALL = NOPASSWD: /usr/bin/puppet kick *',
	}
	 
	file_line { 'sudo_rule_v3':
		path	=> '/etc/sudoers',
		line	=> 'foreman-proxy ALL = NOPASSWD: /usr/bin/puppet cert *',
	}
	
}
