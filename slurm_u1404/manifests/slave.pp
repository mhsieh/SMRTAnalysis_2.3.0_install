# -*- mode: ruby -*-
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
    mode => 644,
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
package { 'slurm-llnl': ensure => present, }
exec { 'mountdir':
    command => '/vagrant/manifests/mountdir.bash',
    path => [ '/bin' ],
    require => [ Package['nfs-kernel-server'] ],
}
file { '/etc/munge/munge.key':
    ensure => present,
    mode => 400,
    owner => munge,
    group => 0,
    source => '/vagrant/files/etc/default/munge',
    require => [ Package['slurm-llnl'] ],
}
file { '/etc/slurm-llnl/slurm.conf':
    ensure => present,
    mode => 644,
    owner => munge,
    group => 0,
    source => '/vagrant/files/etc/slurm-llnl/slurm.conf',
    require => [ Package['slurm-llnl'] ],
}
file { '/etc/default/munge':
    ensure => present,
    mode => 644,
    owner => 0,
    group => 0,
    source => '/vagrant/files/etc/default/munge',
    require => [ Package['slurm-llnl'] ],
}
exec { 'mkdirslurmspool':
    command => 'mkdir /var/spool/slurm /var/spool/slurmd',
    path => [ '/bin' ],
    require => [ Package['slurm-llnl'] ],
}
exec { 'chownslurmspool':
    command => 'chown slurm /var/spool/slurm /var/spool/slurmd',
    path => [ '/bin' ],
    require => [ Exec['mkdirslurmspool'] ],
}
exec { 'mungestart':
    command => '/etc/init.d/munge start',
    path => [ '/bin' ],
    require => [ File['/etc/hosts', '/etc/slurm-llnl/slurm.conf'] ],
}
exec { 'slaveconf':
    command => '/vagrant/manifests/slaveconf.bash',
    path => [ '/bin' ],
    require => [ Exec['mungestart', 'chownslurmspool'], File['/etc/slurm-llnl/slurm.conf'] ],
}
