Vagrant.configure("2") do |config|

  config.vm.define "master-1" do |vm|
    vm.vm.network "public_network",
      dev: "br0",
      mode: "bridge",
      type: "bridge"

    vm.vm.provider :libvirt do |domain|
      domain.cpus = 2
      domain.memory = 2048
      domain.serial :type => "file", :source => {:path => "/tmp/control-plane-node-1.log"}
      domain.storage :file, :device => :cdrom, :path => "/srv/metal-amd64.iso"
      domain.storage :file, :size => '20G', :type => 'raw'
      domain.boot 'hd'
      domain.boot 'cdrom'
    end
  end

  config.vm.define "master-2" do |vm|
    vm.vm.network "public_network",
      dev: "br0",
      mode: "bridge",
      type: "bridge"

    vm.vm.provider :libvirt do |domain|
      domain.cpus = 2
      domain.memory = 2048
      domain.serial :type => "file", :source => {:path => "/tmp/control-plane-node-2.log"}
      domain.storage :file, :device => :cdrom, :path => "/srv/metal-amd64.iso"
      domain.storage :file, :size => '20G', :type => 'raw'
      domain.boot 'hd'
      domain.boot 'cdrom'
    end
  end

  config.vm.define "master-3" do |vm|
    vm.vm.network "public_network",
      dev: "br0",
      mode: "bridge",
      type: "bridge"

    vm.vm.provider :libvirt do |domain|
      domain.cpus = 2
      domain.memory = 2048
      domain.serial :type => "file", :source => {:path => "/tmp/control-plane-node-3.log"}
      domain.storage :file, :device => :cdrom, :path => "/srv/metal-amd64.iso"
      domain.storage :file, :size => '20G', :type => 'raw'
      domain.boot 'hd'
      domain.boot 'cdrom'
    end
  end

  config.vm.define "node-1" do |vm|
    vm.vm.network "public_network",
      dev: "br0",
      mode: "bridge",
      type: "bridge"

    vm.vm.provider :libvirt do |domain|
      domain.cpus = 4
      domain.memory = 8192
      domain.serial :type => "file", :source => {:path => "/tmp/worker-node-1.log"}
      domain.storage :file, :device => :cdrom, :path => "/srv/metal-amd64.iso"
      domain.storage :file, :size => '100G', :type => 'raw'
      domain.boot 'hd'
      domain.boot 'cdrom'
    end
  end

  config.vm.define "node-2" do |vm|
    vm.vm.network "public_network",
      dev: "br0",
      mode: "bridge",
      type: "bridge"

    vm.vm.provider :libvirt do |domain|
      domain.cpus = 4
      domain.memory = 8192
      domain.serial :type => "file", :source => {:path => "/tmp/worker-node-2.log"}
      domain.storage :file, :device => :cdrom, :path => "/srv/metal-amd64.iso"
      domain.storage :file, :size => '100G', :type => 'raw'
      domain.boot 'hd'
      domain.boot 'cdrom'
    end
  end
end
