
# standalone puppet class!
# checks out the openstack puppet module from bitbucket and copies it into the puppet
# directory. then imports the new module into foreman
class theforeman::openstack::openstack {

	Exec['checkout-puppet-classes'] ->
	Exec['copy-openstack-module'] ->
	Exec['copy-dependend-modules'] ->
	Exec['hammer-import-modules']
	
	
	exec {'checkout-puppet-classes':
		command => "git clone https://bitbucket.org/tobias_schaber/openstack.git",
		cwd     => "/tmp",
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
	}

	exec {'copy-openstack-module':
		command => "cp -r /tmp/openstack/cc_openstack /etc/puppet/modules/",
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
	}	
	
	exec {'copy-dependend-modules':
		command => "cp -r /tmp/openstack/dependencies/mysql /etc/puppet/modules/",
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
	}	
		
	exec { 'hammer-import-modules':
		environment => ["HOME=/home/server"],
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
		command => "echo imported openstack puppet module into foreman",
		onlyif => "hammer proxy import-classes --environment cloudbox --id 1",
	}

	
}

