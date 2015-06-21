
# this class is the entry point for the installation
# of theforeman after the system has been prepared
# by the preparation part
class theforeman::coreinstall::coreinstall {

#	include theforeman::preparation::preparepackages
#	include theforeman::preparation::createusers
#	include theforeman::preparation::installpackages
#	include theforeman::preparation::preparenetwork
#	include theforeman::preparation::finishpackages
#	include theforeman::preparation::startservices
	
#	exec { 'teardown-apparmor':
#		command	=> "service apparmor stop; service apparmor teardown; update-rc.d -f apparmor remove",
#		path => ['/usr/bin/', '/bin/', '/sbin/', '/usr/sbin'],
#	}

#	# not sure if this is a good way to teardown apparmor completely...
#	Exec['teardown-apparmor'] ->
#	Class['theforeman::preparation::preparepackages'] ->
#	Class['theforeman::preparation::createusers'] ->
#	Class['theforeman::preparation::installpackages'] ->
#	Class['theforeman::preparation::finishpackages'] ->
#	Class['theforeman::preparation::preparenetwork'] ->
#	Class['theforeman::preparation::startservices']

}