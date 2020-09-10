FROM ubuntu

ARG USER=user
ARG PASSWD=password
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get upgrade -y

# Install software 
RUN apt-get install --no-install-recommends -y \
    ack curl dnsutils entr fd-find file fzf git \
    hexedit jq less man moreutils openssh-client python3 python3-pip sudo tmux \
    tree vim watch wget gcc g++ neovim

# User creation
RUN useradd -m ${USER} && \
    usermod -aG sudo ${USER} && \
    echo "${USER}:${PASSWD}" | chpasswd && \
    chsh -s /bin/bash ${USER} && \
    chown -R ${USER}:${USER} /home/${USER}

USER $USER

# Install dotfiles
RUN curl -Ls http://bit.do/samirdotfiles | bash

WORKDIR /home/${USER}
