
# this class is used to prepare the network
# e.g. setting up the firewall as needed for the installation

class theforeman::preparation::preparenetwork {

        $primary_interface = hiera('foreman::primary_interface', 'eth1')

	## INSTALLATION SEQUENCE DEFINITION ##
	
	Exec['iptables forward'] ->
	Exec['iptables masquerade'] ->
	Exec['net.ipv4.ip_forward'] ->
	Exec['sysctl'] ->
	File['/tmp/iptables-persistent.seed'] ->
	Exec['iptables-preseed']
	
	
	## PROCEDURE DEFINITION ##
	
	# create firewall rules
	exec { 'iptables forward':
		command	=> "iptables -P FORWARD ACCEPT",
		path	=> "/sbin",
	}

	exec { 'iptables masquerade':
		command	=> "iptables --table nat -A POSTROUTING -o $primary_interface -j MASQUERADE",
		path	=> "/sbin",
	}
		
	# uncomment IP forwarding
	exec { 'net.ipv4.ip_forward':
		command	=> "/bin/sed -i -e'/#net.ipv4.ip_forward=1/s/^#\\+//' '/etc/sysctl.conf'",
		onlyif	=> "/bin/grep '#net.ipv4.ip_forward=1' '/etc/sysctl.conf' | /bin/grep '^#' | /usr/bin/wc -l",
	}

	exec { 'sysctl':
		command	=> "sysctl -w net.ipv4.ip_forward=1",
		path	=> "/sbin/",
	}
	
	file { '/tmp/iptables-persistent.seed':
		ensure => "present",
		source => 
			'puppet:///modules/theforeman/System/iptables-persistent.seed',
	}
	
	exec { 'iptables-preseed':
		command	=> "debconf-set-selections /tmp/iptables-persistent.seed",
		path	=> "/usr/bin/",
		require => File['/tmp/iptables-persistent.seed'], 
	}
	
}
