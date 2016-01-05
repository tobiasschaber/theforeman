VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|


  # theforeman server
   config.vm.define "server" do |server|

	server.vm.box = "ubuntu/trusty64"
	server.vm.hostname = "server.local.cccloud"
	server.vm.network "public_network", :bridge => "lxcbr0"
	server.vm.network "forwarded_port", guest: 80, host: 8080
	server.vm.network "forwarded_port", guest: 443, host: 8443
	server.vm.network "forwarded_port", guest: 8443, host: 18443
	server.vm.network "private_network", ip: "172.16.0.2"
#	server.vm.network "public_network", ip: "10.0.3.111", :bridge => "lxcbr0"
#	server.vm.network "private_network", type: "dhcp"
	server.vm.provision :shell, :path => "post-install-vm.sh"
	server.vm.provision :shell, :path => "run-puppet.sh"
	server.vm.provider "virtualbox" do |v|
                 v.memory = 3072 
                 v.cpus = 2
         end
   end

end
