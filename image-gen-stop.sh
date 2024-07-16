#!/bin/bash
# ---------------------------------------- #
# UCS-X  install script for AI Demos
# Install/start textgen container
# Jun 2024, rajeshvs
# ---------------------------------------- #
# Stopping AI Image generation
# - 
echo "**************************************************"
echo " Stopping AI Image generation UI"
echo "**************************************************"
cd ./stable-diffusion-webui-docker/
docker compose --profile auto  down
if [[ $? -eq 0 ]]; then
    echo "**************************************************"
    echo "Image Gen UI Stopped"
    echo "**************************************************"
else
    echo "###### Error: Image Gen UI did not stop, check the logs ######"
fi
cd ../
#
# end of script
