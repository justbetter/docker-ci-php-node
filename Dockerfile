
ARG UBUNTU_VERSION=22.04
FROM ubuntu:${UBUNTU_VERSION}
ARG UBUNTU_VERSION
ARG NODE_VERSION=20
ARG PHP_VERSION=8.2

LABEL ubuntu=${UBUNTU_VERSION}
LABEL php=${PHP_VERSION}
LABEL node=${NODE_VERSION}

ENV TZ=UTC
ENV COMPOSER_ALLOW_SUPERUSER=1

RUN export LC_ALL=C.UTF-8 && \
    DEBIAN_FRONTEND=noninteractive && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo

RUN apt-get update && \
    apt-get install -y \
    sudo \
    autoconf \
    autogen \
    language-pack-en-base \
    wget \
    zip \
    unzip \
    curl \
    rsync \
    ssh \
    openssh-client \
    git \
    build-essential \
    apt-utils \
    software-properties-common \
    nasm \
    libjpeg-dev \
    libpng-dev \
    libpng16-16 && \
    # PHP
    LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php && apt-get update && \
    apt-get install -y \
    php${PHP_VERSION} \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-gd \
    php${PHP_VERSION}-dev \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-bcmath \
    php${PHP_VERSION}-mysql \
    php${PHP_VERSION}-pgsql \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-bz2 \
    php${PHP_VERSION}-sqlite \
    php${PHP_VERSION}-soap \
    php${PHP_VERSION}-intl \
    php${PHP_VERSION}-imap \
    php${PHP_VERSION}-imagick \
    php${PHP_VERSION}-memcached && \
    # install Node
    curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x -o nodesource_setup.sh && bash nodesource_setup.sh && \
    apt-get install nodejs -y && \
    npm install npm@6 -g && \
    # Clean up caches
    apt-get clean && rm -rf /var/cache/apt/lists

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN curl https://get.volta.sh | bash

# Other
RUN mkdir ~/.ssh && \
    touch ~/.ssh_config

# verify versions installed
RUN php -v && php -r "exit((int)!version_compare(PHP_MAJOR_VERSION . '.' . PHP_MINOR_VERSION, '${PHP_VERSION}', '='));"
RUN node -v && [ `node -v | sed -e "s/^v//" -e "s/\..*$//"` -eq ${NODE_VERSION} ]