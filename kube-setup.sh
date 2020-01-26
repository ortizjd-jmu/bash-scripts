#!/bin/bash

yes | sudo apt-get update && yes | sudo apt-get upgrade
yes | sudo apt-get install curl && yes | sudo apt-get install snap

sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubect

sudo chmod +x ~/kubectl

sudo mv ~/kubectl /usr/local/bin/kubectl

kubectl version --client

yes | sudo apt-get update && yes | sudo apt-get install -y apt-transport-https
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg
sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main"
sudo tee -a /etc/apt/sources.list.d/kubernetes.list
yes | sudo apt-get update && yes | sudo apt-get install -y kubectl

sudo curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

sudo chmod +x minikube

sudo mkdir -p /usr/local/bin/

sudo install minikube /usr/local/bin/

minikube start --vm-driver=none

minikube status

kubectl cluster-info
