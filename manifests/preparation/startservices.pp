
# this class is used to start all needed services for
# the installation

class theforeman::preparation::startservices {

	## INSTALLATION SEQUENCE DEFINITION ##
	
	Service['iptables-persistent'] ->
	Service['apt-cacher']
	
	
	## PROCEDURE DEFINITION ##
	
	# start iptables-persistent
	service { "iptables-persistent":
		ensure	=> running,
	}
	
	service { "apt-cacher":
		ensure  => "running",
		enable  => "true",
	}
	
}
