import 'package:flutter/material.dart';
  ///
  /// @Autor: MAD
  /// CLASE QUE GENERA UN CIRCULO
  ///
class CircleWidget extends StatelessWidget {

  final double width;
  final double height;
  final Color color;
  final Widget widget;
  final Color borderColor;
  final double borderWidth;

  const CircleWidget({
    @required this.width, 
    @required this.height, 
    @required this.color,
    this.widget,
    this.borderColor = Colors.transparent,
    this.borderWidth = 1.5
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      decoration: BoxDecoration(
        color: this.color,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor,width: borderWidth)
      ),
      child: widget ?? Container(),
    );
  }
}