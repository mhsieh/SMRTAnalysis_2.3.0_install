
```
$ vagrant up
$ vagrant ssh head01
vagrant$ bash /vagrant/smrtanalysis_2.3.0.140936.run \
              -p smrtanalysis-patch_2.3.0.140936.p5.run \
              --rootdir /smrtanalysis
```
And follow the instructions, mostly pressing enters, use localhost
as the hostname. SGE should be automatically picked up.
```
$ vagrant ssh head01
Welcome to Ubuntu 14.04.1 LTS (GNU/Linux 3.13.0-39-generic x86_64)

 * Documentation:  https://help.ubuntu.com/

 System information disabled due to load higher than 1.0

  Get cloud support with Ubuntu Advantage Cloud Guest:
    http://www.ubuntu.com/business/services/cloud

0 packages can be updated.
0 updates are security updates.


vagrant@head01:~$ bash /vagrant/smrtanalysis_2.3.0.140936.run -p /vagrant/smrtanalysis-patch_2.3.0.140936.p5.run --rootdir /smrtanalysis
Starting smrtanalysis_2.3.0.140936 self-extraction...
Creating install directory (/smrtanalysis/install/smrtanalysis_2.3.0.140936)...
Extracting smrtanalysis_2.3.0.140936...
Starting smrtanalysis-patch_2.3.0.140936.p5.150482_linux_x86_64_libc-2.5_centos-53 self-extraction...
Creating install directory (/smrtanalysis/install/smrtanalysis-patch_2.3.0.140936.p5.150482_linux_x86_64_libc-2.5_centos-53)...
Extracting smrtanalysis-patch_2.3.0.140936.p5.150482_linux_x86_64_libc-2.5_centos-53...
Invoking smrtanalysis-patch_2.3.0.140936.p5.150482_linux_x86_64_libc-2.5_centos-53 installer...
Checking existing version number...
Copying prerun patchfiles...
Invoking smrtanalysis_2.3.0.140936 installer...
                          Welcome to the 
             Pacific Biosciences SMRTAnalysis Installer
                   (smrtanalysis_2.3.0.140936) 

System sanity check...
----- Part 1 of 7: SMRT Analysis User ----

We recommend running this script as a designated SMRT Analysis user
(e.g. smrtanalysis) who will own all smrtpipe jobs and daemon 
processes.  

Current user is 'vagrant' (primary group: vagrant)

Use the 'vagrant' as the SMRT Analysis user? [Y/n]: 

----- Part 2 of 7: System Prerequisite Check -----

Checking various hardware, OS and software related prerequisites...

    LOCALE CHECK: en_US.UTF-8
	--> OK: This is an English-language system.
    OS CHECK: Ubuntu 14.04.1 LTS
	--> WARNING: Unsupported Ubuntu version.
    Checking preqeuisite OS packages...
    CPU COUNT: 1
	--> WARNING: You have at 1 CPUs on this server (required: 8).
    MEM CHECK: Total Memory is 490 bytes.
	--> WARNING: You have 490MB per CPU (required: 1800)

The following warnings were detected in checking system prerequisites:

    	--> WARNING: Unsupported Ubuntu version.
    	--> WARNING: You have at 1 CPUs on this server (required: 8).
    	--> WARNING: You have 490MB per CPU (required: 1800)

Some of these warnings may not be critical, but may affect performance.
Continue the installation? [Y/n]: 

----- Part 3 of 7: SMRT Portal DNS -----

The DNS name of the SMRT Analysis host server is used for creating URLs
to access SMRT Portal (e.g. http://myhostname:8080/smrtportal).
The name must resolve in the Domain Name System (DNS) for proper
functionality.  If there is no valid DNS name, then an IP address 
should be used.

The following hostnames and IP addresses are recognized by DNS:

Detecting DNS names...
Pick an option:
   1) 10.0.2.15 (eth0)
   2) 192.168.50.101 (eth1)
   3) Specify an alternate DNS name
Choice [1]: 3
Specify the DNS name: localhost

----- Part 4 of 7: SMRT Portal Webserver  ----

SMRT Portal runs a Tomcat webserver which relies on access through
a main port and a shutdown port.  For proper operation, these 
ports cannot be used for listening by any other processes.  Select
port numbers which do not conflict with other programs.

Enter the 'main' port for the SMRT Analysis Tomcat Webserver [8080]: 
Enter the 'shutdown' port for the SMRT Analysis Tomcat Webserver [8005]: 

----- Part 5 of 7: Directory Setup -----

==== TMP Directory Setup ===

Configuring temporary (TMP) directory.  This directory is used 
for fast I/O operations, and should be a local directory (not NFS 
mounted) with at least enough space to store the data you wish to 
analyze.  Setting this to 12Gb is a good start.  This directory must
be available and writable by the smrtanalysis user 'vagrant'
on all nodes in the compute cluster.  It will be created if it 
does not exist.

SMRT Analysis will access the TMP directory from this path:

    /smrtanalysis/tmpdir

We recommend that it should be a symbolic link pointing to the 
real TMP directory.

    The default destination is: /tmp/smrtanalysis
    The current destination is: <unset>  (symlink does not exist)

Enter the symlink destination for the TMP directory [/tmp/smrtanalysis]: 
Write access to directory '/tmp/smrtanalysis' validated.

==== USERDATA Directory Setup ===

The USERDATA directory stores information as data is analyzed
and can expand rapidly.  Make sure there is sufficient available
storage in this directory (> 500GB).  This directory must be 
available and writable by the smrtanalysis user 'vagrant',
and must be shared on all nodes in the compute	cluster (e.g. 
via NFS mount).

SMRT Analysis will access the USERDATA directory from this path:

    /smrtanalysis/userdata

This can be a real directory or a symbolic link to a larger storage
location.

Currently this USERDATA location doesn't exist.

Create this directory and continue with installation? [Y/n]: 
Write access to directory '/smrtanalysis/userdata' validated.

----- Part 6 of 7: SMRT Portal Database ----

SMRT Portal uses an internal database in order to keep track of 
input SMRT cells, jobs, users, and groups.  No external database
is required.  The database only manages the web-interface and 
does not store actual sequence data.  


A dedicated TCP port is required to run the database server.
Select a port that does not conflict with any other active
port.  Choosing a port over 50000 is recommended.

Enter the mysql port [53306]: 
Ready to create internal database.  Continue? [Y/n]: 

----- Part 7 of 7: Job Management Cluster Setup -----

What job management system will you be using?

Pick an option:
   1) SGE
   2) LSF
   3) PBS
   4) NONE
Choice [1]: 

Detecting SGE setup (locations of binaries, SGE_ROOT, SGE_CELL)...

Detected the following settings:
      SGE_ROOT=/var/lib/gridengine	(from 'defaults in qconf script')
      SGE_CELL=default		(from 'defaults in qconf script')
      SGE_BINDIR=/usr/bin		(from 'PATH environment variable')

Are these correct? [Y/n]: 

Using the following settings:
      SGE_ROOT=/var/lib/gridengine
      SGE_CELL=default
      SGE_BINDIR=/usr/bin

Select the queue to use for SMRT Analysis jobs:
Pick an option:
   1) main.q
Choice [1]: 

Select the parallel environment to use for SMRT Analysis jobs:
Pick an option:
   1) smp
Choice [1]: 

An alternate SGE queue may be specified for CeleraAssembler jobs.
The default is to use the same queue.

Use an alternate queue for CeleraAsssember jobs? [y/N]: 

Multiple processors may be used for parallel operations.
The default is one less than the total number of cpus.

Specify number of processors to use for parallel operations (max: 1). [1]: 

Checking setting for the SGE SMRTAnalysis queue (main.q, smp)...
  Checking that the queue is valid...
  Checking that the pe is valid...
  Checking that the pe is in the queue pe_list...
  Checking the pe allocation_rule...
  Checking the queue hostlist...
  Checking that all queue hosts are execution hosts...
  Checking that all queue hosts are submit hosts...

Applying these settings:
   # ----- Part 1 of 7: SMRT Analysis User -----
   smrt_user=vagrant
   smrt_group=vagrant
   # ----- Part 2 of 7: System Prerequisite Check -----
   # ----- Part 3 of 7: SMRT Portal DNS ------
   smrtportal_dnsname=localhost
   # ----- Part 4 of 7: SMRT Portal Webserver  -----
   smrtportal_mainport=8080
   smrtportal_shutdownport=8005
   # ----- Part 5 of 6: Directory setup -----
   g_dirs_tmpdir_link=/smrtanalysis/tmpdir
   g_dirs_tmpdir_dest=/tmp/smrtanalysis
   dirs_shared_dir=/smrtanalysis/install/smrtanalysis_2.3.0.140936/common/userdata/shared_dir
   dirs_userdata_dir=/smrtanalysis/userdata
   # ----- Part 6 of 7: SMRT Portal Database -----
   smrtportal_dbuser_admin=root
   smrtportal_dbpasswd_admin=
   smrtportal_dbuser_smrtportal=smrtportal
   smrtportal_dbpasswd_smrtportal=smrtportal
   smrtportal_dbname=smrtportal
   smrtportal_dbhost=127.0.0.1
   smrtportal_dbport=53306
   smrtportal_namedpipeonly=
   # ----- Part 7 of 7: Job Management Cluster Setup -----
   jms_type=SGE
   jms_jobsaredistributed=true
   jms_ca_distribute_pb2ca=useGrid:0, scriptOnGrid:0, frgCorrOnGrid:0, ovlCorrOnGrid:0
   jms_ca_distribute_hgap=useGrid:0, scriptOnGrid:0, frgCorrOnGrid:0, ovlCorrOnGrid:0
   jms_numprocs=1
   sge_root=
   sge_cell=
   jms_bindir=/usr/bin
   jms_queue=main.q
   sge_pe=smp
   sge_ca_queue=
   sge_ca_pe=
   sge_use_settings_file=false
Setting up internal database server...
Installing MySQL system tables...
OK
Filling help tables...
OK

To start mysqld at boot time you have to copy
support-files/mysql.server to the right place for your system

PLEASE REMEMBER TO SET A PASSWORD FOR THE MySQL root USER !
To do so, start the server, then issue the following commands:

/smrtanalysis/install/smrtanalysis_2.3.0.140936/redist/mysql/bin/mysqladmin -u root password 'new-password'
/smrtanalysis/install/smrtanalysis_2.3.0.140936/redist/mysql/bin/mysqladmin -u root -h head01 password 'new-password'

Alternatively you can run:
/smrtanalysis/install/smrtanalysis_2.3.0.140936/redist/mysql/bin/mysql_secure_installation

which will also give you the option of removing the test
databases and anonymous user created by default.  This is
strongly recommended for production servers.

See the manual for more instructions.

You can start the MySQL daemon with:
cd /smrtanalysis/install/smrtanalysis_2.3.0.140936/redist/mysql ; /smrtanalysis/install/smrtanalysis_2.3.0.140936/redist/mysql/bin/mysqld_safe &

You can test the MySQL daemon with mysql-test-run.pl
cd /smrtanalysis/install/smrtanalysis_2.3.0.140936/redist/mysql/mysql-test ; perl mysql-test-run.pl

Please report any problems with the /smrtanalysis/install/smrtanalysis_2.3.0.140936/redist/mysql/scripts/mysqlbug script!

Starting database server...
  Successfully started database server (pid: 6124)...
mysqld is alive
Securing the database...
Creating the jms.setup.sh file...
Creating the user.settings file...
Creating the user.smrtpipe.rc file...
[INFO]Fri, 28 Aug 2015 13:36:56 - Initiating SMRTAnalysis configuration
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding smrtanalysis-user: smrtanalysis --> vagrant
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding smrtanalysis-group:  --> vagrant
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding configxml-hostname:  --> localhost
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding configxml-httpport: 8080 --> 8080
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding configxml-httpsport:  --> 
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding tomcat-serverxml-shutdownport: 8005 --> 8005
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding tomcat-stop: True --> True
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding smrtportal-webxml-ldapAuthentication:  --> 
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding smrtportal-webxml-ldapProvider:  --> 
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding smrtportal-webxml-securityPrincipalTemplate:  --> 
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding smrtportal-webxml-cmdAuthentication:  --> 
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding smrtportal-webxml-aws_s3_bucketname:  --> 
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding smrtportal-webxml-cycleCloudUsageUrl:  --> 
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding smrtportal-webxml-cycleCloudPaymentUrl:  --> 
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding smrtportal-webxml-seymourHome: /opt/smrtanalysis --> /opt/smrtanalysis
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding smrtportal-webxml-jobsAreReentrant: true --> true
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding smrtportal-webxml-jobsAreDistributed: false --> true
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding smrtportal-webxml-jobRunCommand: /bin/bash --> /bin/bash
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding smrtportal-webxml-entityManager: smrtportal --> smrtportal
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding smrtportal-persistxml-dbport: 3306 --> 53306
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding smrtportal-persistxml-dbname: smrtportal --> smrtportal
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding smrtportal-persistxml-dbhost: localhost --> 127.0.0.1
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding smrtportal-persistxml-javax.persistence.jdbc.user: smrtportal --> smrtportal
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding smrtportal-persistxml-javax.persistence.jdbc.password: smrtportal --> smrtportal
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding daemon-props-autoAnalysis.instrOutputMax: 100 --> 100
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding daemon-props-autoAnalysis.rollingWindow: 1 --> 1
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding daemon-props-autoAnalysis.batchSize: 1 --> 1
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding daemon-props-autoAnalysis.instrHttpTimeout: 60 --> 60
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding daemon-props-autoAnalysis.intervalInSeconds: 300 --> 300
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding daemon-props-s3.upload.threadsPerProc: 2 --> 2
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding daemon-props-s3.upload.largeFileCutoff: 10MB --> 10MB
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding daemon-props-s3.postTransfer.delete.mode:  --> 
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding daemon-props-s3.bucket.name:  --> 
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding daemon-props-s3.access.key:  --> 
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding daemon-props-s3.secret.key:  --> 
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding daemon-props-s3.smrtportal.url:  --> 
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding daemon-props-s3.seymour.home:  --> 
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding daemon-props-s3.report.dir:  --> 
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding db-user: root --> root
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding db-pass:  --> 
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding db-host: localhost --> 127.0.0.1
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding db-port: 3306 --> 53306
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding db-name: smrtportal --> smrtportal
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding smrtpiperc-location:  --> /smrtanalysis/install/smrtanalysis_2.3.0.140936/analysis/etc/user.smrtpipe.rc
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding cluster-queue: secondary --> main.q
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding cluster-sge-pe: smp --> smp
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding caspec-queue:  --> 
[INFO]Fri, 28 Aug 2015 13:36:56 - Overriding caspec-pe:  --> 
[INFO]Fri, 28 Aug 2015 13:37:08 - [INFO]Fri, 28 Aug 2015 13:36:56 - Temporarily changing file permissions under /smrtanalysis/install/smrtanalysis_2.3.0.140936 to 750
[INFO]Fri, 28 Aug 2015 13:37:08 - [localhost] local: chmod -R 755 /smrtanalysis/install/smrtanalysis_2.3.0.140936
[INFO]Fri, 28 Aug 2015 13:37:08 - [INFO]Fri, 28 Aug 2015 13:37:08 - 
[INFO]Fri, 28 Aug 2015 13:37:08 - [INFO]Fri, 28 Aug 2015 13:37:08 - Using pbsystem config_xml to create config.xml. params: {'httpport': '8080', 'hostname': 'localhost', 'httpsport': ''}
[INFO]Fri, 28 Aug 2015 13:37:08 - mysql -uroot  --host=127.0.0.1 --port=53306 -e "show databases"
[INFO]Fri, 28 Aug 2015 13:37:09 - smrtportal database successfully created.
[INFO]Fri, 28 Aug 2015 13:37:16 - [INFO]Fri, 28 Aug 2015 13:37:16 - No queue name provided. Templates in /smrtanalysis/install/smrtanalysis_2.3.0.140936/analysis/etc/celeraAssembler/ have not been edited. CeleraAssembler jobs will run the same queue as SMRTPipe jobs, possibly resulting in deadlock.
[INFO]Fri, 28 Aug 2015 13:37:41 - [INFO]Fri, 28 Aug 2015 13:37:16 - updateKodosd with home, user args: /smrtanalysis/install/smrtanalysis_2.3.0.140936,vagrant
[INFO]Fri, 28 Aug 2015 13:37:41 - [localhost] local: bash -c "cd /smrtanalysis/install/smrtanalysis_2.3.0.140936/etc/scripts/; bash ./update_config_for_new_home.sh"
[INFO]Fri, 28 Aug 2015 13:37:41 - [INFO]Fri, 28 Aug 2015 13:37:17 - Config files have been updated. Now restricting permissions...
[INFO]Fri, 28 Aug 2015 13:37:41 - Finished SMRTAnalysis configuration
Determining current database access settings...
Successfullly updated 2.3.0 description field.
Creating smrtportal database backup: /smrtanalysis/install/smrtanalysis_2.3.0.140936/common/userdata/database/current/backup/2.3.0.140936/smrtportal-2.3.0.140936.backup.20150828_133742.sql.gz
Shutting down internal database server...
Stopping smrtanalysis mysql server (w/ mysqladmin shutdown)...
Successfully stopped smrtanalysis mysql server
Resetting executable permissions...
Invoking the post-install patches...
Running update from self-extracting tarball...
Skipping smrtanalysis-patch_2.3.0.140936.p5.150482_linux_x86_64_libc-2.5_centos-53 self-extraction...
Invoking smrtanalysis-patch_2.3.0.140936.p5.150482_linux_x86_64_libc-2.5_centos-53 upgrader...
Applying patch versionstr: smrtanalysis-patch_2.3.0.140936.p5.150482_linux_x86_64_libc-2.5_centos-53
Applying patch to: /smrtanalysis/install/smrtanalysis_2.3.0.140936
Checking existing version number...
Checking current patch level...
Checking symlinks...
  Copying prerun files...
Applying patches...
Updating reference permissions...
Backing up references...
  Creating backup of current references...
  Creating latest backup reference link...
Updating canned references...
  Refreshing reference repository index...
Updating patchlevel file...
Updating patchchnum file...
Updating patchhistory file...
Patch successful.
vagrant@head01:~$
```

After installation, use 
```
/smrtanalysis/admin/smrtportal-initd start
```
to start the SMRT portal.

- Point your host safari/firefox to log on http://localhost:8080
- register administrator is required for a new portal
- then start to use your toy cluster.
