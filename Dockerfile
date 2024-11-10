FROM ubuntu:18.04

RUN apt-get update && apt-get install -y software-properties-common binutils

# Avoid interactive prompts during apt install
ENV DEBIAN_FRONTEND=noninteractive

# Update and install required packages, compile Python from source
RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y wget build-essential checkinstall \
    libreadline-gplv2-dev libncursesw5-dev libssl-dev \
    libsqlite3-dev tk-dev libgdbm-dev libc6-dev \
    libbz2-dev libffi-dev zlib1g-dev curl && \
    cd /usr/src && \
    wget https://www.python.org/ftp/python/3.8.10/Python-3.8.10.tgz && \
    tar xzf Python-3.8.10.tgz && \
    cd Python-3.8.10 && \
    ./configure --enable-optimizations --enable-shared && \
    make altinstall && \
    # Install pip for Python 3.8 with LD_LIBRARY_PATH set temporarily
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    LD_LIBRARY_PATH=/usr/local/lib /usr/local/bin/python3.8 get-pip.py && \
    # Clean up unnecessary files to reduce image size
    rm get-pip.py && \
    rm -rf /usr/src/Python-3.8.10*

# Set LD_LIBRARY_PATH to include the shared library path
ENV LD_LIBRARY_PATH="/usr/local/lib"

# Set the working directory in the container
WORKDIR /app

# Copy the main.py file from the local directory into the /app directory inside the container
COPY ./app/main.py /app/

# Copy the requirements.txt file into the container
COPY requirements.txt /app/

# Install dependencies from the requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Install PyInstaller and create a standalone executable
RUN python3.8 -m pip install --upgrade pip && \
    python3.8 -m pip install pyinstaller

# Keep the container running (prevents it from exiting)
# CMD ["tail", "-f", "/dev/null"]