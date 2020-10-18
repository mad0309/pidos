import 'package:flutter/material.dart';
import 'package:pidos/src/utils/colors.dart';

class InputFormLeadingIcon extends StatefulWidget {

  final TextInputType inputType;
  final String placeholderText;
  final String documentType;
  final Function(String) onChange;
  final TextEditingController textEditingController;
  final FocusNode focusNode;

  InputFormLeadingIcon({
    this.inputType, 
    this.placeholderText, 
    this.documentType,
    this.onChange,
    this.textEditingController,
    this.focusNode,
  });

  @override
  _InputFormLeadingIconState createState() => _InputFormLeadingIconState();
}

class _InputFormLeadingIconState extends State<InputFormLeadingIcon> {

  Widget _leadingWidget(){
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white
      ),
      child: Text(widget.documentType,style: TextStyle(fontSize: 18.0,color: Color(0xFF666666))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textEditingController,
      focusNode: widget.focusNode,
      keyboardType: widget.inputType,
      textAlign: TextAlign.center, 
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: Color(0xFF666666)
      ),
      cursorColor: primaryColor,
      decoration: InputDecoration(
        icon: _leadingWidget(), 
        isDense: true,
        hintText: widget.placeholderText, ///placeHolder
        hintStyle: TextStyle(color: Color(0xFF666666).withOpacity(0.5)), //placeHolder Style
        filled: true,
        fillColor: Colors.white,
        focusColor: Colors.white,
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