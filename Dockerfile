FROM ubuntu

ARG USER=user
ARG PASSWD=password
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get upgrade -y

# Install software 
RUN apt-get install --no-install-recommends -y \
    ack curl dnsutils entr fd-find file fzf git hexedit jq less man moreutils \
    nodejs npm openssh-client python3 python3-pip software-properties-common \
    sudo tmux tree vim watch wget gcc g++ zsh

RUN add-apt-repository ppa:neovim-ppa/unstable -y && apt-get update -y && \
        apt-get install neovim -y

# User creation
RUN useradd -m ${USER} && \
    usermod -aG sudo ${USER} && \
    echo "${USER}:${PASSWD}" | chpasswd && \
    chsh -s /bin/zsh ${USER} && \
    chown -R ${USER}:${USER} /home/${USER}

USER $USER

# Install dotfiles
RUN curl -Lks https://bit.do/samirdotfiles | bash

WORKDIR /home/${USER}
