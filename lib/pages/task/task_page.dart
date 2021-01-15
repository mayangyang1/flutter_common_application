import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:crop_box/crop_box.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
   Rect _resultRect = Rect.zero;
  /// 最大裁剪区域 会结合裁剪比例计算实际裁剪框范围
  Size _maxCropSize = Size(300, 300);
  /// 裁剪比例
  Size _cropRatio = Size(10, 9);
  /// 素材尺寸
  Size _clipSize = Size(200, 315);
  /// 裁剪区域
  Rect _cropRect;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('剪裁'),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: CropBox(
                // cropRect: Rect.fromLTRB(1 - 0.4083, 0.162, 1, 0.3078), // 2.4倍 模拟随机位置
                // cropRect: Rect.fromLTRB(0, 0, 0.4083, 0.1457), //2.4倍，都是0,0
                // cropRect: Rect.fromLTRB(0, 0, 1, 0.3572), // 1倍
                cropRect: _cropRect,
                clipSize: _clipSize,
                maxCropSize: _maxCropSize,
                cropRatio: _cropRatio,
                cropRectUpdateEnd: (rect) {
                  if(rect == null)return;
                  _resultRect = rect;
                  print("裁剪区域最终确定 $rect");
                  setState(() {});
                },
                cropRectUpdate: (rect) {
                  if(rect == null)return;
                  _resultRect = rect;
                  print("裁剪区域变化 $rect");
                  setState(() {});
                },
                child: Image.network(
                  "https://img1.maka.im/materialStore/beijingshejia/tupianbeijinga/9/M_7TNT6NIM/M_7TNT6NIM_v1.jpg",
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null)
                      return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 36.w,
            ),
            Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              child: Container(
                height: 240.w,
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "裁剪区域: ",
                      style: TextStyle(
                        fontFamily: "PingFang SC",
                        fontSize: 28.sp,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "left: ${_resultRect.left.toStringAsFixed(5)}",
                      style: TextStyle(
                        fontFamily: "PingFang SC",
                        fontSize: 28.sp,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "top: ${_resultRect.top.toStringAsFixed(5)}",
                      style: TextStyle(
                        fontFamily: "PingFang SC",
                        fontSize: 28.sp,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "right: ${_resultRect.right.toStringAsFixed(5)}",
                      style: TextStyle(
                        fontFamily: "PingFang SC",
                        fontSize: 28.sp,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "bottom: ${_resultRect.bottom.toStringAsFixed(5)}",
                      style: TextStyle(
                        fontFamily: "PingFang SC",
                        fontSize: 28.sp,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
