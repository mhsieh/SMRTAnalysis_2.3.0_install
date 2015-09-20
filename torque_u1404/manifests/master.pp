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
  command => 'apt-get update',
  path => [ '/usr/bin' ],
}
package { 'postfix': ensure => present, require => [ Exec['apt-update'] ], }
package { 'nfs-kernel-server': ensure => present, }
package { 'torque-server':
  ensure => present,
  require => [ File['/etc/hosts'] ],
}
package { 'torque-scheduler': ensure => present, }
package { 'torque-mom': ensure => present, }
package { 'torque-client': ensure => present, } 
exec { 'qconfig':
  command => '/vagrant/manifests/masterconf.bash',
  path => [ '/bin' ],
  require => [ Package['torque-server','torque-scheduler','torque-mom','torque-client'], File['/etc/hosts'] ],
}
exec { 'exports':
  command => '/vagrant/files/exports.bash',
  path => [ '/bin' ],
  require => [ Package['nfs-kernel-server'], File['/etc/hosts'] ],
}
