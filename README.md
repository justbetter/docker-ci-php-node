# Docker image for Continuous Integration

## Available tags

See the [docker-ci-php-node package](https://github.com/justbetter/docker-ci-php-node/pkgs/container/docker-ci-php-node)
The tag format is as follows: `<branch/tag>-<ubuntu version>-<php version>-<node version>`

Missing a version? Make a PR adding this to [the version matrix](https://github.com/justbetter/docker-ci-php-node/blob/master/.github/workflows/push-docker-container.yml)

## System information
  * [Ubuntu](https://ubuntu.com/)

## Installed packages
  * ssh
  * openssh-client
  * rsync
  * curl
  * wget
  * PHP
    * mysql
    * pgsql
    * memcached
    * sqlite
    * bz2
    * zip
    * mbstring
    * curl
    * gd
    * xml
    * bcmath
    * intl
    * imap
  * [Composer](https://getcomposer.org/)
  * [PHPUnit](https://phpunit.de/)
  * [Node.js](https://nodejs.org/)
  * [npm](https://www.npmjs.com/)
  * [volta](https://volta.sh/)