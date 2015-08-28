#!/bin/bash -e
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/opt/vagrant_ruby/bin:$PATH
export EDITOR=ex
mod4sync(){
  qconf -sconf global > /tmp/global
  sed -i -e 's/qmaster_params               none/qmaster_params               MAX_DYN_EC=1000/g' /tmp/global
  qconf -Mconf /tmp/global
}
mod4ssh(){
  qconf -sconf global > /tmp/global
  sed -i -e '/^rlogin_command .*/d;
             /^rlogin_daemon .*/d;
             /^rsh_command .*/d;
             /^rsh_daemon .*/d;
             /^qlogin_command .*/d;
             /^qlogin_daemon .*/d' /tmp/global
  cat >> /tmp/global << EOF
rlogin_command               /usr/bin/ssh -X
rlogin_daemon                /usr/sbin/sshd -i
rsh_command                  /usr/bin/ssh -X 
rsh_daemon                   /usr/sbin/sshd -i
qlogin_command               /usr/bin/ssh -X
qlogin_daemon                /usr/sbin/sshd -i
EOF
  qconf -Mconf /tmp/global
}
grep head01 /var/lib/gridengine/default/common/act_qmaster > /dev/null || sleep 10
pgrep -f 'sge_qmaster' || sleep 10
qconf -help > /dev/null
qconf -sm             | grep vagrant      > /dev/null || sudo -u sgeadmin qconf -am vagrant
qconf -su users       | grep vagrant      > /dev/null || qconf -au vagrant users
qconf -ss             | grep head01       > /dev/null || qconf -as head01.local
qconf -ss             | grep node01       > /dev/null || qconf -as node01.local
qconf -ss             | grep node02       > /dev/null || qconf -as node02.local
qconf -shgrpl         | grep @allhosts    > /dev/null || qconf -ahgrp @allhosts << EOF
:wq
EOF
qconf -shgrp @allhosts| grep node01.local > /dev/null || \
qconf -aattr hostgroup hostlist "node01.local node02.local" @allhosts
qconf -sql            | grep main.q       > /dev/null || qconf -aq main.q << EOF
:wq
EOF
qconf -sq main.q      | grep '@allhosts'  > /dev/null || qconf -aattr queue hostlist @allhosts main.q
qconf -spl            | grep smp          > /dev/null || qconf -ap smp << EOF
/^slots
c
slots              99999
.
:wq
EOF
qconf -sq main.q   | grep '^pe_list.*smp' > /dev/null || qconf -aattr queue pe_list 'smp' main.q
qconf -sq main.q   | grep '^slots'        > /dev/null || qconf -rattr queue slots 2 main.q
qconf -sconf global|grep 'MAX_DYN_EC=100' > /dev/null || mod4sync
exit $?

qconf -sconf global | grep 'rlogin_.*ssh' > /dev/null || mod4ssh
qconf -sconf global | grep 'rsh_.*ssh'    > /dev/null || mod4ssh
qconf -sconf global | grep 'qlogin_.*ssh' > /dev/null || mod4ssh
