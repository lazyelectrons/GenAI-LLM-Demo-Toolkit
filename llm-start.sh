#!/bin/bash
# ---------------------------------------- #
# install script for AI Demos
# Install/start textgen container
# Jun 2024, rajeshvs
# ---------------------------------------- #
# Test
echo "Testing Docker and CUDA"
docker run --rm --runtime=nvidia --gpus all nvidia/cuda:11.6.2-base-ubuntu20.04 nvidia-smi
if [[ $? -eq 0 ]]; then
    echo "CUDA/Container runtime is working"
#    read -p "Press enter to continue"
else
    echo "###### Error: CUDA/container-runtime failure, run 'bash /ai/ai.sh' to install the drivers ######"
    exit
fi
# start text generation container
echo "Starting LLM Chat UI"
cd ./text-generation-webui-docker
IP=$(hostname --ip-address)
docker compose -f docker-compose-ob.yml  up -d
if [[ $? -eq 0 ]]; then
    echo "**********************************************************************************"
    echo "Model loader UI Started at http://$IP:7070" 
    echo "**********************************************************************************"
else
    echo "###### Error: Chat UI did not start, check the logs ######"
    exit
fi
cd ../
docker compose -f docker-compose-ow.yml up -d
if [[ $? -eq 0 ]]; then
    echo "**********************************************************************************"
    echo "RAG/Chat UI Started at http://$IP:8080"
    echo "**********************************************************************************"
else
    echo "###### Error: OpenWebUI failed to start ######"
fi
# end of script
