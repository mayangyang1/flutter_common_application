import 'package:flutter/material.dart';
import 'package:flutter_common_application/common/http_util.dart';
import 'package:flutter_common_application/components/toast.dart';

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _getFreigthList();
    _getSelfInfo();
    return Scaffold(
      appBar: AppBar(
        title: Text('index page'),
      ),
      body: Container(
        child: Text('index page'),
      ),
    );
  }

  _getFreigthList() async {
    Toast.loading();
    Map result = await HttpUtil.get('apiFreightlist', success: (res) {
      if (res['code'] == 200) {
        Future.delayed(Duration(milliseconds: 1000), () {
          Toast.hideLoading();
        });
        Toast.toast('请求成功');
      }
    });
  }

  void _getSelfInfo() {
    HttpUtil.get('selfInfo', success: (res) {
      if (res['code'] == 200) {
        // Toast.toast('获取成功');
      }
    });
  }
}
