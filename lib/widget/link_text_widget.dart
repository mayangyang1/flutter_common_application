import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LinkTextWidget extends StatelessWidget {
  final String text;
  final Function onTap;
  final int fontSize;
  final int fontColor;

  LinkTextWidget({
    @required this.text,
    @required this.onTap,
    this.fontSize = 32,
    this.fontColor = 0xFFcccccc,
  });
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(text, style: TextStyle(fontSize: ScreenUtil().setSp(fontSize),color: Color(fontColor)),),
      onTap: onTap
    );
  }
}