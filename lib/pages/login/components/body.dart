import 'package:flutter/material.dart';
import 'package:flutter_common_application/pages/login/login_page_controller.dart';
import 'package:flutter_common_application/widget/button_widget.dart';
import 'package:flutter_common_application/widget/input_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Body extends GetView<LoginPageController> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: 100),
        child: Column(
          children: <Widget>[
            _logoWidget(),
            _inputWidget(),
            _buttonWidget()
          ],
        ),
      )
    );
  }
  Widget _logoWidget() {
    return Container(
      margin: EdgeInsets.only(top: 60.0, bottom: 40.0),
      child: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: 340.w,
        
        ),
      ),
    );
  }
  Widget _inputWidget() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          InputWidget(
            controller: controller.userNameController,
            hintText: '请输入用户名',
            imgUrl: 'assets/images/users.png',
            obscureText: false,
            inputType: 'number',
          ),
          SizedBox(height: 20,),
          InputWidget(
            controller: controller.passwordController,
            hintText: '请输入密码',
            imgUrl: 'assets/images/password.png',
            obscureText: true,
            inputType: 'text',
          )
        ],
      ),
    );
  }
  Widget _buttonWidget() {
    return ButtonWidget(title: '登录', onTap: controller.submit);
  }
}