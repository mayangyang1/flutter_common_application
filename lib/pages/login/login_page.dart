import 'package:flutter/material.dart';
import 'package:flutter_common_application/pages/login/components/body.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('登录'),),
      body: Body()
    );
  }
}
