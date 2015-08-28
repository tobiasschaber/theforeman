
# standalone puppet class!
# checkout the openstack puppet module from bitbucket and copy it into the puppet
# directory. then import the new module into foreman
class theforeman::openstack::openstack {

	Exec['checkout-puppet-classes'] ->
	Exec['copy-openstack-module'] ->
	Exec['hammer-import-modules']
	
	
	exec {'checkout-puppet-classes':
		command => "git clone https://bitbucket.org/tobias_schaber/openstack.git",
		cwd     => "/tmp",
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
		require => Notify['finished-installation']
	}

	exec {'copy-openstack-module':
		command => "cp -r /tmp/openstack/cc_openstack /etc/puppet/modules/",
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
	}	

	
	exec { 'hammer-import-modules':
		environment => ["HOME=/home/server"],
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
		command => "echo imported openstack puppet module into foreman",
		onlyif => "hammer proxy import-classes --environment cloudbox --id 1",
	}

	
}

