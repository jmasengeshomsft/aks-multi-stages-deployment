#!/bin/bash

apt-get --yes --quiet update
apt-get --yes --quiet upgrade

apt-get --yes --quiet install ca-certificates curl apt-transport-https lsb-release gnupg

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

snap install --classic kubectl






