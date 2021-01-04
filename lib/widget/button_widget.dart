import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final Function onTap;
  final int height;
  final int width;
  final double marginTop;
  final double marginBottom;
  final double marginLeft;
  final double marginRight;
  final int color;
  final int textColor;
  final int fontSize;
  ButtonWidget({
    @required this.title,
    @required this.onTap,
    this.height = 100,
    this.width,
    this.marginTop = 0,
    this.marginBottom = 0,
    this.marginLeft = 10,
    this.marginRight = 10,
    this.color,
    this.textColor = 0xFF454545,
    this.fontSize = 34,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: ScreenUtil().setHeight(height),
        width: width != null ? ScreenUtil().setWidth(width) : double.infinity,
        margin: EdgeInsets.only(top: marginTop, bottom: marginBottom,left: marginLeft, right: marginRight),
        decoration: BoxDecoration(
          color: color == null ?Theme.of(context).primaryColor : Color(color),
          borderRadius: BorderRadius.circular(5),
          border: color != null ? Border.all(width: 1, color: Color(0xFFCCCCCC)) : null,
          boxShadow: [
            BoxShadow(
              color: Color(0xFFbcbcbc),
              offset: Offset(2.0,2.0),
              blurRadius: 3
            )
          ]
        ),
        child: Center(
          child: Text(title, style:TextStyle(fontSize: ScreenUtil().setSp(fontSize),color: color == null ? Colors.white : Color(textColor))),
        ),
      ),
      onTap: onTap
    );
  }
}
