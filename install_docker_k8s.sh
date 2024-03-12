# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt remove containerd

sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl restart containerd

sudo docker run -d hello-world

sudo chmod 777 /var/run/docker.sock

docker ps -a

sleep 5

# Install MicroK8s and ArgoCD

sudo apt update

sudo apt install snapd

sudo snap install core

sudo snap refresh core

sudo snap install microk8s --classic

echo 'Setting Permissions'
sudo usermod -a -G microk8s runner
sudo grep microk8s /etc/group
sudo groups runner
sudo mkdir -p ~/.kube
sudo chown -R runner ~/.kube
newgrp microk8s
echo 'Permissions Set.'

echo 'Check microk8s status'
sudo microk8s status --wait-ready

sleep 10

echo 'which microk8s -> ' which microk8s

echo 'PATH -> ' $PATH

sudo microk8s kubectl get nodes

sudo microk8s kubectl create namespace argocd

sudo microk8s kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
