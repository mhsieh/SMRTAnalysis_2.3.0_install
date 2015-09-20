#!/bin/bash -e
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/opt/vagrant_ruby/bin:$PATH
cat > /var/spool/torque/mom_priv/config <<EOF
\$pbsserver      master
\$logevent       255
EOF
