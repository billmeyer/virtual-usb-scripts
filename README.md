# Virtual USB for Android - CLI Start

The offical documentation for Virtual USB can be found on the Sauce Labs Wiki at [https://wiki.saucelabs.com/display/DOCS/Testing+with+Virtual+USB+on+Real+Devices]().

## Setup

These scripts expect that environment variables are set for __TESTOBJECT_USER_API_KEY__.

The value for __TESTOBJECT_USER_API_KEY__ can be found by signing into [https://app.saucelabs.com]() and navigating to __SAUCE APPS__ &rarr; __Legacy RDC__ &rarr; click on the "head" located in the upper right corner &rarr; __Account Settings__.

The value in the __User API Key__ field is what you want to set as your __TESTOBJECT_USER_API_KEY__ environment variable.

## Start the Virtual USB server

From a terminal window, the actual command to start the server is:

    java -jar vusb-client.jar server --datacenter US

The `vusb-server.sh` script does the same thing:

    ./vusb-server.sh
    07:34:33.167 [main] INFO com.saucelabs.vusb.client.Runner - Runner Version 1.8.0
    07:34:33.389 [main] INFO com.saucelabs.vusb.client.server.VirtualUsbServer - Initializing vUSB-Server...
    07:34:33.392 [main] INFO com.saucelabs.vusb.client.server.VirtualUsbServer - vUSB-Server initialized
    07:34:33.393 [main] INFO com.saucelabs.vusb.client.server.rest.WebServer - Starting Virtual USB server on port 33657.
    07:34:33.638 [main] INFO com.saucelabs.vusb.client.server.rest.WebServer - Virtual USB server is up.

## Getting Connected

### Start the Session

1. From within your web browser, login to [https://app.saucelabs.com]() and navigate to __SAUCE APPS__ &rarr; __Legacy RDC__.

2. Find the app you want to start on a device in the list and click on it.
3. You should see the option to do __LIVE TESTING__, __AUTOMATED TESTING__, and __ISSUES__.  Click on __LIVE TESTING__.
4. If you need to use a Sauce Connect Tunnel, select it from the drop down list.
5. Find an available device from the list of devices.
6. Click __Open Device__.

## Find the running session

1. Start a new terminal window.
2. Be sure the __TESTOBJECT_USER_API_KEY__ environment variable is still set.  If not, set it.
3. To get a list of active sessions, the command format is:

        java -jar vusb-client.jar -vv sessions --apiKey ${TESTOBJECT_USER_API_KEY}

    The `vusb-sessions.sh` script does the same thing:

        ./vusb-sessions.sh
        07:45:49.592 [main] INFO com.saucelabs.vusb.client.Runner - Runner Version 1.8.0
        07:45:49.639 [main] TRACE com.saucelabs.vusb.client.Runner - Enable super-verbose logging.
        07:45:49.639 [main] DEBUG com.saucelabs.vusb.client.Runner - Runner launched with command:sessions
        List of active sessions
        c0f0a58f-a796-4542-acd0-271b3ba16228		Google Pixel 3 POC156		ANDROID		9

    Take a copy of the session ID (ie., `c0f0a58f-a796-4542-acd0-271b3ba16228`) as it is used in the next step.

### Connect Virtual USB to the Running Session

To connect Virtual USB to a running session, the command is in the format:

    java -jar vusb-client.jar -vv connect --apiKey ${TESTOBJECT_USER_API_KEY} --sessionId ${SESSIONID}

The `vusb-connect.sh` script does the same thing allowing you to pass the Session ID on the command line as an argument to the script:

    ./vusb-connect.sh c0f0a58f-a796-4542-acd0-271b3ba16228
    07:47:07.510 [main] INFO com.saucelabs.vusb.client.Runner - Runner Version 1.8.0
    07:47:07.557 [main] TRACE com.saucelabs.vusb.client.Runner - Enable super-verbose logging.
    07:47:07.557 [main] DEBUG com.saucelabs.vusb.client.Runner - Runner launched with command:connect
    localhost:7000	online

### Connect ADB

Connect __adb__ to the Virtual USB session so that it can be used by the desktop apps:

    adb connect localhost:7000
    * daemon not running; starting now at tcp:5037
    * daemon started successfully
    connected to localhost:7000

## Getting Disconnected

### Disconnect ADB

Disconnect __adb__ from the Virtual USB device before ending the session:

    adb disconnect localhost:7000

### Disconnect the session

The command to disconnect from an establish Virtual USB session has the format:

    java -jar vusb-client.jar -vv disconnect --sessionId ${SESSIONID}

The `vusb-disconnect.sh` script does the same thing allowing you to pass the Session ID on the command line as an argument to the script:

    ./vusb-disconnect.sh c0f0a58f-a796-4542-acd0-271b3ba16228
    07:51:28.792 [main] INFO com.saucelabs.vusb.client.Runner - Runner Version 1.8.0
    07:51:28.839 [main] TRACE com.saucelabs.vusb.client.Runner - Enable super-verbose logging.
    07:51:28.839 [main] DEBUG com.saucelabs.vusb.client.Runner - Runner launched with command:disconnect
    Disconnected
