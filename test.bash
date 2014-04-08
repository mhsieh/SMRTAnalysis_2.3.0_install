#!/bin/bash
if [ ! -d install/smrtanalysis-2.2.0.133377 ]; then
   bash distfiles/smrtanalysis-2.2.0.133377.run \
      --rootdir $PWD \
      -p distfiles/smrtanalysis-2.2.0.133377-patch-0.0.run \
      --skip-userquery \
      --ignore-syscheck \
      --dnsname 127.0.0.1 \
      --smrtportal-main-port 8080 \
      --smrtportal-shutdown-port 8005 \
      --tmpdir /tmp \
      --skip-userdataquery \
      --dbport 53306 \
      --jmstype NONE \
      --numprocs 2 \
      --batch
fi
admin/bin/tomcatd start
sleep 9
pgrep -f tomcat || exit $?
pgrep -f mysql  || exit $?
curl -s http://localhost:8080/smrtportal/ > /dev/null
curl -s http://localhost:8080/smrtportal/api/about/ | \
   current/redist/python2.7/bin/python -mjson.tool | \
   awk '/build/{print $2}' | \
   sed -e 's@"@@g;s@,@@g' | \
   sort -rn | \
   head -1
curl -s \
-d 'data={"userName":"administrator","email":"root@localhost","password":"admin/123","confirmPassword":"admin/123"}' http://localhost:8080/smrtportal/api/users/register | \
   current/redist/python2.7/bin/python -mjson.tool
curl -s -u administrator:admin/123 http://localhost:8080/smrtportal/api/settings/input-paths -d 'data=["common/test/primary/lambda_v210"]' | \
   current/redist/python2.7/bin/python -mjson.tool
curl -s -u administrator:admin/123 http://localhost:8080/smrtportal/api/inputs/scan         -d 'paths=["common/test/primary/lambda_v210"]' | \
   current/redist/python2.7/bin/python -mjson.tool
