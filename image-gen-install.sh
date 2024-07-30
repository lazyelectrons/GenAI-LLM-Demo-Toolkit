#!/bin/bash
# ---------------------------------------- #
# UCS-X  install script for AI Demos
# Install/start textgen container
# Jun 2024, rajeshvs
# ---------------------------------------- #
# Starting AI Image generation
git clone https://github.com/AbdBarho/stable-diffusion-webui-docker
cd stable-diffusion-webui-docker/
IP=$(hostname --ip-address)
docker compose --profile auto  up --build -d
if [[ $? -eq 0 ]]; then
    echo "**************************************************"
    echo "Image Gen UI Started at http://$IP:7860"
    echo "**************************************************"
else 
    echo "###### Error: Image Gen UI did not start, check the logs ######"
fi
cd ../
# end of script
