import 'package:flutter/material.dart';
import 'package:flutter_common_application/common/http_util.dart';
import 'package:flutter_common_application/components/simple_modal.dart';
import 'package:flutter_common_application/widget/button_widget.dart';
import 'package:flutter_tts/flutter_tts.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:flutter_common_application/routes/app_pages.dart';
// import 'package:barcode_scan/barcode_scan.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:permission_handler/permission_handler.dart';



class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  FlutterTts flutterTts;

  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  @override
  void initState() {
    super.initState();
    _getSelfInfo();
    _getFreigthList();
    _initFlutterTtts();
    _getMapLauncherList();
    // _flutterLocalNotificationsConfig();

   
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('index page'),
      ),
      body: SingleChildScrollView(
        child: Container(
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
              onTap: (){},
            ),
            SizedBox(
              height: 30,
            ),
            ButtonWidget(
              title: '后台持续定位',
              onTap: () {
                Get.toNamed(Routes.KEEPING);
              },
            ),
            SizedBox(
              height: 30,
            ),
            ButtonWidget(
              title: '扫码',
              onTap: ()async {
                // var result = await BarcodeScanner.scan();
                // print(result);
              },
            ),
            SizedBox(
              height: 30,
            ),
            ButtonWidget(
              title: '打开微信',
              onTap: ()async {
                var url = 'weixin://';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            SizedBox(
              height: 30,
            ),
            ButtonWidget(
              title: '打开地图',
              onTap: ()async {
                _launchMap();
              },
            ),
            SizedBox(
              height: 30,
            ),
            ButtonWidget(
              title: '保活',
              onTap: () {
                _getNotificatioInfo();
                
              },
            ),
            SizedBox(
              height: 30,
            ),
            ButtonWidget(
              title: '结束保活',
              onTap: (){
                endAlive();
              },
            ),
            
          ],
        )),
      )
    );
  }
  Future _getNotificatioInfo() async{
    Map<Permission, PermissionStatus> statuses = await [
      Permission.notification
    ].request();
    if(statuses[Permission.notification] != PermissionStatus.granted) {
      ShowSimpleModal.showModal(context, '提示', '是否打开通知管理 设置允许通知 用于保活应用?', (){
        Navigator.of(context).pop();
        openAppSettings();
        
      },sureTitle: '打开',cancelTitle: '否',cancelTap: (){
        Navigator.of(context).pop();    
        }
      );
      
      
    }else{
      _keepAlive();
    }
  }

  // Future<void> _showNotification() async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(
  //           'your channel id', 'your channel name', 'your channel description',
  //           importance: Importance.max,
  //           priority: Priority.high,
  //           ticker: 'ticker');
  //   const NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.show(
  //       0, 'plain title', 'plain body', platformChannelSpecifics,
  //       payload: 'item x');

  //   _speak();
  // }

  // void _flutterLocalNotificationsConfig() {
  //   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  //   /**本地通知 */
  //   const AndroidInitializationSettings initializationSettingsAndroid =
  //       AndroidInitializationSettings('@mipmap/ic_launcher');

  //   final InitializationSettings initializationSettings =
  //       InitializationSettings(android: initializationSettingsAndroid);
  //   flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //       onSelectNotification: _selectNotification);
  // }
  void _keepAlive() async{
    final androidConfig = FlutterBackgroundAndroidConfig(
    notificationTitle: "保活",
    notificationText: "前台服务保活app",
    notificationImportance: AndroidNotificationImportance.Default,
    // notificationIcon: AndroidResource(name: 'ic_launcher', defType: 'mipmap'), // Default is ic_launcher from folder mipmap
    );
    bool success = await FlutterBackground.initialize(androidConfig: androidConfig);
    print(success);

    bool hasPermissions = await FlutterBackground.hasPermissions;
    print(hasPermissions);

    bool aliveSuccess = await FlutterBackground.enableBackgroundExecution();
    print(aliveSuccess);

    

  }
  endAlive() async{
    await FlutterBackground.disableBackgroundExecution();

    bool enabled = FlutterBackground.isBackgroundExecutionEnabled;
    print(enabled);
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
// nn, bg, kea, mg, mr, nds, zu, ko, hsb, ak, kde, lv, seh, dz, mgo, ia, kkj, pa-Guru, mer, sah, br, sk, ml, ast, yue-Hans, cs, sv, el, pa, rn, rwk, tg, hu, af, twq, bm, smn, dsb, khq, ku, tr, cgg, ksf, my-Qaag, cy, yi, fr, sq, de, agq, ebu, zh-Hans, lg, ff, mn, sd, teo, eu, wo, shi-Tfng, xog, so, ru, az, fa, kab, ms, nus, nd, ug, kk, az-Cyrl, hi, tk, hy, shi-Latn, vai, vi, dyo, mi, mt, ksb, lb, luo, yav, ne, eo, kam, ro, ee, pl, my, ka, ur, mgh, shi, uz-Arab, kl, se, chr, en-Qaag, zh, yue-Hant, saq, az-Latn, ta, lag, luy, bo, as, bez, it, kln, uk, kw, mai, vai-Latn, mzn, ii, tt, ksh, ln, naq, pt, tzm, gl, sr-Cyrl, fur, om, to, ga, qu, et, asa, mua, jv, id, ps, sn, rof, km, zgh, be, fil, gv, uz-Cyrl, dua, es, jgo, fo, gsw, hr, lt, guz, mfe, ccp, ja, lkt, is, or, si, brx, en, ca, te, ks, ha, sl, sbp, nyn, jmc, yue, fi, mk, bs-Cyrl, uz, pa-Arab, sr-Latn, bs, sw, fy, nmg, rm, th, bn, ar, vai-Vaii, haw, kn, dje, bas, nnh, sg, uz-Latn, gu, lo, nl, zh-Hant, mai-Deva, ckb, bs-Latn, ky, sr, mas, os, bem, da, wae, ig
  Future _speak() async {
    await flutterTts.setLanguage('zh-CN');
    await flutterTts.setVolume(.9);
    await flutterTts.setSpeechRate(.5);
    await flutterTts.setPitch(1);
    await flutterTts.setVoice({'name': 'zh', 'locale': 'zh'});
    List enginesList = await flutterTts.getEngines;
    List voicesList = await flutterTts.getVoices;
    List getLanguage = await flutterTts.getLanguages;
    // [
    //   {name: ru, locale: ru},
    //   {name: en, locale: en-Qaag}, 
    //   {name: jgo, locale: jgo}, 
    //   {name: kea, locale: kea}, 
    //   {name: bs, locale: bs}, 
    //   {name: my, locale: my-Qaag}, 
    //   {name: lv, locale: lv}, 
    //   {name: ff, locale: ff}, 
    //   {name: am, locale: am}, 
    //   {name: fy, locale: fy}, 
    //   {name: cgg, locale: cgg}, 
    //   {name: mfe, locale: mfe}, 
    //   {name: mi, locale: mi}, 
    //   {name: vi, locale: vi}, 
    //   {name: bs, locale: bs-Latn}, 
    //   {name: kam, locale: kam}, 
    //   {name: es, locale: es}, 
    //   {name: hr, locale: hr}, 
    //   {name: nmg, locale: nmg}, 
    //   {name: gl, locale: gl}, 
    //   {name: et, locale: et}, 
    //   {name: mai, locale: mai}, 
    //   {name: lb, locale: lb}, 
    //   {name: dje, locale: dje}, 
    //   {name: ks, locale: ks}, 
    //   {name: smn, locale: smn}, 
    //   {name: zgh, locale: zgh}, 
    //   {name: sk, locale: sk}, 
    //   {name: lt, locale: lt}, 
    //   {name: seh, locale: seh}, 
    //   {name: ig, locale: ig}, 
    //   {name: ml, locale: ml}, 
    //   {name: fil, locale: fil}, 
    //   {name: mer, locale: mer}, 
    //   {name: sg, locale: sg}, 
    //   {name: yue, locale: yue-Hans}, 
    //   {name: guz, locale: guz}, 
    //   {name: zh, locale: zh-Hant}, 
    //   {name: nn, locale: nn}, 
    //   {name: ksh, locale: ksh}
    // ]
    print(enginesList);
    print(voicesList);
    print(getLanguage);

    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.speak('抢单成功');
  }

  // Future _getEngines() async {
  //   var engines = await flutterTts.getEngines;
  //   if (engines != null) {
  //     for (dynamic engine in engines) {
  //       print(engine);
  //     }
  //   }
  // }

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
  void _getMapLauncherList() async {
    final availableMaps = await MapLauncher.installedMaps;
    print(availableMaps);
  }
  void _launchMap() async {
    await MapLauncher.showMarker(mapType: MapType.baidu, coords:Coords(34.759392, 120.5107336), title: '标题');
  }
}
