import 'package:flutter/material.dart';


class ButtonSubmit extends StatelessWidget {
  ///
  /// titulo del boton
  ///
  final String title;

  ///
  /// color de fondo del boton
  ///
  final Color color;

  ///
  /// color de texto del boton
  ///
  final Color textColor;

  ///
  /// funcion que se ejecuta al dar click
  ///
  final Function onPressed;

  const ButtonSubmit({
    this.title, 
    this.color, 
    this.textColor,
    this.onPressed
  });
  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: RaisedButton(
          child: Container( 
            padding: EdgeInsets.symmetric( vertical: 10.0 ),
            child: Text(
              this.title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20.0
              )
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          color: this.color,
          elevation: 0.0,
          textColor: this.textColor,
          onPressed: onPressed
        ),
    );
  }
}