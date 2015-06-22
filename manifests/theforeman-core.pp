
->

## TODO SECTION
	-> prepare the apt list for plugin site
	File['prepare_list_plugin'] ->


#############
	Exec['teardown-apparmor'] ->
	File['/etc/bind/rndc.key'] ->

	File_Line['dhclient'] ->
	File['/var/lib/tftpboot'] ->
	File['/var/lib/tftpboot/pxelinux.cfg'] ->
	File['/var/lib/tftpboot/boot'] ->
	File['/var/lib/tftpboot/boot/Ubuntu-12.10-x86_64-initrd.gz'] ->
	File['/var/lib/tftpboot/boot/Ubuntu-12.10-x86_64-linux'] ->
	Exec['wget initrd.img'] ->
	Exec['wget vmlinuz'] ->
	File['/usr/share/foreman-installer/modules/foreman_proxy/manifests/proxydhcp.pp'] ->
	File['/var/lib/tftpboot/boot/foreman-discovery-image-latest.el6.iso-img'] ->
	File['/var/lib/tftpboot/boot/foreman-discovery-image-latest.el6.iso-vmlinuz'] ->
	Exec['foreman-installer'] ->
		
	File['/etc/foreman/settings.yaml'] ->
	Exec['foreman-restart'] ->
	Exec['foreman-cache'] ->
	Package['ruby-dev'] ->
	Package['hammer_cli'] ->
	Package['hammer_cli_foreman'] ->
	File['/etc/hammer'] ->
	File['/etc/hammer/cli_config.yml'] ->
	File['/var/log/foreman/hammer.log'] ->
	Exec['hammer execution'] ->
	
	

	Service['apache2'] ->
	Service['apt-cacher'] ->
	File['/etc/apt-cacher/apt-cacher.conf'] ->
	Exec['apt-cacher-import'] ->

		File['/usr/share/foreman/bundler.d/plugins.rb']

	File_Line['add-gem-foreman_discovery'] ->
	Exec['bundle-update'] ->
	File_Line['uncomment_environmentpath'] ->
	File_Line['add-cloudbox-1'] ->
	File_Line['add-cloudbox-2'] ->
	File_Line['add-cloudbox-3'] ->
	Exec['restart-puppet'] ->
	Exec['second_foreman-restart']








# placing the keyfile
file { "/etc/bind/rndc.key":
	ensure	=> present,
	source	=> "/home/server/git/foreman-poc/files/BIND/rndc.key",
	owner	=> root,
	group	=> bind,
	mode	=> 640,
}



# dhclient fix: prepend DNS-server
file_line { 'dhclient':
	path	=> '/etc/dhcp/dhclient.conf',
	line	=> 'prepend domain-name-servers 172.16.0.2;',
	match	=> "prepend domain-name-servers",
}

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

# copy image for Ubuntu 12.10
file { '/var/lib/tftpboot/boot/Ubuntu-12.10-x86_64-initrd.gz':
	ensure	=> present,
	owner	=> nobody,
	group	=> nogroup,
	mode	=> 777,
	source	=> "/home/server/git/foreman-poc/files/TFTP/ubuntu12.10/initrd.gz",
	
}

file { '/var/lib/tftpboot/boot/Ubuntu-12.10-x86_64-linux':
	ensure	=> present,
	owner	=> nobody,
	group	=> nogroup,
	mode	=> 777,
	source	=> "/home/server/git/foreman-poc/files/TFTP/ubuntu12.10/linux",
	
}

# download discovery images
exec { "wget initrd.img":
       command => "wget http://downloads.theforeman.org/discovery/releases/0.5/foreman-discovery-image-latest.el6.iso-img",
       cwd     => "/var/lib/tftpboot/boot/",
       creates => "/var/lib/tftpboot/boot/foreman-discovery-image-latest.el6.iso-img",
       path    => "/usr/bin",
       timeout => 1000,
       
}


exec { "wget vmlinuz":
        command => "wget http://downloads.theforeman.org/discovery/releases/0.5/foreman-discovery-image-latest.el6.iso-vmlinuz",
        cwd     => "/var/lib/tftpboot/boot/",
        creates => "/var/lib/tftpboot/boot/foreman-discovery-image-latest.el6.iso-vmlinuz",
        path    => "/usr/bin",
        timeout => 1000,
}



# modifying foreman-installer to support DDNS
file { "/usr/share/foreman-installer/modules/foreman_proxy/manifests/proxydhcp.pp":
	ensure	=> present,
	source	=> "/home/server/git/foreman-poc/files/DHCP/proxydhcp.pp",
	owner	=> root,
	group	=> root,
	mode	=> 644,
	
}







# set permissions for discovery images
file { '/var/lib/tftpboot/boot/foreman-discovery-image-latest.el6.iso-img':
      ensure  => present,
      owner   => foreman-proxy,
      group   => nogroup,
      mode    => 644,
     
}


file { '/var/lib/tftpboot/boot/foreman-discovery-image-latest.el6.iso-vmlinuz':
      ensure  => present,
      owner   => foreman-proxy,
      group   => nogroup,
      mode    => 644,
      
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



# install hammer cli
package { 'hammer_cli':
	ensure		=> installed,
	provider	=> "gem",
	
}

# install foreman plugin for hammer
package { 'hammer_cli_foreman':
	ensure	=> installed,
	provider => "gem",
	
}

# set up hammer for foreman
file { '/etc/hammer':
        ensure  => directory,
        owner   => nobody,
        group   => nogroup,
        mode    => 777,
}
# hammer config file
file { "/etc/hammer/cli_config.yml":
	ensure	=> present,
	source	=> "/home/server/git/foreman-poc/hammer/cli_config.yml",

}

# hammer logging
file { '/var/log/foreman/hammer.log':
	ensure	=> present,
	mode	=> 777,

}

exec { "hammer execution":
	command	=> "/home/server/git/foreman-poc/hammer/hammer.sh",
	path	=> "/usr/local/bin/",

#	user	=> "server",
	environment	=> ["HOME=/home/server"],
}






















# Install local ubuntu repository: apt-cacher
service { "apache2":
	ensure  => "running",
	enable  => "true",

}




#
#
# OBERHALB: SCHON VERARBEITET
# UNTERHALB: NOCH VERARBEITEN
#
#
#
#
#
















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

file_line { 'uncomment_environmentpath':
	path	=> '/etc/puppet/puppet.conf',
	line	=> '#    environmentpath  = /etc/puppet/environments',
	match	=> '    environmentpath  = /etc/puppet/environments',

}

file_line { 'add-cloudbox-1':
	path	=> '/etc/puppet/puppet.conf',
	line	=> '',
}

file_line { 'add-cloudbox-2':
	path	=> '/etc/puppet/puppet.conf',
	line	=> '[cloudbox]',

}

file_line { 'add-cloudbox-3':
	path	=> '/etc/puppet/puppet.conf',
	line	=> '    modulepath = /etc/puppet/environments/cloudbox/modules',

}

exec { 'restart-puppet':
	command	=> "service puppet restart",
	path	=> "/usr/bin/",
	
}

exec { 'second_foreman-restart':
	command	=> "touch ~foreman/tmp/restart.txt",
	path	=> "/usr/bin/",
	
}













