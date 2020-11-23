import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pidos/src/utils/colors.dart';

class InputFormDialog extends StatefulWidget {

  final TextEditingController textEditingController;
  final TextInputType inputType;
  final FocusNode focusNode;
  final String placeholderText;
  final Function(String) onChange;
  final String sufix;
  final String prefix;
  final Color borderColor;

  const InputFormDialog({
    this.textEditingController, 
    this.inputType, 
    this.focusNode, 
    this.placeholderText,
    this.onChange,
    this.sufix = '',
    this.prefix = '',
    this.borderColor = Colors.transparent
  });
  
  @override
  _InputFormDialogState createState() => _InputFormDialogState();
}

class _InputFormDialogState extends State<InputFormDialog> {
  
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textEditingController,
      obscureText: false,
      keyboardType: widget.inputType,
      focusNode: widget.focusNode,
      textAlign: TextAlign.center, 
      style: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w400,
      ),
      cursorColor: primaryColor,
      inputFormatters: [
        // WhitelistingTextInputFormatter.digitsOnly,
        FilteringTextInputFormatter.digitsOnly,
        new LengthLimitingTextInputFormatter(15),
        new SufixInputFormatter(widget.sufix ?? '', widget.prefix ?? '')
      ],
      decoration: InputDecoration(
        isDense: true,
        hintText: widget.placeholderText,
        hintStyle: TextStyle(color: Color(0xFF666666).withOpacity(0.6)),
        filled: true,
        fillColor: secundaryColor,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0 ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: widget.borderColor ?? Colors.transparent, width: 2),
          ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: widget.borderColor ?? Colors.transparent, width: 2),
        ),
      ),
      onChanged: widget.onChange ?? (value){},
    );
  }
}


class SufixInputFormatter extends TextInputFormatter {

  final String sufix;
  final String prefix;

  SufixInputFormatter(this.sufix,this.prefix);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    var buf = '';
    bool isPrefix = (prefix.length>0) ? true : false;
    bool isSufix = (sufix.length>0) ? true : false;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    
    if(isPrefix){
      if(text.length>0){
        buf = text.replaceAll(prefix, '');
        buf = buf.replaceAll(' ', '');
        buf = '$prefix' + buf;
      }else{
        buf = text.replaceAll(sufix, '');
        buf = buf.trim();
      }
    }else{
      if(text.length>0){
        buf = text.replaceAll('  $sufix', '');
        buf = buf.replaceAll(' ', '');
        buf = buf + '$sufix';
      }else{
        buf = text.replaceAll(sufix, '');
        buf = buf.trim();
      }
    }

    if(isPrefix){
      return newValue.copyWith(
        text: buf,
        selection: new TextSelection.collapsed(offset: buf.length));        
    }else{
      return newValue.copyWith(
        text: buf,
        selection: new TextSelection.collapsed(offset: (buf.length == 0) ? buf.length: buf.length - ('$sufix').length));
    }
    
  }
}