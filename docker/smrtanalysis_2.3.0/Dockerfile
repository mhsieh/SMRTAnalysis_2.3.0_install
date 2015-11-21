# This is a comment
FROM ubuntu:14.04
MAINTAINER Mengjuei Hsieh, mjhsieh@gmail.com

ENV PACKAGES wget rsync

RUN apt-get update -y
RUN apt-get install -y --no-install-recommends ${PACKAGES}

ENV SOFTWARE_HOME /opt/smrtanalysis
ENV RELEASE_URL http://files.pacb.com/software/smrtanalysis/2.3.0/smrtanalysis_2.3.0.140936.run
ENV PATCH_URL http://files.pacb.com/software/smrtanalysis/2.3.0/smrtanalysis-patch_2.3.0.140936.p5.run

RUN adduser --disabled-password smrtanalysis
RUN mkdir -p ${SOFTWARE_HOME}
RUN cd ${SOFTWARE_HOME} &&\
    wget -nv ${RELEASE_URL} &&\
    wget -nv ${PATCH_URL}
RUN chown -R smrtanalysis ${SOFTWARE_HOME}
RUN su smrtanalysis -c "bash ${SOFTWARE_HOME}/smrtanalysis_2.3.0.140936.run\
    --rootdir ${SOFTWARE_HOME} \
    --patchfile ${SOFTWARE_HOME}/smrtanalysis-patch_2.3.0.140936.p5.run \
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
    --batch"
