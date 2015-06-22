

# this class will prepare the (existing) puppet installation and will add
# the cloudbox environment as a directory environment by just adding the needed
# folders under /etc/puppet/environments

class theforeman::coreinstall::preparepuppet {


	## INSTALLATION SEQUENCE DEFINITION ##
	
	File['/etc/puppet/environments/cloudbox'] -> 
	File['/etc/puppet/environments/cloudbox/modules'] -> 
	File['/etc/puppet/environments/cloudbox/manifests']
	
	
	
	## PROCEDURE DEFINITION ##	
	
	file {'/etc/puppet/environments/cloudbox':
		path	=> '/etc/puppet/environments/cloudbox',
		ensure	=> "directory",
		owner	=> puppet,
		group	=> root,
		mode	=> 0755,
	}
	
	file {'/etc/puppet/environments/cloudbox/modules':
		path	=> '/etc/puppet/environments/cloudbox/modules',
		ensure	=> "directory",
		owner	=> puppet,
		group	=> root,
		mode	=> 0755,
		require => File['/etc/puppet/environments/cloudbox'],
	}
	
	file {'/etc/puppet/environments/cloudbox/manifests':
		path	=> '/etc/puppet/environments/cloudbox/manifests',
		ensure	=> "directory",
		owner	=> puppet,
		group	=> root,
		mode	=> 0755,
		require => File['/etc/puppet/environments/cloudbox'],
	}
	
	

	


}