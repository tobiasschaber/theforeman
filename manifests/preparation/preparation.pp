
# this class summarizes the preparation procedure like
# installing all required packages and enabling all required
# services etc.

class theforeman::preparation::preparation {

	include theforeman::preparation::preparepackages
	include theforeman::preparation::createusers
	include theforeman::preparation::installpackages
	include theforeman::preparation::preparenetwork
	include theforeman::preparation::startservices
	
	exec { 'teardown-apparmor':
		command	=> "service apparmor stop; service apparmor teardown; update-rc.d -f apparmor remove",
		path => ['/usr/bin/', '/bin/', '/sbin/', '/usr/sbin'],
	}

	# not sure if this is a good way to teardown apparmor completely...
	Exec['teardown-apparmor'] ->
	Class['theforeman::preparation::preparepackages'] ->
	Class['theforeman::preparation::createusers'] ->
	Class['theforeman::preparation::installpackages'] ->
	Class['theforeman::preparation::preparenetwork'] ->
	Class['theforeman::preparation::startservices']
	


}