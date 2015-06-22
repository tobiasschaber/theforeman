

class theforeman::coreinstall::preparepuppet {


	## INSTALLATION SEQUENCE DEFINITION ##
	
	File['/etc/puppet/environments/cloudbox'] -> 
	File['/etc/puppet/environments/cloudbox/modules'] -> 
	File['/etc/puppet/environments/cloudbox/manifests']
	
	
	
	## PROCEDURE DEFINITION ##	
	
	file {'/etc/puppet/environments/cloudbox':
		path	=> '/etc/puppet/environments/cloudbox',
		ensure	=> present,
		owner	=> puppet,
		group	=> root,
		mode	=> 0755,
	}
	
	file {'/etc/puppet/environments/cloudbox/modules':
		path	=> '/etc/puppet/environments/cloudbox/modules',
		ensure	=> present,
		owner	=> puppet,
		group	=> root,
		mode	=> 0755,
		require => File['/etc/puppet/environments/cloudbox'],
	}
	
	file {'/etc/puppet/environments/cloudbox/manifests':
		path	=> '/etc/puppet/environments/cloudbox/manifests',
		ensure	=> present,
		owner	=> puppet,
		group	=> root,
		mode	=> 0755,
		require => File['/etc/puppet/environments/cloudbox'],
	}
	
	

	


}