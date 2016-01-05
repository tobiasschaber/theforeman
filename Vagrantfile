VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|


  # theforeman server
   config.vm.define "server" do |server|

	server.vm.box = "ubuntu/trusty64"
	server.vm.hostname = "server.local.cccloud"
	server.vm.network "public_network", ip: "10.0.3.175", :bridge => "lxcbr0"
	server.vm.network "private_network", ip: "172.16.0.2", virtualbox__intnet: "intnet"
	server.vm.provision :shell, :path => "post-install-vm.sh"
	server.vm.provision :shell, :path => "run-puppet.sh"
	server.vm.provider "virtualbox" do |v|
                 v.memory = 4096
                 v.cpus = 3
         end
   end

end
