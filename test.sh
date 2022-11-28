#!/bin/bash	
BASE_PATH=$(pwd)
rpms="$BASE_PATH/rpms"
for i in `ls $rpms/飞腾依赖包`
do
    if [ ${i##*.} = 'rpm' ]
    then
        echo $i
    fi
done