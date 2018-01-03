Vagrant.configure("2") do |oraclexe_config|
    oraclexe_config.vm.box = "ubuntu/trusty64"
    oraclexe_config.vm.host_name = "oracle-xe"

    oraclexe_config.vm.network "forwarded_port", guest: 1521, host: 1521
    # oraclexe_config.vm.network "forwarded_port", guest: 8080, host: 8080

    oraclexe_config.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path = "modules"

      puppet.manifest_file  = "default.pp"

      # puppet.options = "--verbose --debug"
    end

    oraclexe_config.vm.provider "virtualbox" do |vb|
      vb.name = "oracle-xe_11.2.0_amd64"
      vb.memory = "3072"
    end

    oraclexe_config.vm.box_check_update = false
end
