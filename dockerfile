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
    && /opt/conda/bin/pip install  opencv-python  \
    && /opt/conda/bin/conda install keras \  
    && /opt/conda/bin/conda install tensorflow \  
    && /opt/conda/bin/conda install -c pytorch pytorch \
    && /opt/conda/bin/conda install dask distributed \   
    && apt-get install -y sudo \
    && echo gitpod ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/gitpod\
    && chmod 0440 /etc/sudoers.d/gitpod \
    
    # Install Chisel
    && curl https://github.com/bangyogesh/MydatascienceEnv/blob/master/chisel_1.5.2_linux_amd64.gz | gzip  \
    
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

USER gitpod
# Apply user-specific settings
#ENV ...

# Give back control
USER root
