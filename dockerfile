FROM continuumio/anaconda3

USER root
# Install custom tools, runtime, etc.
RUN apt-get update && apt-get install -y \
    && apt-get -y install --no-install-recommends apt-utils dialog 2>&1 \
    #
    # Verify git, process tools, lsb-release (common in install instructions for CLIs) installed
    && apt-get -y install git iproute2 procps iproute2 zip unzip net-tools wget curl gzip lsb-release \
    #
    # Install pylint
    && /opt/conda/bin/pip install pylint \
       # [Optional] Add sudo support for the non-root user
    && /opt/conda/bin/pip install  opencv-python paramiko joblib \
    && /opt/conda/bin/conda install keras \  
    && /opt/conda/bin/conda install tensorflow \  
    && /opt/conda/bin/conda install -c pytorch pytorch \
    && /opt/conda/bin/conda install dask distributed \  
    && /opt/conda/bin/conda install bokeh \
    && apt-get install -y sudo \
    && echo gitpod ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/gitpod\
    && chmod 0440 /etc/sudoers.d/gitpod \
    
    # Install Chisel
    # && curl -o chisel.gz 'https://github-production-release-asset-2e65be.s3.amazonaws.com/31311037/c901f080-9abf-11ea-8188-3483e6c724a7?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20200613%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20200613T083300Z&X-Amz-Expires=300&X-Amz-Signature=15a316607904c8a3639f6979b3b428925ac95fd22cc3748876e8bdee3014e70d&X-Amz-SignedHeaders=host&actor_id=0&repo_id=31311037&response-content-disposition=attachment%3B%20filename%3Dchisel_1.5.2_linux_amd64.gz&response-content-type=application%2Foctet-stream'  \
    # && gunzip -d chisel.gz \
    # && chmod +x chisel \ 
    
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

USER gitpod
# Apply user-specific settings
#ENV ...

# Give back control
USER root
