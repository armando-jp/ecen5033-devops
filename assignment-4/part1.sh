# Letting IP tables see bridged traffic
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

# load settings from all system configuration files.
sudo sysctl --system

# install docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh


# configure docker daemon to use systemd for the management of
# the container groups
sudo mkdir /etc/docker
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

# restart docker and enable on boot
sudo systemctl enable docker
sudo systemctl daemon-reload
sudo systemctl restart docker

# disable swapping on all known swap devices and files
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# install kubernetes using native package management
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl # prevent packages from being updated

# kubeadm: the command to bootstrap the cluster.
# kubelet: the component that runs on all of the machines in your cluster and does things like starting PODs and containers.
# kubectl: the command line until to talk to your cluster.

