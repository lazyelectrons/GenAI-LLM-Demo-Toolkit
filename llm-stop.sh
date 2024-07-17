#!/bin/bash
# ---------------------------------------- #
# script for AI Demos
# stop LLM containers
# Jun 2024, rajeshvs
# ---------------------------------------- #
echo "Stopping Modelt UI"
cd ./text-generation-webui-docker
docker compose -f docker-compose-ob.yml down 
echo "Shutting down RAG UI"
cd ../
docker compose -f docker-compose-ow.yml down 
echo "** Done **"
# ---------------------------------------- #
