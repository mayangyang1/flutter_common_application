import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './input_widget.dart';

class InputItemWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int height;
  final bool obscureText;
  final String inputType;
  final Function change;
  final bool showArrow;
  final bool enabled;
  final Function onTap;
  final bool showLeftIcon;
  final String leftIcon;
  final String leftTitle;
  final String rightTitle;
  final bool showRightIcon;
  final String rightIcon;
  final Function tapAction;
  final Widget widget;
  final leftTitleWidth;
  final int rightIconSize;
  final FocusNode focusNode;
  final int bgColor;

  InputItemWidget({
    @required this.controller,//input控制器
    @required this.hintText,//占位文字
    this.obscureText = false,//是否显示文字
    this.height = 100,
    this.inputType,//文本类型
    this.change,//输入变化函数
    this.showArrow = false,//是否显示后面箭头图标
    this.enabled = true,
    this.onTap, //点击函数
    this.showLeftIcon = false,//是否显示左边图片
    this.leftIcon = '',//左边图片
    this.leftTitle = '',//左边title
    this.rightTitle = '',//右边title
    this.showRightIcon = false,//是否显示右边图标
    this.rightIcon = '',//右边图标
    this.tapAction,//右边图标点击事件
    this.widget, //右侧自定义widget
    this.leftTitleWidth = 210,//左侧title长度
    this.rightIconSize = 60,
    this.focusNode,
    this.bgColor = 0xFFFFFFFF,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right:10),
      height: ScreenUtil().setHeight(height),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Color(0xFFF2F2F2))),
        color: Color(bgColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          showLeftIcon?
          Padding(
            child: SizedBox(
              width: ScreenUtil().setWidth(60),
              height: ScreenUtil().setWidth(60),
              child: Image.asset(leftIcon,),
            ),
            padding: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
          ) : SizedBox(width: 0,),
          Container(
            width: ScreenUtil().setWidth(leftTitleWidth),
            child: Text(leftTitle),
          ),
          Expanded(
            child: InkWell(
              child: InputWidget(controller: controller,hintText: hintText,obscureText: obscureText,enabled: enabled,inputType: inputType,change: change, needBorder: false,showArrow: showArrow,focusNode: focusNode,),
              onTap: onTap,
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 6),
            child: Text(rightTitle),
          ),
          showRightIcon ?
          InkWell(
            child: SizedBox(
              width: ScreenUtil().setWidth(rightIconSize),
              // height: ScreenUtil().setWidth(rightIconSize),
              child: Image.asset(rightIcon,fit: BoxFit.fill,),
            ),
            onTap:tapAction
          )
          : SizedBox(width: 0,),
          widget != null ?
          widget
          : SizedBox(width: 0,)
        ],
      ),
    );
  }
}