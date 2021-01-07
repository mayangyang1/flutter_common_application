import 'package:get/get.dart';
import 'package:flutter_common_application/pages/login/login_page_controller.dart';

class LoginPageBinding implements Bindings {
  
  @override
  void dependencies() {
    Get.lazyPut<LoginPageController>(() => LoginPageController());
  }
  
}
