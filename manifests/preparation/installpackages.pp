
# this class is used to install all packages required for the complete
# foreman installation. As it is part of the preparation process,
# these all are just simple packages which can be installed independently.

class theforeman::preparation::installpackages {

	## INSTALLATION SEQUENCE DEFINITION ##

	Package['make'] ->
	Package['openssh-server'] ->
	Package['bind9'] ->
	Package['git'] ->
	Package['gem'] ->
	Package['ruby-dev'] ->
	Package['debconf-utils'] ->
	Package['foreman-installer'] ->
	Package['iptables-persistent'] ->
	Package['isc-dhcp-server'] ->
	Package['apt-cacher']
	
	## PROCEDURE DEFINITION ##
	
	package { "make":
		ensure => "installed",
	}

	package { "openssh-server":
		ensure => "installed",
	}
	
	package { "bind9":
		ensure => "installed",
	}
	
	package { "git":
		ensure  => "installed",
	}
	
	package { "gem":
		ensure => "installed",
		install_options => [ '--force-yes'],
	}
	
	package { "ruby-dev":
		ensure	=> "installed",
	}
	
	package{ "debconf-utils":
		ensure	=> "installed",
	}
	
	package { "foreman-installer":
		ensure => ['1.9.0-1', "installed"],
	}
	
	package { "iptables-persistent":
		ensure	=> "installed",
	}

	package { "isc-dhcp-server":
		ensure	=> "installed",	
	}

	package { "apt-cacher":
		ensure	=> "installed",
	}
	
}





