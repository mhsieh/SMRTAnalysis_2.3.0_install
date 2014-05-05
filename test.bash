#!/bin/bash
# using the batch mode
if [ ! -d install/smrtanalysis-2.2.0.133377 ]; then
   bash distfiles/smrtanalysis-2.2.0.133377.run \
      --rootdir $PWD \
      --patchfile distfiles/smrtanalysis-2.2.0.133377-patch-1.run \
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
# tomcatd needs some time to unpack web archive files
sleep 9
pgrep -f tomcat || exit $?
pgrep -f mysql  || exit $?
curl -s http://localhost:8080/smrtportal/ > /dev/null
# print out the version
curl -s http://localhost:8080/smrtportal/api/about/ | \
   current/redist/python2.7/bin/python -mjson.tool | \
   awk '/build/{print $2}' | \
   sed -e 's@"@@g;s@,@@g' | \
   sort -rn | \
   head -1
# register the administrator with admin/123 password
curl -s -d \
  'data={"userName":"administrator","email":"root@localhost","password":"admin/123","confirmPassword":"admin/123"}' \
   http://localhost:8080/smrtportal/api/users/register | \
   current/redist/python2.7/bin/python -mjson.tool
# adding an input-path from the common/test directory
curl -s -u administrator:admin/123 http://localhost:8080/smrtportal/api/settings/input-paths -d 'data=["common/test/primary/lambda_v210"]' | \
   current/redist/python2.7/bin/python -mjson.tool
# scan the folder we just added
curl -s -u administrator:admin/123 http://localhost:8080/smrtportal/api/inputs/scan         -d 'paths=["common/test/primary/lambda_v210"]' | \
   current/redist/python2.7/bin/python -mjson.tool
# create a resequencing job using this newly added SMRT cell
curl -s -u administrator:admin/123 http://localhost:8080/smrtportal/api/jobs/create \
        -d 'data={"name":"DemoJobName", "createdBy":"administrator", "description":"demo job", "protocolName":"RS_Resequencing.1", "groupNames":["all"], "inputIds":["78807"]}'| \
        current/redist/python2.7/bin/python -mjson.tool
# start this newly created resequencing job
curl -s -u administrator:admin/123 http://localhost:8080/smrtportal/api/jobs/16437/start | \
   current/redist/python2.7/bin/python -mjson.tool
# wait until the job finish
while [ $((curl -s -u administrator:admin/123 http://localhost:8080/smrtportal/api/jobs/16437/status \
         | current/redist/python2.7/bin/python -mjson.tool \
         | grep -e '"code": "Submitted"' -e '"code": "In Progress"' -e '"code": "Started"'||true) | wc -l) -gt 0 ]; do
    echo -n .
    sleep 3
done && echo || exit $?
# report the job status for the last time
curl -s -u administrator:admin/123 http://localhost:8080/smrtportal/api/jobs/16437/status \
         | current/redist/python2.7/bin/python -mjson.tool
