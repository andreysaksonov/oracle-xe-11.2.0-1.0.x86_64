Vagrant.configure(2) do |db1_config|
    db1_config.vm.box = "ubuntu/trusty64"
    db1_config.vm.host_name = "oracle-xe"
    db1_config.vm.box_check_update = false

    db1_config.vm.network "forwarded_port", guest: 1521, host: 1521
    #db1_config.vm.network "forwarded_port", guest: 8080, host: 8080

    db1_config.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file  = "default.pp"
      puppet.module_path = "modules"
      puppet.options = "--verbose --debug"
    end

    db1_config.vm.provider "virtualbox" do |vb|
      vb.name = "oracle-xe_11.2.0-2_amd64"
      vb.memory = "2048"
      #vb.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
      #vb.gui = true
    end
end