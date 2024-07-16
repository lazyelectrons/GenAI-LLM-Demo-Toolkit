## GenAI/LLM Demo Toolkit
This repository provides scripts to automate the installation of the GenAI (Generative AI) software stack on a single node. Ideal for demonstration and testing purposes, this stack simplifies the setup process, allowing you to focus on exploring and evaluating various GenAI tools and capabilities.

This setup installs three application payloads in containers:
- **[Oogaboogaa](https://github.com/oobabooga/text-generation-webui)** for LLM/Chat
- **[OpenWebUI](https://github.com/open-webui/open-webui)** for RAG
- **[Stable Diffusion Web UI](https://github.com/AUTOMATIC1111/stable-diffusion-webui)** for image generation
- **[AI Monitor](https://github.com/pl247/ai-monitor)** for GPU/CPU utilization monitoring 

This enables you to quickly configure a system with a GPU to run open-source GenAI/LLMs locally. Currently, it supports NVIDIA GPUs.

Special thanks to the [AI Toolkit](https://github.com/AI-Toolkit)  for the inspiration.


### What's Included

- **Installation Scripts**: Automated scripts to install all baseline packages and dependencies.
- **LLM Text Gen UI**: To run various models on the local node.
- **OpenWebUI**: For RAG.
- **Stable Diffusion**: For image generation.
- **Docker Infrastructure**: In case you'd like to run Nvidia NIMs.
- **Baseline Libraries**: Torch, Conda, and others, in case you like to experiment or run bare-metal loads.

### Requirements
- **Operating System**: Ubuntu 22.04 LTS
- **Hardware**: 
  - NVIDIA GPU with CUDA support
  - At least 100 GB free disk space
- **Software**:
  - ubuntu minimal install
  - sudo access

### Installation Instructions

1. **Clone the Repository**
    ```sh
    git clone https://github.com/lazyelectrons/GenAI-LLM-Demo-Toolkit.git
    ```
    ```
    cd GenAI-LLM-Demo-Toolkit
    ```
2. **Run the CUDA/Driver Installation Script**
    ```sh
    ./ai.sh
    ```

   This script will install all necessary drivers, and platform tools and reboot the server.
   After the reboot, you can proceed with the next steps.

3. **Install and Start LLM/Web UI containers**

    ```sh
    ./llm-install.sh
    ```

    This command will install and textgen UI and, OpenWebUI, and dowload microsoft Phi model for textgen UI and start both applications.
    Once the installation is complete, you can access the LLM UI using the following URLs:

    - ***Text Gen Web UI*** Web UI via `http://<serverIP>:7070`
    - ***Open Web UI***: Access via `http://<serverIP>:8080`


4. **Monitor GPU/CPU Utilization**

    On a separate terminal, run the following command:
    ```
    python /ai/ai-monitor/ai-monitor.py
    ```
    You can monitor the CPU and GPU utliization on the terminal.

5. **To stop the LLM Containers**
    ```
    ./llm-stop.sh
    ```
    This will stop the LLM containers but will not remove them. 

6. **To run the LLM Containers again**
    ```
    ./llm-start.sh
    ```
    This will start the LLM containers again.

7. **To Install/Start stable diffusion ImageGen**
    ```
    ./image-gen-install.sh
    ```
    This will install the stable diffusion image generator and start the application.
    You can access the image generation application via `http://<server IP>:7860`

8. **To stop the stable diffusion Image Gen**
    ```
    ./image-gen-stop.sh
    ```
    This will stop the stable diffusion image generator but will not remove it.

9. **To run the stable diffusion Image Gen again**
    ```
    ./image-gen-start.sh
    ```
    This will re-start the stable diffusion image generator .

