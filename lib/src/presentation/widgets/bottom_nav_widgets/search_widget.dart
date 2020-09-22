import 'package:flutter/material.dart';



class AliadosInput extends StatefulWidget {
  final String hintTitle;

  const AliadosInput({Key key, this.hintTitle}) : super(key: key);

  @override
  _AliadosInputState createState() => _AliadosInputState();
}

class _AliadosInputState extends State<AliadosInput> {



  @override
  Widget build(BuildContext context) {
    return TextField(
      // keyboardType: widget.inputType,
      keyboardType: TextInputType.text,
      textAlign: TextAlign.center, 
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.white,
        fontSize: 15.0
      ),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        isDense: true,
        hintText: widget.hintTitle,
        // suffixIcon: suffixIcon(),
        // suffixIconConstraints: BoxConstraints(
        //       minHeight: 0,
        //       minWidth: 0,
        // ),
        hintStyle: TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Colors.transparent,
        focusColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: Colors.white, width: 1.5),
          ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: Colors.white, width: 1.5),
        ),
      ),
    );
  }
}