import 'package:flutter/material.dart';
import 'package:pidos/src/utils/colors.dart';



class InputLoginWidget extends StatefulWidget {

  final TextInputType inputType;
  final bool obscureText;
  final String placeholderText;
  final Widget prefixIcon;
  final TextEditingController textEditingController;
  final FocusNode focusNode;

  InputLoginWidget({
    @required this.focusNode,
    @required this.inputType, 
    @required this.obscureText, 
    @required this.placeholderText,
    @required this.textEditingController,
    this.prefixIcon,
  });


  @override
  _InputLoginWidgetState createState() => _InputLoginWidgetState();
}

class _InputLoginWidgetState extends State<InputLoginWidget> {
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    double _screenSizeHeight = _screenSize.height;
    double _screenSizeWidth = _screenSize.width;

    return TextField(
      controller: widget.textEditingController,
      obscureText: widget.obscureText,
      keyboardType: widget.inputType,
      focusNode: widget.focusNode,
      textAlign: TextAlign.center, 
      style: TextStyle(
        fontWeight: FontWeight.w300,
      ),
      cursorColor: primaryColor,
      decoration: InputDecoration(
        isDense: true,
        hintText: widget.placeholderText,
        prefixIcon: widget.prefixIcon,
        prefixIconConstraints: BoxConstraints(
              minHeight: 0,
              minWidth: 0,
        ),
        
        hintStyle: TextStyle(color: Color(0xFF666666)),
        filled: true,
        fillColor: secundaryColor,
        contentPadding: EdgeInsets.symmetric(vertical: _screenSizeHeight * 0.017,horizontal: _screenSizeWidth * 0.027 ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: Colors.transparent, width: 2),
          ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: Colors.transparent, width: 2),
        ),
      ),
    );
  }
}