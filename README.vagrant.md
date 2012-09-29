# Using the Vagrant PHP development environment

## Get Vagrant, if you don't have already

From http://vagrantup.com/


## startup vagrant

    vagrant up

(this takes up to 15-20 minutes the first time, especially the "composer.phar install" part)

## watch site

go to http://192.168.2.2/app_dev.php and start playing.

## PHP 5.4

If you want PHP 5.4, open the file `vagrant/puppet/manifests/main.pp` and uncomment the line
`include php54dotdeb` and comment out `include php53debian` so that it looks like this

````
include php54dotdeb
#include php53debian
````

## Mysql

If you want to use Mysql, open the file `vagrant/puppet/manifests/main.pp` and uncomment the line
`include mysql` so that it looks like this

````
include mysql
````

The database name and its credentials can be set in the `vagrant/puppet/manifests/parameters.pp` file.
