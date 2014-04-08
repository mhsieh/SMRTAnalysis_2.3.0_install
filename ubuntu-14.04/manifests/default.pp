exec { 'firewall-off':
  command => 'ufw disable',
  path => [ '/usr/sbin' ],
}
package { 'rsync': ensure => present, }
exec { 'install':
  command => '/vagrant/files/install.bash',
  user => 'vagrant',
  path => [ '/bin' ],
  timeout => 0,
  require => [ Package['rsync'], Exec['firewall-off'] ],
}
exec { 'smrtportal-start':
  command => '/home/vagrant/admin/bin/tomcatd start',
  user => 'vagrant',
  path => [ '/bin', '/usr/bin' ],
  require => [ Exec['install'] ],
}
exec { 'register-smrtportal':
  command => '/vagrant/files/register.bash',
  user => 'vagrant',
  path => [ '/bin', '/usr/bin' ],
  require => [ Exec['smrtportal-start'] ],
}
