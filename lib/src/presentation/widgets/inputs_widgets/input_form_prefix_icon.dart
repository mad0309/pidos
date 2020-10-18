import 'package:flutter/material.dart';
import 'package:pidos/src/utils/colors.dart';

class InputFormPrefixIcon extends StatefulWidget {

  final TextInputType inputType;
  final String placeholderText;
  final String postalCode;
  final Function(String) onChange;
  final TextEditingController textEditingController;
  final FocusNode focusNode;

  InputFormPrefixIcon({
    this.inputType,
    this.placeholderText,
    this.postalCode,
    this.onChange,
    this.textEditingController,
    this.focusNode,
  });

  @override
  _InputFormPrefixIconState createState() => _InputFormPrefixIconState();
}

class _InputFormPrefixIconState extends State<InputFormPrefixIcon> {


  Widget _prefixIcon(){
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 0.0,left: 10.0),
        child: Text('+${widget.postalCode} |',style: TextStyle(
          fontSize: 18.0,
          color: Color(0xFF666666)
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      // keyboardType: widget.inputType,
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
        isDense: true,
        hintText: widget.placeholderText,
        prefixIcon: _prefixIcon(),
        prefixIconConstraints: BoxConstraints(
              minHeight: 0,
              minWidth: 0,
        ),
        hintStyle: TextStyle(color: Color(0xFF666666).withOpacity(0.5)),
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
      onChanged: widget.onChange
    );
  }
}