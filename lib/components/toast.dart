import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';

class Toast {
  static void toast(String text) {
    BotToast.showText(text: text,align: Alignment.center,contentPadding: EdgeInsets.only(left: 14, right: 14, top: 7, bottom: 7),duration: Duration(milliseconds: 3000));
  }
  static void loading() {
    BotToast.showLoading();
  }

  static void hideLoading() {
    BotToast.closeAllLoading();
  }

  static void showSimpleNotification( String title,{String subTitle}) {
    BotToast.showSimpleNotification(title: title,subTitle: subTitle);
  }

}
