Vagrant.require_version ">= 1.4.3"
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	numNodes = 3 
	r = numNodes..1
	(r.first).downto(r.last).each do |i|
		config.vm.define "node-#{i}" do |node|
			node.vm.box = "centos7"
			node.vm.provider "virtualbox" do |v|
			  v.name = "node#{i}"
			  v.customize ["modifyvm", :id, "--memory", "1024"]
			end
			if i < 10
				node.vm.network :private_network, ip: "10.211.55.10#{i}"
			else
				node.vm.network :private_network, ip: "10.211.55.1#{i}"
			end
			node.vm.hostname = "node#{i}"
			node.vm.provision "shell", path: "scripts/setup-centos-network-c7.sh"
			node.vm.provision "shell", path: "scripts/setup-os.sh"
			node.vm.provision "shell" do |s|
				s.path = "scripts/setup-centos-hosts.sh"
				s.args = "-t #{numNodes}"
			end
			if i == 2
				node.vm.provision "shell" do |s|
					#s.path = "scripts/setup-centos-ssh.sh"
					#s.args = "-s 3 -t #{numNodes}"
					s.path = "scripts/setup-ssh-other.sh"
				end
			elsif i == 1
				node.vm.provision "shell" do |s|
					#s.path = "scripts/setup-centos-ssh.sh"
					#s.args = "-s 2 -t #{numNodes}"
					s.path = "scripts/setup-ssh-master.sh"
				end
			else
				node.vm.provision "shell", path: "scripts/setup-ssh.sh"
			end
			node.vm.provision "shell", path: "scripts/setup-java.sh"
			node.vm.provision "shell", path: "scripts/setup-hadoop.sh"
			node.vm.provision "shell" do |s|
				s.path = "scripts/setup-hadoop-slaves.sh"
				s.args = "-s 3 -t #{numNodes}"
			end
			node.vm.provision "shell", path: "scripts/setup-spark.sh"
			node.vm.provision "shell" do |s|
				s.path = "scripts/setup-spark-slaves.sh"
				s.args = "-s 3 -t #{numNodes}"
			end
		end
	end
end
