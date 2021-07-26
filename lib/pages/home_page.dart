import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_common_application/components/toast.dart';
import 'package:flutter_common_application/pages/index/index_page.dart';
import 'package:flutter_common_application/pages/mine/mine_page.dart';
import 'package:flutter_common_application/pages/task/task_page.dart';
import 'package:move_to_background/move_to_background.dart';

import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:mobpush_plugin/mobpush_plugin.dart';
import 'package:mobpush_plugin/mobpush_custom_message.dart';
import 'package:mobpush_plugin/mobpush_notify_message.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _lastPopTime;

  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(Icons.menu),
      title: Text('index')
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text('task')
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.local_shipping),
      title: Text('mine')
    ),
  ];

  final List<Widget> tabBodies = [
    IndexPage(),
    TaskPage(),
    MinePage(),
  ];
  int _currentIndex = 0;

  String _sdkVersion = 'Unknown';
  String _registrationId = 'Unknown';

  @override
  void initState() { 
    super.initState();

     MobpushPlugin.addPushReceiver(_onEvent, _onError);
    // 上传隐私协议许可
    MobpushPlugin.updatePrivacyPermissionStatus(true);
  }
  Future<void> initPlatformState() async {
    String sdkVersion;
    
    try {
      sdkVersion = await MobpushPlugin.getSDKVersion();
    } on PlatformException {
      sdkVersion = 'Failed to get platform version.';
    }
    try {
      MobpushPlugin.getRegistrationId().then((Map<String, dynamic> ridMap) {
        print(ridMap);
        setState(() {
          _registrationId = ridMap['res'].toString();
          print('------>#### registrationId: ' + _registrationId);
        });
      });
    } on PlatformException {
      _registrationId = 'Failed to get registrationId.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _sdkVersion = sdkVersion;
    });
  }

  void _onEvent(Object event) {
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>onEvent:' + event.toString());
    setState(() {
      Map<String, dynamic> eventMap = json.decode(event);
      Map<String, dynamic> result = eventMap['result'];
      int action = eventMap['action'];

      switch (action) {
        case 0:
          MobPushCustomMessage message =
          new MobPushCustomMessage.fromJson(result);
          showDialog(
              context: context,
              child: AlertDialog(
                content: Text(message.content),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("确定"),
                  )
                ],
              ));
          break;
        case 1:
          MobPushNotifyMessage message =
          new MobPushNotifyMessage.fromJson(result);
          _navigationSwitch(message);
          break;
        case 2:
          MobPushNotifyMessage message =
          new MobPushNotifyMessage.fromJson(result);
           _navigationSwitch(message);
          break;
      }
    });
  }

  void _onError(Object event) {
    setState(() {
      print('>>>>>>>>>>>>>>>>>>>>>>>>>>>onError:' + event.toString());
    });
  }
  void _navigationSwitch(MobPushNotifyMessage message) {
    if(message.extrasMap['mobpush_link_k'] != null ) {
      String navigateType = message.extrasMap['mobpush_link_k'];
      String navigateValue = message.extrasMap['mobpush_link_v'];
      if(navigateType.contains('resourceDetail')) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return TaskPage();
        }));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          items: bottomTabs,
          onTap: (index) {
            setState(() {
            _currentIndex = index; 
            });
          },
        ),
        
        body: IndexedStack(
          index: _currentIndex,
          children: tabBodies,
        )
        
        
      ),
      onWillPop: _doubleExit
    );
    
    
  }

  Future<bool> _doubleExit() async {
    // 点击返回键的操作
    if (_lastPopTime == null ||
        DateTime.now().difference(_lastPopTime) > Duration(seconds: 2)) {
      _lastPopTime = DateTime.now();
      Toast.toast('再按一次退出应用');
      return new Future.value(false);
    } else {
      _lastPopTime = DateTime.now();
      // 退出app
      MoveToBackground.moveTaskToBack();
      return new Future.value(false);
    }
  }
}