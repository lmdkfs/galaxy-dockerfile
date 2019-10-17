#!/usr/bin/env bash
PIDS=`ps -ef | grep java | grep "arthas-boot.jar" |awk '{print $2}'`
echo -e "Stopping the arthas-boot ...\c"
for PID in $PIDS ; do
    kill $PID > /dev/null 2>&1
done

COUNT=0
while [ $COUNT -lt 1 ]; do
    echo -e ".\c"
    sleep 1
    COUNT=1
    for PID in $PIDS ; do
        PID_EXIST=`ps -f -p $PID | grep java`
        if [ -n "$PID_EXIST" ]; then
            COUNT=0
            break
        fi
    done
done

echo "OK!"

if [ ! -n "$1" ] ;then
    APP_PID=`netstat -nlp | grep '8080' | awk '{print $7}' | awk -F"/" '{print $1}'`
else
    APP_PID=`netstat -nlp | grep $1 | awk '{print $7}' | awk -F"/" '{ print $1 }'`
fi
#echo $APP_PID

if [ "$APP_PID" = '' ] ;then
    echo 'pid not found!'
    exit;
fi

if [ ! -n "$2" ] ;then
   #  echo '$2 is null'
   java -jar /root/.arthas/lib/3.1.1/arthas/arthas-boot.jar $APP_PID
else
   java -jar /root/.arthas/lib/3.1.1/arthas/arthas-boot.jar $APP_PID -c "$2" | grep -A 100 "$2"
fi
