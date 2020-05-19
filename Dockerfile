FROM ubuntu:20.04

ENV TERM screen-256color
ENV DEBIAN_FRONTEND=noninteractive


RUN apt update && apt install -y \
  apt-transport-https gnupg2 \
  git \
  bash \
  fzf \
  wget \
  python3-dev \
  python3-pip \
  libssl-dev \
  libffi-dev \
  locales \
  curl \
  ripgrep \
  nodejs \
  npm \
  sudo \
  g++ \
  gcc \
  libc6-dev \
  pkg-config \
  make \
  neovim

RUN apt-get install -y software-properties-common

#kubectl
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
    && apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main" \
    && apt update \
    && apt install -y kubectl=1.15.7-00 \
    && apt-get clean  

RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

RUN npm i -g neovim
RUN pip3 install neovim-remote

RUN apt install -y python2-dev && apt clean

# Ubuntu ranger old and doesn't support 'wrap_scroll'.
RUN git clone https://github.com/thornycrackers/ranger.git /tmp/ranger && \
    cd /tmp/ranger && \
    make install

# kustomize
ENV KUSTOMIZE_VERSION 3.5.5
RUN curl -L https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64 -o ./kustomize \
    && chmod +x ./kustomize \
    && mv ./kustomize /usr/local/bin/

# Kubeflow cli
ENV KFCTL_VERSION 1.0.2
RUN wget https://github.com/kubeflow/kfctl/releases/download/v1.0.2/kfctl_v1.0.2-0-ga476281_linux.tar.gz \
    && tar -xzf kfctl_v1.0.2-0-ga476281_linux.tar.gz \
    && mv kfctl /usr/local/bin/ \
    && rm kfctl_v1.0.2-0-ga476281_linux.tar.gz 

# Google Container Tools 
#kpt
ENV KPT_VERSION 0.26.0
RUN wget https://github.com/GoogleContainerTools/kpt/archive/v${KPT_VERSION}.tar.gz \
    && tar -xzf v${KPT_VERSION}.tar.gz -C /usr/local/bin/ \
    && rm -f v${KPT_VERSION}.tar.gz

# Generally a good idea to have these, extensions sometimes need them
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV GOLANG_VERSION 1.14.3

RUN echo "Set disable_coredump false" >> /etc/sudo.conf

## User account
RUN adduser --disabled-password --gecos '' nvim && \
    adduser nvim sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers;

RUN wget https://storage.googleapis.com/golang/go$GOLANG_VERSION.linux-amd64.tar.gz \
    && tar -xzf go$GOLANG_VERSION.linux-amd64.tar.gz -C /usr/local \
    && rm -f go$GOLANG_VERSION.linux-amd64.tar.gz

USER nvim
WORKDIR /home/nvim

RUN mkdir -p ~/go/src/github.com && mkdir ~/go/tgt && mkdir ~/go/bin

ENV GOPATH=/home/nvim/go
ENV GOROOT=/usr/local/go
ENV PATH $PATH:${GOPATH}/bin:${GOROOT}/bin

ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin/" "$GOPATH/tgt" && chmod -R 777 "$GOPATH"

ENV BUFFALO_VERSION 0.16.8
RUN wget https://github.com/gobuffalo/buffalo/releases/download/v${BUFFALO_VERSION}/buffalo_${BUFFALO_VERSION}_Linux_x86_64.tar.gz \
    && tar -xzf ./buffalo_${BUFFALO_VERSION}_Linux_x86_64.tar.gz \
    && mv buffalo ${GOPATH}/bin/ \
    && rm ./buffalo_${BUFFALO_VERSION}_Linux_x86_64.tar.gz

SHELL ["/bin/bash", "-c"]

RUN bash  <(curl -s https://raw.githubusercontent.com/ChristianChiarulli/nvim/master/utils/install.sh)

CMD ["nvim"]
