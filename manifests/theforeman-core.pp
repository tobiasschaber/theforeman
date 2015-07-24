






# TFTP

# create the TFTP-root directory and set the permissions
file { '/var/lib/tftpboot':
	ensure	=> directory,
	owner	=> nobody,
	group	=> nogroup,
	mode	=> 777,
}

# create pxelinux.cfg directory and set the permissions
file { '/var/lib/tftpboot/pxelinux.cfg':
	ensure	=> directory,
	owner	=> nobody,
	group	=> nogroup,
	mode	=> 777,
	
}

# netboot image directory
file { '/var/lib/tftpboot/boot':
	ensure	=> directory,
	owner	=> nobody,
	group	=> nogroup,
	mode	=> 777,
	
}




# modifying foreman-installer to support DDNS
file { "/usr/share/foreman-installer/modules/foreman_proxy/manifests/proxydhcp.pp":
	ensure	=> present,
	source	=> "/home/server/git/foreman-poc/files/DHCP/proxydhcp.pp",
	owner	=> root,
	group	=> root,
	mode	=> 644,
	
}



# foreman settings
file { "/etc/foreman/settings.yaml":
	ensure	=> present,
	source	=> "/home/server/git/foreman-poc/files/Foreman/settings.yaml",
	owner	=> root,
	group	=> foreman,
	mode	=> 640,
	
}

exec { "foreman-restart":
	command		=> "touch ~foreman/tmp/restart.txt",
	refreshonly	=> true,
	path		=> "/usr/bin/",
}

exec { "foreman-cache":
	command		=> "/usr/sbin/foreman-rake apipie:cache",
	
}


# set up hammer for foreman
file { '/etc/hammer':
        ensure  => directory,
        owner   => nobody,
        group   => nogroup,
        mode    => 777,
}



# workaround that DHCP can read the keyfile
# replace existing DHCPd-apparmor configuration
#service { "apparmor":
#    ensure  => "running",
#    enable  => "true",
#}

#file { "/etc/apparmor.d/usr.sbin.dhcpd":
#	notify  => Service["apparmor"],
#	ensure	=> present,
#	owner	=> root,
#	group	=> root,
#	mode	=> 644,
#	source	=> "/home/server/git/foreman-poc/files/DHCP/apparmor_usr.sbin.dhcpd",
#	require => Package["isc-dhcp-server"],
#}







	file { '/usr/share/foreman/bundler.d/plugins.rb':
		ensure	=> present,
		owner	=> root,
		group	=> root,
		mode	=> 644,
	}


file_line { 'add-gem-foreman_discovery':
	path	=> '/usr/share/foreman/bundler.d/plugins.rb',
	line	=> 'gem \'foreman_discovery\'',

}

exec { 'bundle-update':
       command => "gem install json -v \'1.8.2\'; bundle update",
       cwd     => "/usr/share/foreman",
	   path => ['/usr/bin/', '/bin/', '/sbin/', '/usr/sbin'],
}



exec { 'second_foreman-restart':
	command	=> "touch ~foreman/tmp/restart.txt",
	path	=> "/usr/bin/",
	
}


