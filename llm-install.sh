#!/bin/bash
# ---------------------------------------- #
# UCS-X  install script for AI Demos
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
# pull the docker repo for textgen
echo "Downloading Textgen UI"
git clone https://github.com/Atinoda/text-generation-webui-docker
# get updated container configs
cp docker-compose-ob.yml ./text-generation-webui-docker/docker-compose-ob.yml
# ------- #
echo "Downloading Models"
#huggingface-cli download TheBloke/Wizard-Vicuna-13B-Uncensored-HF --local-dir  ./text-generation-webui-docker/config/models/Wizard-Vicuna-13B-Uncensored-HF
#huggingface-cli download TheBloke/Llama-2-13B-chat-GPTQ --local-dir  ./text-generation-webui-docker/config/models/Llama-2-13B-chat-GPTQ
huggingface-cli download microsoft/Phi-3-mini-4k-instruct  --local-dir ./text-generation-webui-docker/config/models/Phi-3-mini-4k-instruct
echo "Starting LLM Chat UI"
cd ./text-generation-webui-docker
docker compose -f docker-compose-ob.yml up -d
if [[ $? -eq 0 ]]; then
    echo "**********************************************************************************"
    echo "Model loader UI Started at http://198.19.5.70:7070"
    echo "**********************************************************************************"
else
    echo "###### Error: Chat UI did not start, check the logs ######"
    exit 1
fi
echo "Starting RAG Chat UI"
# start openweb-ui
# To test the API endpoint is working
# check it with curl http://<server IP>:5000/v1/models 
#
cd ../
docker compose -f docker-compose-ow.yml up -d
if [[ $? -eq 0 ]]; then
    echo "**********************************************************************************"
    echo "RAG/Chat UI Started at http://198.19.5.70:8080"
    echo "**********************************************************************************"
else
    echo "###### Error: Install failed for OpenWebUI ######"
    exit 1
fi
# end of script