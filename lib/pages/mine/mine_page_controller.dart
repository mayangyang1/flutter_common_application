import 'package:flutter_common_application/common/http_util.dart';
import 'package:get/get.dart';
import 'package:flutter_common_application/routes/app_pages.dart';

class MinePageController extends GetxController {
  String num = '1';

  void loginOut() async {
    Map result = await HttpUtil.get('loginOut');
    if (result != null && result['code'] == 200) {
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }
}
