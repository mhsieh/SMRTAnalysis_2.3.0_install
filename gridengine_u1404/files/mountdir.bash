#!/bin/bash
cat >> /etc/fstab << EOF
head01:/smrtanalysis /smrtanalysis nfs rsize=131072,wsize=524288,tcp,nfsvers=3 0 0
/swapfile none swap defaults 0 0
EOF
mkdir -p /smrtanalysis
mount /smrtanalysis
dd if=/dev/zero of=/swapfile bs=1M count=1024
/sbin/mkswap /swapfile
/sbin/swapon /swapfile
