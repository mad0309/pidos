import 'package:flutter/material.dart';
import 'package:pidos/src/utils/colors.dart';



class AliadosWidget extends StatelessWidget {

  final String title;

  AliadosWidget({
    this.title
  });

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: _screenSize.width * 0.35,
          height: 110.0,
          color: Color(0xFF75599D) 
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Text(title, style: TextStyle(color: Color(0xFF333333), fontSize: 15.0, fontWeight: FontWeight.w600))
        )
      ],
    );


  }
}