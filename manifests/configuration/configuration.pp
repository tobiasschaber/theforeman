

# install the foreman discovery plugin via the foreman-installer
class theforeman::configuration::configuration {

	include theforeman::configuration::artifacts
	include theforeman::configuration::operatingsystems
	include theforeman::configuration::discovery
	

	## INSTALLATION SEQUENCE DEFINITION ##
	
	File['/var/log/foreman/hammer.log'] ->
	File['/etc/hammer/cli_config.yml'] ->
	Class['theforeman::configuration::artifacts'] ->
	Class['theforeman::configuration::operatingsystems'] ->
	Class['theforeman::configuration::discovery'] ->
	Exec['build-pxe-default-template']
	
	

	## PROCEDURE DEFINITION ##
	
	
	
	
	# create log file for hammer and ajust rights
	file { '/var/log/foreman/hammer.log':
		ensure	=> present,
		mode	=> 777,
	}

	# hammer config file
	file { "/etc/hammer/cli_config.yml":
		ensure	=> present,
		source 	=> 'puppet:///modules/theforeman/configuration/hammer_cli_config.yml',
	}
	
	exec { 'build-pxe-default-template':
		environment => ["HOME=/home/server"],
		path 	=> ['/usr/sbin/', '/bin/', '/sbin/', '/usr/bin'],
		command => "echo  pxe default template was build",
		onlyif  => "hammer template build-pxe-default",
	}
	
	
	



}