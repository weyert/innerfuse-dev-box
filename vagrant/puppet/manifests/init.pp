stage { 'req-install': before => Stage['rvm-install'] }

class requirements {
  group { "puppet": ensure => "present", }
  exec { "apt-update":
    command => "/usr/bin/apt-get -y update"
  }

  package {
    ["mysql-client", "mysql-server", "libmysqlclient-dev"]: 
      ensure => installed, require => Exec['apt-update']
  }
}

class installrvm {
  include rvm
  rvm::system_user { vagrant: ; }

  if $rvm_installed == "true" {
    rvm_system_ruby {
      'ruby-1.9.3-p194':
        ensure => 'present';
    }
    
    # create ruby gemset
    rvm_gemset {
      "ruby-1.9.3-p194@vagrant":
        ensure => present,
        require => Rvm_system_ruby['ruby-1.9.3-p194'];
    }

    # install useful ruby gems
    rvm_gem {
      'ruby-1.9.3-p194@vagrant/bundler':
        ensure => latest,
        require => Rvm_gemset['ruby-1.9.3-p194@vagrant'];
    }    

    # install capistrano
    rvm_gem {
      'ruby-1.9.3-p194@vagrant/capistrano':
        ensure => latest,
        require => Rvm_gemset['ruby-1.9.3-p194@vagrant'];
    }    

    # install compass
    rvm_gem {
      'ruby-1.9.3-p194@vagrant/compass':
        ensure => latest,
        require => Rvm_gemset['ruby-1.9.3-p194@vagrant'];
    }    
  }
}

class doinstall {
  class { requirements:, stage => "req-install" }
  include installrvm
}

include doinstall