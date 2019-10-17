FROM harbor.xxxxxxx.com/basic/centos-jdk:1.8.0_211
LABEL  description="不支持外嵌tomcat部署, 支持jar,zip" \
       arthas="arthas version 3.1.1"

ADD script/run_all.sh /data/run_all.sh
ADD jacoco/jacocoagent.jar /data/jacocoagent.jar
ADD arthas/ /root/.arthas/lib/3.1.1/arthas/
ADD script/arthas_start.sh /data/arthas_start.sh


WORKDIR /data


