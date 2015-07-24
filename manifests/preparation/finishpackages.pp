
# this class makes some adjustments to the packages which
# have been installed before.

class theforeman::preparation::finishpackages {

	## INSTALLATION SEQUENCE DEFINITION ##

	File['/etc/apt-cacher/apt-cacher.conf'] ->
	Exec['apt-cacher-import'] ->
	File['/etc/bind/rndc.key'] ->
	User['dhcpd'] ->
	File_Line['dhclient'] ->
	File_Line['dhcp-add-key-1'] ->	File_Line['dhcp-add-key-2'] ->	File_Line['dhcp-add-key-3'] -> File_Line['dhcp-add-key-4'] -> File_Line['dhcp-add-key-5']
	
	
	## PROCEDURE DEFINITION ##
	
	file { '/etc/apt-cacher/apt-cacher.conf':
		ensure	=> present,
		owner	=> root,
		group	=> root,
		mode	=> 644,
		source	=> "puppet:///modules/theforeman/System/apt-cacher.conf",
	}
	
	exec {'apt-cacher-import':
		command => "apt-cacher-import.pl -r /var/cache/apt/archives",
		path	=> "/usr/share/apt-cacher/",
	}

	# placing the keyfile
	file { "/etc/bind/rndc.key":
		ensure	=> present,
		source	=> "puppet:///modules/theforeman/System/rndc.key",
		owner	=> root,
		group	=> bind,
		mode	=> 640,
	}
	
	# adding user 'dhcpd' to group 'bind', as this users needs to read the keyfile
	user { "dhcpd":
		ensure	=> present,
		groups	=> ['bind'],
	}
	

	# dhclient fix: prepend DNS-server
	file_line { 'dhclient':
		path	=> '/etc/dhcp/dhclient.conf',
		line	=> 'prepend domain-name-servers 172.16.0.2;',
		match	=> "prepend domain-name-servers",
	}
	
	file_line { 'dhcp-add-key-1':
		path	=> '/etc/dhcp/dhcpd.conf',
		line	=> "key rndc-key {",
	}
	
	file_line { 'dhcp-add-key-2':
		path	=> '/etc/dhcp/dhcpd.conf',
		line	=> "algorithm HMAC-MD5;",
	}

		file_line { 'dhcp-add-key-3':
		path	=> '/etc/dhcp/dhcpd.conf',
		line	=> "secret \"bQR3x3fquV+YjZ+aChpfJQ==\";",
	}
	
		file_line { 'dhcp-add-key-4':
		path	=> '/etc/dhcp/dhcpd.conf',
		line	=> "};",
	}
	
		file_line { 'dhcp-add-key-5':
		path	=> '/etc/dhcp/dhcpd.conf',
		line	=> "omapi-key rndc-key;",
	}

	
}