
# this class makes some adjustments to the packages which
# have been installed before.

class theforeman::preparation::finishpackages {

	## INSTALLATION SEQUENCE DEFINITION ##

	File['/etc/apt-cacher/apt-cacher.conf'] ->
	Exec['apt-cacher-import']
	
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

}