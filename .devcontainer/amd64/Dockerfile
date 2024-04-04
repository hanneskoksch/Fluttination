FROM ubuntu:latest

# Set locale
ENV LANG C.UTF-8
# Specify flutter version
ENV FLUTTER_CHANNEL="stable"
ENV FLUTTER_VERSION="3.19.5"
ENV PATH=/home/vscode/flutter/bin:${PATH}
# Misc variables
ENV GIT_SSL_NO_VERIFY=1

# This Dockerfile adds a non-root user with sudo access. Use the "remoteUser"
# property in devcontainer.json to use it. On Linux, the container user's GID/UIDs
# will be updated to match your local UID/GID (when using the dockerFile property).
# See https://aka.ms/vscode-remote/containers/non-root-user for details.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Install needed packages, setup user and clean up.
RUN  apt update \
	&& apt install -y sudo \
	&& apt install -y wget curl git xz-utils zip unzip chromium-browser --no-install-recommends 

RUN	apt-get autoremove -y \
	&& apt-get clean -y \
	&& rm -rf /var/lib/apt/lists/* 

RUN	groupadd --gid $USER_GID $USERNAME \
	&& useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
	&& echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
	&& chmod 0440 /etc/sudoers.d/$USERNAME \
	&& su $USERNAME \
	&& cd $HOME

# Flutter SDK
# https://flutter.dev/docs/development/tools/sdk/releases?tab=linux
RUN curl -k -C - --output flutter.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/${FLUTTER_CHANNEL}/linux/flutter_linux_${FLUTTER_VERSION}-${FLUTTER_CHANNEL}.tar.xz \
	&& tar -xf flutter.tar.xz -C /home/vscode \
	&& rm flutter.tar.xz

RUN git config --global --add safe.directory /home/vscode/flutter

RUN flutter --version