import 'package:flutter_common_application/providers/app_sp_service.dart';
import 'package:get/get.dart';

//依赖注入
class DenpendencyInjection {
  static Future<void> init() async {
    //shared_preferences
    await Get.putAsync(() => AppSpController().init());
  }
}
