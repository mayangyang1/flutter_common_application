import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//String imgUrl, 
class ListItemWidget extends StatelessWidget {
  final int height;
  final String leftImg;
  final bool showLeftImg;
  final String leftTitle;
  final String rightTitle;
  final String rightImg;
  final bool showRightImg;
  final Function onTap;
  final int leftImgWidth;
  final int leftImgHeight;
  final int rightImgWidth;
  final int rightImgHeight;
  final int color;
  final int leftTitleColor;
  final int rightTitleColor;
  final int bottomBorderSize;
  final String hintText;
  final int hintTextSize;
  final int hintTextColor;

  ListItemWidget({
    this.height = 90,//item高度
    this.leftImg='',//左边图标
    this.showLeftImg = false,//是否显示左边图标
    this.leftTitle = '',//左边title
    this.rightTitle = '',//右边title
    this.rightImg='',//右边图标
    this.showRightImg = false, //是否显示右边图标
    this.onTap,//点击事件
    this.leftImgWidth = 60,//
    this.leftImgHeight = 60,
    this.rightImgHeight = 30,
    this.rightImgWidth = 30,
    this.color = 0xFFFFFFFF,
    this.leftTitleColor = 0xFF454545,
    this.rightTitleColor = 0xFF454545,
    this.bottomBorderSize = 0xFFF2F2F2,
    this.hintText = '',
    this.hintTextSize = 24,
    this.hintTextColor = 0xFF666666
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: ScreenUtil().setHeight(height),
        padding: EdgeInsets.only(left: 10,right:10),
        decoration: BoxDecoration(
          color: Color(color),
          border: Border(bottom: BorderSide(width: 1, color: Color(bottomBorderSize)))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                showLeftImg? Image.asset(leftImg ,width: ScreenUtil().setWidth(leftImgWidth),height: ScreenUtil().setWidth(leftImgHeight),) : Text(''),
                Padding(child: Text(leftTitle , style: TextStyle(fontSize: ScreenUtil().setSp(30),color: Color(leftTitleColor)),),padding: EdgeInsets.only(left: showLeftImg? 10 : 0,right: 10)),
                Text(hintText,style: TextStyle(fontSize: ScreenUtil().setSp(hintTextSize),color: Color(hintTextColor)),)
              ],
            ),
            Row(
              children: <Widget>[
                Padding(child: Text(rightTitle, style: TextStyle(fontSize: ScreenUtil().setSp(30),color: Color(rightTitleColor)),),padding: EdgeInsets.only(right: showRightImg? 10 : 0)),
                showRightImg? Image.asset(rightImg,width: ScreenUtil().setWidth(rightImgWidth),height: ScreenUtil().setHeight(rightImgHeight),) : Text('')
              ],
            )
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}