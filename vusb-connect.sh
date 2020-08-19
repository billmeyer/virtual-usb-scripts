#!/bin/bash

SESSIONID=$1
shift

java -jar vusb-client.jar -vv connect --apiKey ${TESTOBJECT_USER_API_KEY} --sessionId ${SESSIONID} $*
