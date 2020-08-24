import 'package:flutter/material.dart';
import 'package:pidos/src//utils/colors.dart';
import 'package:pidos/src/presentation/widgets/circle_color.dart';



class CircleAvatarName extends StatelessWidget {
  ///
  /// [shortName]
  /// Letras que apareceran en emdio del cirlo
  ///
  final String shortName;

  ///
  /// [diameterInside]
  /// diametro del circulo interno
  ///
  final double diameterInside;

  ///
  /// [diameterOutside]
  /// diametro del circulo externo
  ///
  final double diameterOutside;

  ///
  /// [textSize]
  /// tamaño de texto
  ///
  final double textSize;

  CircleAvatarName({
    this.shortName = '',
    this.diameterInside,
    this.diameterOutside,
    this.textSize
  });



  @override
  Widget build(BuildContext context) {
    return CircleWidget(
      color: Colors.transparent,
      borderColor: Colors.white,
      width: diameterOutside,
      height: diameterOutside,
      widget: Center(
        child: CircleWidget(
          color: cyanColor,
          width: diameterInside,
          height: diameterInside,
          widget: Center(child: Text(shortName,style: TextStyle(fontSize: textSize,color: Colors.black, fontWeight: FontWeight.w700))),
        )
      ),
    );
  }
}