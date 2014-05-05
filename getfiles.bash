#!/bin/bash
URL1204v211="http://files.pacb.com/software/smrtanalysis/2.1.1/smrtanalysis-2.1.1-ubuntu-12.04.run"
URLv220="https://s3.amazonaws.com/files.pacb.com/software/smrtanalysis/2.2.0/smrtanalysis-2.2.0.133377.run"
URLv220p0="https://s3.amazonaws.com/files.pacb.com/software/smrtanalysis/2.2.0/smrtanalysis-2.2.0.133377-patch-0.0.run"
URLv220p1="https://s3.amazonaws.com/files.pacb.com/software/smrtanalysis/2.2.0/smrtanalysis-2.2.0.133377-patch-1.run"

cd distfiles
curl -O $URLv220
#curl -O $URLv220p0
curl -O $URLv220p1
md5sum -c hash.md5
