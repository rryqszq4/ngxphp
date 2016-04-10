#!/bin/bash
mkdir build
cd build
mkdir php
mkdir nginx
echo "php download ..."
wget http://php.net/get/php-${PHP_SRC_VERSION}.tar.gz/from/this/mirror
echo "php download ... done"
tar xf php-${PHP_SRC_VERSION}.tar.gz

PHP_SRC=`pwd`'/php-'${PHP_SRC_VERSION}
cd ${PHP_SRC}

echo "php install ..."
./configure --prefix=../php \
--with-config-file-path=../php/etc \
--with-mysql=mysqlnd \
--with-mysqli=mysqlnd \
--with-pdo-mysql=mysqlnd \
--with-zlib \
--enable-xml \
--enable-magic-quotes \
--enable-safe-mode \
--enable-bcmath \
--enable-shmop \
--enable-sysvsem \
--with-curl \
--enable-mbregex \
--enable-mbstring \
--with-mcrypt \
--with-openssl \
--with-mhash \
--enable-pcntl \
--enable-sockets \
--with-xmlrpc \
--enable-zip \
--enable-soap \
--without-pear  \
--enable-embed
make
make install
echo "php install ... done"

cd ..
echo "nginx download ..."
wget http://nginx.org/download/nginx-${NGINX_SRC_VERSION}.tar.gz
echo "nginx download ... done"
tar xf nginx-${NGINX_SRC_VERSION}.tar.gz

NGINX_SRC=`pwd`'/nginx'${NGINX_SRC_VERSION}
cd ${NGINX_SRC}

export PHP_BIN=${PHP_SRC}'/bin'
export PHP_INC=${PHP_SRC}'/inc'
export PHP_LIB=${PHP_SRC}'/lib'

echo "nginx install ..."
./configure --prefix=../nginx --add-module=../../../ngx_php
make
make install
echo "nginx install ... done"

echo "ngx_php compile success."