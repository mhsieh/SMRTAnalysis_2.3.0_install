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
    package { 'gridengine-common': ensure => present, }
    package { 'gridengine-client': ensure => present, }
    package { 'gridengine-exec':   ensure => present, }
    exec { 'whereistheqmaster':
      command => 'echo master > /var/lib/gridengine/default/common/act_qmaster',
      path    => [ '/bin' ],
      notify  => Service['gridengine-exec'],
      require => [ Package['gridengine-exec'] ],
    }
    service { 'gridengine-exec':
      ensure  => 'running',
      enable  => 'true',
      require => [ Package['gridengine-exec'] ],
    }
    exec { 'mountdir':
      command => '/vagrant/files/mountdir.bash',
      path    => [ '/bin' ],
    }
  }
}
