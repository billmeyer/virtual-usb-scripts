#!/bin/bash

java -jar vusb-client.jar -vv sessions --apiKey ${TESTOBJECT_USER_API_KEY} $*
