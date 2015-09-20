#!/bin/bash -e
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/opt/vagrant_ruby/bin:$PATH
#hostname
/etc/init.d/torque-scheduler stop
killall -9 pbs_sched || true
/etc/init.d/torque-server stop
killall -9 pbs_server || true
#yes | sh /usr/share/doc/torque-common/torque.setup root
#killall -9 pbs_server || true
yes | pbs_server -t create
qmgr -c "set server acl_hosts=master"
qmgr -c "set server scheduling=true"
qmgr -c "create queue batch queue_type=execution"
qmgr -c "set queue batch started=true"
qmgr -c "set queue batch enabled=true"
qmgr -c "set queue batch resources_default.nodes=1"
qmgr -c "set queue batch resources_default.walltime=3600"
qmgr -c "set server default_queue=batch"
qmgr -c "set server keep_completed = 10"
echo  "master np=1" > /var/spool/torque/server_priv/nodes
for i in `seq 1 2`; do
    echo  "node$i np=2" >> /var/spool/torque/server_priv/nodes
done
cat > /var/spool/torque/mom_priv/config <<EOF
\$pbsserver      master
\$logevent       255
EOF
qterm
/etc/init.d/torque-server start
/etc/init.d/torque-scheduler start
