import 'package:flutter/material.dart';
import 'package:flutter_common_application/common/http_util.dart';
import 'package:flutter_common_application/components/toast.dart';
import 'package:flutter_common_application/widget/button_widget.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  FlutterTts flutterTts;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  @override
  void initState() {
    super.initState();
    _getSelfInfo();
    _getFreigthList();
    _initFlutterTtts();
    _flutterLocalNotificationsConfig();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('index page'),
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          ButtonWidget(
            title: '发音',
            onTap: _speak,
          ),
          SizedBox(
            height: 30,
          ),
          ButtonWidget(
            title: '暂停',
            onTap: _stop,
          ),
          SizedBox(
            height: 30,
          ),
          ButtonWidget(
            title: '提示',
            onTap: _showNotification,
          ),
        ],
      )),
    );
  }

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'your channel id', 'your channel name', 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'item x');

    _speak();
  }

  void _flutterLocalNotificationsConfig() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /**本地通知 */
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _selectNotification);
  }

  Future _selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    Get.snackbar('提示', '提示内容');
  }

  _initFlutterTtts() {
    flutterTts = FlutterTts();
  }

  Future _speak() async {
    await flutterTts.setVolume(.9);
    await flutterTts.setSpeechRate(.9);
    await flutterTts.setPitch(1);

    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.speak('抢单成功');
  }

  Future _getEngines() async {
    var engines = await flutterTts.getEngines;
    if (engines != null) {
      for (dynamic engine in engines) {
        print(engine);
      }
    }
  }

  Future _stop() async {
    await flutterTts.stop();
  }

  _getFreigthList() async {
    // Toast.loading();
    Map result = await HttpUtil.get(
      'apiFreightlist',
    );
    if (result != null && result['code'] == 200) {}
  }

  void _getSelfInfo() {
    HttpUtil.get('selfInfo', success: (res) {
      if (res['code'] == 200) {
        // Toast.toast('获取成功');
      }
    });
  }
}
