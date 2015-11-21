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
exec { 'apt-update':
  command => '/bin/echo apt-get update',
  path => [ '/usr/bin' ],
}
package { 'postfix': ensure => present, require => [ Exec['apt-update'] ], }
package { 'torque-mom': ensure => present, }
package { 'torque-client': ensure => present, } 
exec { 'qconfig':
  command => '/vagrant/manifests/slaveconf.bash',
  path => [ '/bin' ],
  require => [ Package['torque-mom'], File['/etc/hosts'] ],
}
exec { 'mountdir':
  command => '/vagrant/files/mountdir.bash',
  path    => [ '/bin' ],
  require => [ File['/etc/hosts'] ],
}
