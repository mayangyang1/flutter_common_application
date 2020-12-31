
import 'package:get/get.dart';
import 'package:flutter_common_application/pages/home_page.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
    ),
  ];
}
