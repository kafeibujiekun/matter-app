#!/bin/bash

list=`cat chip-lighting-app.main.cpp.o.d | grep ../third_party/connectedhomeip | awk '{print $1}' | sed 's/..\/third_party\/connectedhomeip/connectedhomeip/g'`

for path in ${list}
do
    filepath=$(dirname $path)
    mkdir -p "test/$filepath"
    realfilepath=`echo $path | sed 's/connectedhomeip/..\/third_party\/connectedhomeip/g'`
    cp $realfilepath test/$filepath
done
