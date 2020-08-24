import 'package:flutter/material.dart';


class BellIcon extends StatelessWidget {

  final String imageUrl;
  final double size;

  const BellIcon({Key key, this.imageUrl, this.size}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0),
      child: SizedBox(
        width: size,
        child: Image(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}