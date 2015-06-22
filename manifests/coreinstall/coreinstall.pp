
# this class is the entry point for the installation
# of theforeman after the system has been prepared
# by the preparation part

class theforeman::coreinstall::coreinstall {


	## INSTALLATION SEQUENCE DEFINITION ##
	
	File['/etc/foreman/foreman-installer-answers.yaml'] -> 
	Exec['foreman-installer']
	

	## PROCEDURE DEFINITION ##
	
	
	# prepare the options for the foreman installer
	file { "/etc/foreman/foreman-installer-answers.yaml.":
		ensure	=> present,
		source => 'puppet:///modules/theforeman/installation/foreman-installer-answers.yaml',
		owner	=> root,
		group	=> root,
		mode	=> 600,
	}

	exec { 'foreman-installer':
		command	=> "/usr/sbin/foreman-installer --enable-foreman-proxy --foreman-proxy-trusted-hosts=localhost --foreman-admin-password changeme",
		environment => ["HOME=/home/server"],
		timeout => 1000,
	}

#

#

### TODO:

# http://projects.theforeman.org/projects/smart-proxy/wiki/Settingsyml

# ACHTUNG! Die Foremaninstallation soll zunächst ohne folgende Dinge passieren
# - puppet environment "cloudbox" (siehe auch answers.yaml)
# - alle plugins
# - hammer
# - smartproxies
# - betriebssysteme


# dann sollte ich zunächst schauen, was die ganzen parameter in der bisherigen answers.yaml datei bedeuten und warum wir diese gesetzt haben.

# eine puppet umgebung kann über die foreman gui erstellt werden, 
# ich bin aber noch nciht sicher, ob diese einrichtung wirklich automatisiert werden sollte


#

#


#	include theforeman::preparation::startservices
	
#	Class['theforeman::preparation::startservices']

}