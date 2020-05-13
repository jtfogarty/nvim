FROM continuumio/miniconda3

# Better terminal support https://github.com/thornycrackers/docker-neovim/blob/master/Dockerfile
ENV TERM screen-256color
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update --fix-missing && \
    apt-get install -y --no-install-recommends python3-dev gcc && \
    apt-get install -y --no-install-recommends  ripgrep silversearcher-ag fd-find universal-ctags fzf
# ranger ueberzug

# Update and install
RUN apt-get update && apt-get install -y --no-install-recommends \
      htop \
      bash \
      curl \
      wget \
      git \
      software-properties-common \
      python-dev \
      ctags \
      shellcheck \
      netcat \
      ack-grep \
      unzip \
      locales \
      cmake \
      make

WORKDIR /root

#setup python env
RUN conda create --quiet --yes -n neovim python=3.8
#ADD environment.yml .
#RUN conda env create -f environment.yml

#RUN pip install --no-cache-dir --upgrade --force-reinstall pynvim neovim-remote 

# Generally a good idea to have these, extensions sometimes need them
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Install Neovim
RUN wget https://github.com/neovim/neovim/releases/download/v0.4.3/nvim-linux64.tar.gz
RUN tar -xzvf nvim-linux64.tar.gz
RUN rm nvim-linux64.tar.gz

RUN git clone https://github.com/ChristianChiarulli/nvim.git ~/.config/nvim

# Ubuntu ranger old and doesn't support 'wrap_scroll'.
RUN git clone https://github.com/thornycrackers/ranger.git /tmp/ranger && \
    cd /tmp/ranger && \
    make install

RUN cd /root

#RUN /root/nvim-linux64/bin/nvim -i NONE -c PlugInstall -c quitall > /dev/null 2>&1


CMD ["/bin/bash"]