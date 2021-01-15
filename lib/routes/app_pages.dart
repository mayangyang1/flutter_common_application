
import 'package:flutter_common_application/pages/keeping/keeping_page.dart';
import 'package:flutter_common_application/pages/login/login_page.dart';
import 'package:flutter_common_application/pages/mine/mine_page.dart';
import 'package:flutter_common_application/pages/mine/mine_page_binding.dart';
import 'package:get/get.dart';
import 'package:flutter_common_application/pages/home_page.dart';
import 'package:flutter_common_application/pages/login/login_page_binding.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginPageBinding()
    ),
    GetPage(
      name: Routes.MINE,
      page: () => MinePage(),
      binding: MinePageBinding()
    ),
    GetPage(
      name: Routes.KEEPING,
      page: () => KeepingPage(),
    ),
  ];
}
