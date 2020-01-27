#!/bin/bash

yes | sudo apt-get update && yes | sudo apt-get upgrade

# This installs vscode
yes | sudo apt install software-properties-common apt-transport-https wget

wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

yes | sudo apt update && yes | sudo apt install code

# This installs git
yes | sudo apt install git

# Setup git
git config --global user.name "ortizjd-jmu"
git config --global user.email "ortizjd@dukes.jmu.edu"

# Opens vscode
code
