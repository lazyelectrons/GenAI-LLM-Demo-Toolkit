#!/bin/bash
# ---------------------------------------- #
# UCS-X  install script for AI Demos
# Install/start image-gen container
# Jun 2024, rajeshvs
# ---------------------------------------- #
# Starting AI Image generation
IP=$(hostname)
cd ./stable-diffusion-webui-docker/
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
