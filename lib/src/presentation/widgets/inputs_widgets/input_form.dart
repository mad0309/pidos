import 'package:flutter/material.dart';
import 'package:pidos/src/utils/colors.dart';


class InputForm extends StatefulWidget {

  final TextInputType inputType;
  final String placeholderText;
  final bool obscureText;
  final Function(String) onChange;
  final TextEditingController textEditingController;
  final FocusNode focusNode;

  InputForm({
    this.inputType, 
    this.placeholderText,
    this.obscureText,
    this.onChange,
    this.textEditingController,
    this.focusNode,
  });

  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textEditingController,
      focusNode: widget.focusNode,
      obscureText: widget.obscureText,
      keyboardType: widget.inputType,
      textAlign: TextAlign.center, 
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: Color(0xFF666666)
      ),
      cursorColor: primaryColor,
      decoration: InputDecoration(
        isDense: true,
        hintText: widget.placeholderText,
        hintStyle: TextStyle(color: Color(0xFF666666).withOpacity(0.5)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: Colors.transparent, width: 2),
          ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: Colors.transparent, width: 2),
        ),
      ),
      onChanged: widget.onChange,
    );
  }
}