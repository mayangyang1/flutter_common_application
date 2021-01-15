import 'package:background_locator/settings/android_settings.dart';
import 'package:background_locator/settings/ios_settings.dart';
import 'package:flutter/material.dart';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_common_application/pages/keeping/location_service_repository.dart';
import 'package:background_locator/background_locator.dart';
import 'package:flutter_common_application/widget/button_widget.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:flutter_common_application/pages/keeping/location_callback_handler.dart';
import 'package:background_locator/settings/locator_settings.dart';



class KeepingPage extends StatefulWidget {
  @override
  _KeepingPageState createState() => _KeepingPageState();
}

class _KeepingPageState extends State<KeepingPage> {
  ReceivePort port = ReceivePort();

  bool isRunning;

  @override
  void initState() { 
    super.initState();
    
    if (IsolateNameServer.lookupPortByName(
            LocationServiceRepository.isolateName) !=
        null) {
      IsolateNameServer.removePortNameMapping(
          LocationServiceRepository.isolateName);
    }
    IsolateNameServer.registerPortWithName(
        port.sendPort, LocationServiceRepository.isolateName);
    
    port.listen(
      (dynamic data) async {
        // await updateUI(data);
      },
    );
    initPlatformState();

  }
  Future<void> initPlatformState() async {
    print('Initializing...');
    await BackgroundLocator.initialize();
    // logStr = await FileManager.readLogFile();
    print('Initialization done');
    final _isRunning = await BackgroundLocator.isServiceRunning();
    setState(() {
      isRunning = _isRunning;
    });
    print('Running ${isRunning.toString()}');
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('后台定位服务'),),
      body: Column(
        children: <Widget>[
          ButtonWidget(
            title: '开始',
            onTap: _onStart,
          ),
          SizedBox(
            height: 30,
          ),
          ButtonWidget(
            title: '停止',
            onTap: _onStop,
          ),
        ],
      ),
    );
  }

  void _onStart() async {
    if(await _checkLocationPermission()) {
      _startLocator();
      final _isRunning = await BackgroundLocator.isServiceRunning();
      setState(() {
        isRunning = _isRunning;
      });
    }
  }
  void _onStop()async {
    BackgroundLocator.unRegisterLocationUpdate();
    final _isRunning = await BackgroundLocator.isServiceRunning();

    setState(() {
      isRunning = _isRunning;
    });
  }

  Future<bool> _checkLocationPermission() async {
    final access = await LocationPermissions().checkPermissionStatus();
    switch (access) {
      case PermissionStatus.unknown:
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
        final permission = await LocationPermissions().requestPermissions(
          permissionLevel: LocationPermissionLevel.locationAlways,
        );
        if (permission == PermissionStatus.granted) {
          return true;
        } else {
          return false;
        }
        break;
      case PermissionStatus.granted:
        return true;
        break;
      default:
        return false;
        break;
    }
  }
  void _startLocator() {
    Map<String ,dynamic> data = {'countInit': 1};

    BackgroundLocator.registerLocationUpdate(LocationCallbackHandler.callback,
        initCallback: LocationCallbackHandler.initCallback,
        initDataCallback: data,

        disposeCallback: LocationCallbackHandler.disposeCallback,
        iosSettings: IOSSettings(
          accuracy: LocationAccuracy.NAVIGATION, distanceFilter: 0,
        ),
        autoStop: false,
        androidSettings: AndroidSettings(
          accuracy: LocationAccuracy.NAVIGATION,
          interval: 5,
          distanceFilter: 0,
          client: LocationClient.android,
          androidNotificationSettings: AndroidNotificationSettings(
            notificationChannelName: 'Location tracking',
            notificationTitle: '持续保活',
            notificationMsg: '后台持续定位',
            notificationBigMsg: '该应用正在后台持续获取你的位置，以用于上报到网络货运平台',
            notificationIcon: '',
            notificationIconColor: Colors.grey,
            notificationTapCallback: LocationCallbackHandler.notificationCallback

          )
        )
    );

  }
}