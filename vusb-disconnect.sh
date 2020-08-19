#!/bin/bash

SESSIONID=$1
shift

java -jar vusb-client.jar -vv disconnect --sessionId ${SESSIONID} $*
