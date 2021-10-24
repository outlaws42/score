# URL Errors

## Getting Android versions later then 9 to use clear text (For Garage Door App)

- Create a XML file in `my_flutter_project/android/app/src/main/res/xml/network_security_config.xml`

- and add the following

```dart
<?xml version="1.0" encoding="utf-8"?>
<network-security-config>
    <base-config cleartextTrafficPermitted="true">
        <trust-anchors>
            <certificates src="system" />
            <certificates src="user" />
        </trust-anchors>
    </base-config>
</network-security-config>
```

- Modify AndroidManifest.xml
- Go to. `flutter_project/android/app/src/main/AndroidManifest.xml`
- So for `<application>` PROPERTIES you have to add 1 line:
- `android:networkSecurityConfig="@xml/network_security_config"`
Note: Remember that you have to add it as property (inside application opening tag):

```xml
<application

    SOMEWHERE HERE IS OK

>
```

## Local host error

[ERROR:flutter/lib/ui/ui_dart_state.cc(177)] Unhandled Exception: SocketException: OS Error: Connection refused, errno = 111, address = 192.168.1.3, port = 38067

When testing out a app where you connecting to a url and you doing it on the localhost
use `http://10.0.2.2:port` intead of localhost or the IP of the computer
