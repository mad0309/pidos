import 'package:flutter/material.dart';
import 'package:pidos/src/utils/colors.dart';


class InputLeadingLoginWidget extends StatelessWidget {

  final TextInputType inputType;
  final bool obscureText;
  final String placeholderText;
  final String documentType;
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final Function onChange;
  final Color borderColor;

  InputLeadingLoginWidget({
    @required this.focusNode,
    @required this.inputType, 
    @required this.documentType, 
    @required this.obscureText, 
    @required this.placeholderText,
    @required this.textEditingController,
    // this.prefixIcon,
    this.onChange,
    this.borderColor = Colors.transparent
  });

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    double _screenSizeHeight = _screenSize.height;
    double _screenSizeWidth = _screenSize.width;

    Widget _leadingWidget(){
      return Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: secundaryColor
        ),
        child: Text(documentType,style: TextStyle(fontSize: 15.0,color: Color(0xFF666666))),
      );
    }

    return TextField(
      controller: textEditingController,
      obscureText: obscureText,
      keyboardType: inputType,
      focusNode: focusNode,
      textAlign: TextAlign.center, 
      style: TextStyle(
        fontWeight: FontWeight.w300,
      ),
      cursorColor: primaryColor,
      decoration: InputDecoration(
        icon: _leadingWidget(), 
        isDense: true,
        hintText: placeholderText,
        hintStyle: TextStyle(color: Color(0xFF666666)),
        filled: true,
        fillColor: secundaryColor,
        contentPadding: EdgeInsets.symmetric(vertical: _screenSizeHeight * 0.017,horizontal: _screenSizeWidth * 0.027 ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: borderColor ?? Colors.transparent, width: 2),
          ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: borderColor ?? Colors.transparent, width: 2),
        ),
      ),
      onChanged: onChange ?? (value){},
    );
  }
}