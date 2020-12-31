import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_common_application/theme/app_theme.dart';
import 'package:flutter_common_application/pages/home_page.dart';
import 'package:flutter_common_application/routes/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(750, 1334),
      allowFontScaling: false,   
      child: GetMaterialApp(
          builder: BotToastInit(),
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          theme: appThemeData,
          defaultTransition: Transition.fade,
          getPages: AppPages.pages,
          home: HomePage()
          
        )
    );
  }
  
}
