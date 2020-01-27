#!/bin/bash

yes | sudo apt-get update && yes | sudo apt-get upgrade
yes | sudo apt-get install curl && yes | sudo apt-get install snap

# Install Minikube:
sudo curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

sudo chmod +x minikube

sudo mkdir -p /usr/local/bin/

sudo install minikube /usr/local/bin/

# Install Kubectl:
sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl

sudo chmod +x ./kubectl

sudo mv ./kubectl /usr/local/bin/kubectl

sudo apt-get update && sudo apt-get install -y apt-transport-https
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

# Install Docker:
sudo apt-get install -qy docker.io

# Start Minikube Cluster:
sudo minikube start --vm-driver=none

# Deploy Kubectl Dashboard UI
sudo kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta8/aio/deploy/recommended.yaml

# Create admin-user for Dashboard
sudo touch admin-user.yaml

file1="admin-user.yaml"
echo "apiVersion: v1" > $file1
echo "kind: ServiceAccount" >> $file1
echo "metadata:" >> $file1
echo "  name: admin-user" >> $file1
echo "  namespace: kubernetes-dashboard" >> $file1
cat $file1

sudo touch admin-role-binding.yaml

file2="admin-role-binding.yaml"
echo "apiVersion: rbac.authorization.k8s.io/v1" > $file2
echo "kind: ClusterRoleBinding" >> $file2
echo "metadata:" >> $file2
echo "  name: admin-user" >> $file2
echo "roleRef:" >> $file2
echo "  apiGroup: rbac.authorization.k8s.io" >> $file2
echo "  kind: ClusterRole" >> $file2
echo "  name: cluster-admin" >> $file2
echo "subjects:" >> $file2
echo "- kind: ServiceAccount" >> $file2
echo "  name: admin-user" >> $file2
echo "  namespace: kubernetes-dashboard" >> $file2
cat $file2

# apply rbac
sudo kubectl apply -f admin-role-binding.yaml

# get secret token for login
sudo kubectl -n kubernetes-dashboard describe secret $(sudo kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')

#echo link for dashboard api
echo "http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/"

# start kubectl dashboard
sudo kubectl proxy
