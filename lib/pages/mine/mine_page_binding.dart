import 'package:flutter_common_application/pages/mine/mine_page_controller.dart';
import 'package:get/get.dart';


class MinePageBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<MinePageController>(() => MinePageController());
  }
}