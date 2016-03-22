Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.provision :shell, :path => "vagrant_provision.sh"


#  config.vm.provision :puppet do |puppet|
#    puppet.manifests_path = "puppet/manifests"
#    puppet.manifest_file = "site.pp"
#    puppet.module_path = "puppet/modules"
#  end
end
