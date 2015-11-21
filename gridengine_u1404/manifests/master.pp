file { '/etc/hosts':
    ensure => present,
    mode => 644,
    owner => 0,
    group => 0,
    source => '/vagrant/files/etc/hosts',
}
file { '/home/vagrant/.ssh/id_rsa':
    ensure => present,
    mode => 600,
    owner => vagrant,
    group => vagrant,
    source => '/vagrant/files/.ssh/id_rsa',
}
file { '/home/vagrant/.ssh/config':
    ensure => present,
    mode => 600,
    owner => vagrant,
    group => vagrant,
    source => '/vagrant/files/.ssh/config',
}
case $operatingsystem {
  'Debian', 'Ubuntu': {
    case $lsbmajdistrelease {
      14: {
      }
      12: {
      }
      10: {
      }
      8: {
      }
    }
    exec { 'apt-update':
      command => '/bin/echo apt-get update',
      path => [ '/usr/bin' ],
    }
    package { 'postfix': ensure => present, require => [ Exec['apt-update'] ], }
    #package { 'bsd-mailx': ensure => present, require => [ Exec['apt-update'] ], }
    #package { 'libdb4.7': ensure => present, require => [ Exec['apt-update'] ], }
    package { 'gridengine-common': ensure => present, }
    package { 'gridengine-client': ensure => present, }
    package { 'gridengine-master': ensure => present, }
    package { 'nfs-kernel-server': ensure => present, }
    service { 'gridengine-master':
      ensure    => running,
      enable    => true,
      require => [ Package['gridengine-master'] ],
    }
    exec { 'qconfig':
      command => '/vagrant/files/masterconf.bash',
      path => [ '/bin' ],
      require => [ Service['gridengine-master'] ],
    }
    exec { 'exports':
      command => '/vagrant/files/exports.bash',
      path => [ '/bin' ],
      require => [ Package['nfs-kernel-server'] ],
    }
  }
}
