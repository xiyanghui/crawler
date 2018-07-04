
FROM ubuntu:16.04

# 安装 php7.1
RUN apt-get update && apt-get install -y \
    language-pack-en-base \
  && locale-gen en_US.UTF-8 \
  && apt-get install -y \
    software-properties-common \
  && LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php \
  && apt-get update && apt-get install -y \
    php7.1-cli \
    php7.1-fpm \
    php7.1-xml \
    php7.1-mbstring \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir /run/php

# 安装 composer 相关
RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip \
    wget \
  && rm -rf /var/lib/apt/lists/* \
  && wget -O /usr/local/bin/composer https://getcomposer.org/download/1.6.2/composer.phar \
  && chmod +x /usr/local/bin/composer

# 安装 electron 的依赖
RUN apt-get update && apt-get install -y \
    libgtk2.0-0 \
    libnotify-bin \
    libgconf-2-4 \
    libnss3 \
    xvfb \
    libxss1 \
    libasound2 \
  && rm -rf /var/lib/apt/lists/*

# 安装 casperjs 相关依赖
RUN apt-get update && apt-get install -y \
    wget \
    bzip2 \
    libfontconfig1 \
    python \
    make \
  && rm -rf /var/lib/apt/lists/*

# 配置 node 相关环境变量
ENV NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node
ENV NVM_DIR=/usr/local/nvm
ENV NODE_VERSION=8.0.0
ENV NODE_PATH=$NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH=$NVM_DIR/v$NODE_VERSION/bin:$PATH

# 安装 nvm 安装 node 8.0.0
RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash \
  && \. $NVM_DIR/nvm.sh \
  && nvm install $NODE_VERSION \
  && nvm alias default $NODE_VERSION \
  && ln -s $(which node) /usr/bin/node \
  && ln -s $(which npm) /usr/bin/npm \
  && nvm use default \
  && npm config set user 0 \
  && npm config set unsafe-perm true
#  && npm install -g node-env-file

# 安装 nginx
RUN apt-get update && apt-get install -y \
    nginx \
  && rm -rf /var/lib/apt/lists/*

# 安装 xdebug
RUN apt-get update && apt-get install -y \
    php-xdebug\
  && rm -rf /var/lib/apt/lists/*

# 安装 php7.1-curl
RUN apt-get update && apt-get install -y \
    php7.1-curl\
  && rm -rf /var/lib/apt/lists/*

