import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_common_application/components/toast.dart';
import 'package:flutter_common_application/pages/index/index_page.dart';
import 'package:flutter_common_application/pages/mine/mine_page.dart';
import 'package:flutter_common_application/pages/task/task_page.dart';
import 'package:move_to_background/move_to_background.dart';


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
        
        body:IndexedStack(
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