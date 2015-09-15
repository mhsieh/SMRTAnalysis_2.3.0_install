#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/opt/vagrant_ruby/bin:$PATH
cp /vagrant/files/etc/rc.local.master /etc/rc.local
slurmctld -D &
disown
