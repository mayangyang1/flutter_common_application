import 'package:flutter/material.dart';

class DottedLine extends StatelessWidget {
  final Axis axis;
  final double dashedWidth;
  final double dashedHeight;
  final int count;
  final Color color;

  DottedLine({
    @required this.axis,
    this.dashedWidth = 1,
    this.dashedHeight = 1,
    this.count,
    this.color = const Color(0xffff0000)
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Flex(
          direction: this.axis,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(this.count, (int index) {
            return SizedBox(
              width: dashedWidth,
              height: dashedHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}