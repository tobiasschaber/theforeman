
# standalone puppet class!
# checks out the openstack puppet module from bitbucket and copies it into the puppet
# directory. then imports the new module into foreman
class theforeman::openstack::openstack {

	Exec['checkout-puppet-classes'] ->
	Exec['copy-openstack-module'] ->
	Exec['copy-dependend-modules'] ->
	Exec['hammer-import-modules'] ->
	Exec['hammer-create-controller-hostgroup']
	
	
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
		command => "cp -r /tmp/openstack/dependencies/* /etc/puppet/modules/",
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
	}	
		
	exec { 'hammer-import-modules':
		environment => ["HOME=/home/server"],
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
		command => "echo imported openstack puppet module into foreman",
		onlyif => "hammer proxy import-classes --environment cloudbox --id 1",
	}

	exec { 'hammer-create-controller-hostgroup':
		environment => ["HOME=/home/server"],
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
		command => "echo created openstack controller hostgroup",
		onlyif => "hammer hostgroup create --name openstack-controller --environment cloudbox --puppet-classes cc_openstack::roles::controller_node --domain local.cccloud --subnet-id 1 --puppet-ca-proxy server.local.cccloud --puppet-proxy server.local.cccloud --architecture x86_64 --operatingsystem-id 1 --medium \"Local Mirror\" --partition-table \"Preseed default\"",
	}	
	
	
}

