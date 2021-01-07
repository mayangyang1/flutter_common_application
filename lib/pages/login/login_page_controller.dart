import 'package:flutter/cupertino.dart';
import 'package:flutter_common_application/common/http_util.dart';
import 'package:flutter_common_application/components/toast.dart';
import 'package:flutter_common_application/pages/home_page.dart';
import 'package:simple_rsa/simple_rsa.dart';
import 'package:get/get.dart';

class LoginPageController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String _publicKey = '';
  String _encryptPassword = '';
  @override
  void onReady() {
    super.onReady();
    _getPublicKey();
  }

  void submit() async {
    if (userNameController.text == '') {
      return Toast.toast('请输入用户名');
    }
    if (passwordController.text == '') {
      return Toast.toast('请输入密码');
    }
    if(_publicKey != '') {
      final _encryptMessage = await encryptString(passwordController.text.trim(), _publicKey);
      _encryptPassword = _encryptMessage.replaceAll("\n", "");
    }
    Map<String, dynamic> data = {};
    data['account'] = userNameController.text.trim();
    data['password'] = _encryptPassword;
    data['version'] = 1;
    Map result = await HttpUtil.post('accountLogin', data: data);
    if(result != null && result['code'] == 200){
      Get.off(HomePage());
    }
  }

  void _getPublicKey() async {
    Map result = await HttpUtil.get('getPublicKey');
    if (result != null && result['code'] == 200) {
      _publicKey = result['content']['publicKey'] ?? '';
    }
  }
}
