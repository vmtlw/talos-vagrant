```
apt install virt-manager nc vagrant vagrant-libvirt
systemctl enable --now libvirtd
create bridge br0!
modprobe tun
vagrant up 
manual remove NAT vagrant network from virt-manager else virsh


curl -sL https://talos.dev/install | sh
talosctl gen config cluster.local https://10.0.0.173:6443 --install-disk /dev/vda -f --config-patch @config_path.yaml

vim controlplane.yaml and worker.yaml:

##########################
network:
    interfaces:
      - deviceSelector:
          busPath: "0*"
        dhcp: true
##########################
export TALOSCONFIG=$(realpath ./talosconfig)
talosctl config endpoint 10.0.0.154 10.0.0.177 10.0.0.203 10.0.0.249
talosctl -n 10.0.0.173 apply-config --insecure --file controlplane.yaml
talosctl -n 10.0.0.131 apply-config --insecure --file controlplane.yaml
talosctl -n 10.0.0.234 apply-config --insecure --file controlplane.yaml
talosctl -n 10.0.0.162 apply-config --insecure --file worker.yaml
talosctl -n 10.0.0.100 apply-config --insecure --file worker.yaml
talosctl -n 10.0.0.173 bootstrap
talosctl -n 10.0.0.131 kubeconfig ./kubeconfig -f
mkdir -p ~/.kube; cp ~/.kube/config ~/.kube/config-old-$(date +%Y-%m-%d_%H-%M_%S); cp ./kubeconfig ~/.kube/config
kubectl get nodes -o wide



```
