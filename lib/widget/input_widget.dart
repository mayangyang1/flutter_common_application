import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//String imgUrl, 
class InputWidget extends StatelessWidget {
  
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String inputType;
  final Function change;
  final String imgUrl;
  final bool needBorder;
  final bool showArrow;
  final bool readOnly;
  final bool enabled;
  final Function onTap;
  final int maxLines;
  final FocusNode focusNode;

  InputWidget({
    @required this.controller,//input控制器
    @required this.hintText,//占位文字
    this.obscureText = false,//是否显示文字
    this.inputType,//文本类型
    this.change,//输入变化函数
    this.imgUrl,//前置图标
    this.needBorder = true,//是否需要边框
    this.showArrow = false,//是否显示后面箭头图标
    this.readOnly = false,//只读状态
    this.enabled = true,
    this.onTap, //点击函数
    this.maxLines = 1,
    this.focusNode
  });
  @override
  Widget build(BuildContext context) {
   return Container(
        // margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      // padding: EdgeInsets.only(left: 5.0,right: 5.0),
      decoration: BoxDecoration(
        border: needBorder? Border.all(width: 1.0, color: Color(0xFFCCCCCC)) : null,
        borderRadius: needBorder? BorderRadius.circular(5.0) : null
      ),
      child: Row(
        children: <Widget>[
          imgUrl != null? Padding(child: Image.asset(imgUrl,width: ScreenUtil().setWidth(60),),padding: EdgeInsets.only(left: 5.0),) :Text(''),
          Padding(child: null,padding: EdgeInsets.only(left: 10),),
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: hintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3.0),
                  borderSide: BorderSide(color: Colors.transparent)
                ),
                disabledBorder: InputBorder.none,
                enabledBorder:InputBorder.none,
                focusedBorder:InputBorder.none
              ),
              readOnly: readOnly,
              enabled: enabled,
              cursorColor: Colors.black,
              obscureText: obscureText,
              maxLines: maxLines,
              keyboardType:inputType == 'number'? TextInputType.number : TextInputType.text,
              onChanged: (text){
                return change(text);
              },
            ),
          ),
          Padding(child: null,padding: EdgeInsets.only(left: 10),),
          showArrow? Image.asset('assets/images/arrow.png',width: ScreenUtil().setWidth(18),) : Text('')
        ],
      ),
    );
  }
} 