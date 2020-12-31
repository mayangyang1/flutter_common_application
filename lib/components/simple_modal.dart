import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowSimpleModal {

  static void showModal(BuildContext context, String title , String content,Function sureTap,{ String cancelTitle='取消', String sureTitle='确认', Function cancelTap,bool showCancel=true} ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          titlePadding: const EdgeInsets.only(top: 14,bottom: 10),
          title: Center(child: Text(title??'',style: TextStyle(fontSize: ScreenUtil().setSp(36),fontWeight: FontWeight.bold),),),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
          backgroundColor: Colors.white,
          children: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: ScreenUtil().setHeight(120)),
              child: Center(
                child: Text(content??'',style: TextStyle(fontSize: ScreenUtil().setSp(30)),),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                showCancel
                ? Expanded(
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(top: BorderSide(width: 1, color: Color(0xFFf2f2f2)),right: BorderSide(width: 1,color: Color(0xFFf2f2f2)))
                      ),
                      height: ScreenUtil().setHeight(100),
                      alignment: Alignment.center,
                      child: Text(cancelTitle,style: TextStyle(fontSize: ScreenUtil().setSp(30)),),
                    ),
                    onTap: cancelTap ??(){
                        Navigator.of(context).pop();
                    },
                  )
                )
                : Text(''),
                Expanded(
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(top: BorderSide(width: 1, color: Color(0xFFf2f2f2)))
                      ),
                      height: ScreenUtil().setHeight(100),
                      alignment: Alignment.center,
                      child: Text(sureTitle,style: TextStyle(fontSize: ScreenUtil().setSp(30)),),
                    ),
                    onTap: sureTap,
                  )
                ),
              ],
            )
          ],
        );
      }
    );
  }
}