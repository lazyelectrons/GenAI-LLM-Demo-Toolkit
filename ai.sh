#!/bin/bash
# ---------------------------------------- #
# Driver  install script for AI/LLM workloads
# For x86_64/Ubuntu 20.04 LTS
# Jun 2024, rajeshvs
# ---------------------------------------- #
# update the system
LOG_FILE=$HOME/ucsx-ai.log
exec > >(tee -i $LOG_FILE) 2>&1
# disable apparmor
sudo systemctl stop apparmor
sudo systemctl disable apparmor
# update the system
echo "** Updaring Packages **" 
sudo apt-get update
#install Cuda 12.5
echo "Installing Cuda"
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt install -y cuda-toolkit-12-5
sudo apt-get update
# Local install of Cuda
#wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
#sudo mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
#wget https://developer.download.nvidia.com/compute/cuda/12.5.0/local_installers/cuda-repo-ubuntu2204-12-5-local_12.5.0-555.42.02-1_amd64.deb
#sudo dpkg -i cuda-repo-ubuntu2204-12-5-local_12.5.0-555.42.02-1_amd64.deb
#sudo cp /var/cuda-repo-ubuntu2204-12-5-local/cuda-*-keyring.gpg /usr/share/keyrings/
#sudo apt-get update
#sudo apt-get -y install cuda-toolkit-12-5
# ---------------------------------------- #
# legacy cuda drivers
# sudo apt install -y cuda-drivers
# open kernel drivers
sudo apt install -y nvidia-driver-555-open
sudo apt install -y cuda-drivers-555
# Disable Firewall
sudo systemctl disable ufw
#install Docker
#  remove snap-docker
sudo snap remove docker --purge
# 
echo "Installing Docker"
sudo apt-get install -y uidmap
curl https://get.docker.com | sh \
  && sudo systemctl --now enable docker
/usr/bin/dockerd-rootless-setuptool.sh install
#nvidia container toolkit
# optional - add nvidia repo
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
      && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
      && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
            sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
            sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
# update
sudo apt-get update \
    && sudo sudo apt-get install -y nvidia-container-toolkit
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker
# configure docker/nvidia runtime in rootless mode
nvidia-ctk runtime configure --runtime=docker --config=$HOME/.config/docker/daemon.json
systemctl --user restart docker
sudo nvidia-ctk config --set nvidia-container-cli.no-cgroups --in-place
# -- finish installing basic drivers/platform stuff --#
# install miniconda 
echo "Installing Miniconda" 
wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.10.3-Linux-x86_64.sh
bash Miniconda3-py39_4.10.3-Linux-x86_64.sh -b
# install ubuntu development tools
# optional - comment out in case not running baremetal workloads
echo "Installing Ubuntu Development Tools"
sudo apt-get install -y build-essential
sudo apt-get install -y cmake
sudo apt-get install -y git
sudo apt-get install -y libopencv-dev
sudo apt-get install -y libssl-dev
sudo apt-get install -y pkg-config
sudo apt-get install -y python3-dev
sudo apt-get install -y python3-pip
sudo apt-get install -y python3-venv
sudo apt-get install -y python3-wheel
sudo apt-get install -y python3-tk
sudo apt-get install -y python3-setuptools
# install AI/ML libraries
echo "**** Installing AI/ML Libraries ****"
pip3 install torch torchvision torchaudio
# AI Monitor # 
sudo mkdir /ai
sudo git -C /ai clone https://github.com/pl247/ai-monitor
sudo chmod a+x /ai/ai-monitor
# install huggingface hub
pip3 install huggingface_hub
# install ntvop
sudo apt-get install -y nvtop
#---------------------------------------- #
#---------------------------------------- #
echo "#---------------------------------------- #" 
echo "Completed GPU/AI driver/tools install" 
echo "#---------------------------------------- #" 
# Reboot #
echo "Rebooting the system"
sudo reboot
# ---------------------------------------- #
