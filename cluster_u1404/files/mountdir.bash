#!/bin/bash
cat >> /etc/fstab << EOF
head01:/smrtanalysis /smrtanalysis nfs rsize=131072,wsize=524288,tcp,nfsvers=3 0 0
EOF
mkdir -p /smrtanalysis
mount /smrtanalysis
