#!/bin/bash
  URLv230="http://files.pacb.com/software/smrtanalysis/2.3.0/smrtanalysis_2.3.0.140936.run"
URLv230p3="http://files.pacb.com/software/smrtanalysis/2.3.0/smrtanalysis-patch_2.3.0.140936.p3.run"
  MD5v230="http://files.pacb.com/software/smrtanalysis/2.3.0/smrtanalysis_2.3.0.140936.run.md5"
MD5v230p3="http://files.pacb.com/software/smrtanalysis/2.3.0/smrtanalysis-patch_2.3.0.140936.p3.run.md5"

mkdir -p distfiles
cd distfiles
curl -O $MD5v230
curl -O $MD5v230p3
curl -O $URLv230
curl -O $URLv230p3
for mymd5 in *.md5; do
    md5sum -c $mymd5
done
