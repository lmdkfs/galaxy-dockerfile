#!/usr/bin/env bash
set -x
echo -e "Starting the $SERVER_NAME ...\c"

#================
#export env=$ENV
JAVA_DEBUG_OPTS="-Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n "
JAVA_JMX_OPTS=" -Dcom.sun.management.jmxremote.port=1099 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false "
index=`head -200 /dev/urandom | cksum | cut -f1 -d" "`

configStr="@profiles.active@"
echo $configStr |grep -q "production"

if [ "x$agent_type" == "xgodeyes" ];then
        JAVA_AGENT_OPTS="-javaagent:/data/agent/godeyes/godeyes-agent-SNAPSHOT.jar"
else
        JAVA_AGENT_OPTS=""
fi
#project.artifactId
if [ "x$COMPRESS_TYPE" == "xzip" ];then
        mkdir -p /var/log/app/${productName}/$PROJECT_ARTIFACTID-${PORT0}
        CONF_DIR=/data/$serviceName/conf
        LIB_DIR=/data/$serviceName/lib
        LIB_JARS=`ls $LIB_DIR|grep .jar|awk '{print "'$LIB_DIR'/"$0}'|tr "\n" ":"`
        CLOUD_ENV="-Dserver.port=${PORT0} -Dlog.dir=/var/log/app/${productName}/$PROJECT_ARTIFACTID-${PORT0}"
        JAVA_OPTS=" -Djava.awt.headless=true -Djava.net.preferIPv4Stack=true -Djava.security.egd=file:/dev/./urandom -Dfile.encoding=utf-8 -Dsun.jnu.encoding=UTF8 -Duser.timezone=GMT+08 -Djava.util.Arrays.useLegacyMergeSort=true -Dindex=${index} -DLOG_FILE_NAME=$PROJECT_ARTIFACTID.log"
	eval exec "java $JAVA_AGENT_OPTS $CLOUD_ENV $javaOpt $JAVA_OPTS $JAVA_DEBUG_OPTS $JAVA_JMX_OPTS -classpath $CONF_DIR:$LIB_JARS $MAIN_CLASS"
fi

if [ "x$COMPRESS_TYPE" == "xjar" ];then
        mkdir -p /var/log/app/${productName}/${productName}-${PORT0}
	CLOUD_ENV="-Dserver.address=0.0.0.0 -Dserver.port=${PORT0} -Dlog.relatepath=${productName}/${projectName}-${PORT0} -Dlog.dir=/var/log/app/${productName}/${projectName}-${PORT0}"
	export DISPLAY=:1.0
	JAVA_OPTS="$JAVA_OPTS $CLOUD_ENV $javaOpt -Dfile.encoding=utf-8 -Dsun.jnu.encoding=UTF8 -Duser.timezone=GMT+08 -Djava.net.preferIPv4Stack=true -Djava.security.egd=file:/dev/./urandom -Djava.util.Arrays.useLegacyMergeSort=true"
	packageName=`find /data/${serviceName} -type f -name '*.jar' -maxdepth 1`
	
        eval exec "java $JAVA_AGENT_OPTS $CLOUD_ENV  $JAVA_OPTS -jar $packageName"
fi

if [ "x$COMPRESS_TYPE" == "xwar" ];then
        export JAVA_OPTS="$JAVA_AGENT_OPTS  $javaOpt -Dfile.encoding=utf-8 -Dsun.jnu.encoding=UTF8 -Duser.timezone=GMT+08 -Djava.net.preferIPv4Stack=true -Djava.security.egd=file:/dev/./urandom -Djava.util.Arrays.useLegacyMergeSort=true"
        eval exec "/data/tomcat/bin/catalina.sh run "
fi

echo "OK!"

PIDS=`ps -f | grep java | grep "$DEPLOY_DIR" | awk '{print $2}'`
echo "PID: $PIDS"
echo "STDOUT: $STDOUT_FILE"
