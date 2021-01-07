import 'package:flutter/material.dart';
import 'package:flutter_common_application/components/simple_modal.dart';
import 'package:flutter_common_application/widget/button_widget.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:flutter_common_application/pages/mine/mine_page_controller.dart';

class MinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('mine'),),
      body: GetBuilder<MinePageController>(
        init: MinePageController(),
        builder: (_) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[

                ButtonWidget(
                  title: '退出',
                  onTap: (){
                    ShowSimpleModal.showModal(
                      context,
                      '提示',
                      '确认退出登录？', 
                      _.loginOut
                    );
                  },
                  marginBottom: 40,
                )
              ],
            )
          );
        }
      )
    );
  }
}
