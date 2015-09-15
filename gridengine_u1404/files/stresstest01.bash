#!/bin/bash
for i in {1..1000}; do
    qsub -S /bin/bash -sync y -V -j y -r n /vagrant/files/sleep.bash $i &
done
while [ `pgrep qsub | wc -l` -gt 0 ]; do
    sleep 10
done
