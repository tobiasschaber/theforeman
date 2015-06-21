
# this class is used to perform early preparation for packages
# like creating apt lists and registering keys

class theforeman::preparation::preparepackages {

	define aptkey($ensure, $apt_key_url = 'http://deb.theforeman.org') {
	  case $ensure {
		'present': {
		  exec { "apt-key present $name":
		command => "/usr/bin/wget -q $apt_key_url/$name -O -|/usr/bin/apt-key add -",
		unless  => "/usr/bin/apt-key list|/bin/grep -c $name",
		  }
		}
		'absent': {
		  exec { "apt-key absent $name":
		command => "/usr/bin/apt-key del $name",
		onlyif  => "/usr/bin/apt-key list|/bin/grep -c $name",
		  }
		}
		default: {
		  fail "Invalid 'ensure' value '$ensure' for apt::key"
		}
	  }
	}


	## INSTALLATION SEQUENCE DEFINITION ##

	aptkey { 'foreman.asc':
		ensure	=> present
	} 
	->
	File['prepare-apt-foreman-trusty'] -> 
	File_Line['prepare-apt-foreman-plugins'] -> 
	Exec['wget-foreman-pubkey'] -> 
	Exec['apt-update'] ->
	File['/etc/apt-cacher/apt-cacher.conf'] ->
	Exec['apt-cacher-import']
	
	## PROCEDURE DEFINITION ##
	
	file {'prepare-apt-foreman-trusty':
		path	=> '/etc/apt/sources.list.d/foreman.list',
		ensure	=> present,
		mode	=> 0644,
		content	=> 'deb http://deb.theforeman.org/ trusty 1.8'
	}
	
	file_line { 'prepare-apt-foreman-plugins':
		path	=> '/etc/apt/sources.list.d/foreman.list',
		line	=> 'deb http://deb.theforeman.org/ plugins 1.8',
	}
	
	exec { "apt-update":
		command	=> "/usr/bin/apt-get update",
	}
	
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
	

}





