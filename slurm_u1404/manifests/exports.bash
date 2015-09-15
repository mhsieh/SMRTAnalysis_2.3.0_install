#!/bin/bash -e
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/opt/vagrant_ruby/bin:$PATH
/etc/init.d/nfs-kernel-server start
mkdir -p /smrtanalysis
chown -R vagrant /smrtanalysis
cat >> /etc/exports << EOF
/smrtanalysis *(rw,root_squash,subtree_check)
EOF
exportfs -a
/etc/init.d/nfs-kernel-server restart
