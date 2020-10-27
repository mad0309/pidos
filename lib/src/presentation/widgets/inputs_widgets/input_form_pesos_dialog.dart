import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pidos/src/utils/colors.dart';

class InputFormPesosDialog extends StatefulWidget {

  final TextEditingController textEditingController;
  final TextInputType inputType;
  final FocusNode focusNode;
  final String placeholderText;
  final Function(String) onChange;
  // final String sufix;
  // final String prefix;

  const InputFormPesosDialog({
    this.textEditingController, 
    this.inputType, 
    this.focusNode, 
    this.placeholderText,
    this.onChange,
    // this.sufix = '',
    // this.prefix = '',
  });
  
  @override
  _InputFormDialogState createState() => _InputFormDialogState();
}

class _InputFormDialogState extends State<InputFormPesosDialog> {
  
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
        WhitelistingTextInputFormatter.digitsOnly,
        new LengthLimitingTextInputFormatter(15),
        // new PaymentInputFormatter()
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
          borderSide: BorderSide(color: Colors.transparent, width: 2),
          ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: Colors.transparent, width: 2),
        ),
      ),
      onChanged: widget.onChange ?? (value){},
    );
  }
}


class PaymentInputFormatter extends TextInputFormatter {


  PaymentInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    var buf = '';

    // if (newValue.selection.baseOffset == 0) {
    //   if( text.length> 0){
    //     return oldValue;
    //   }else{
    //     return newValue;
    //   }
    // }
    // text = text.replaceAll('\$', '');
    // if( text.length>1 ){
    //   text = text.substring(0, text.length - 5);
    // }
    // NumberFormat format = NumberFormat('#,###.000');
    // double pesos = double.parse(text);
    // buf = format.format(pesos);
    // buf = '\$$buf,00';
    // if(pesos>=1000.0){
    //  buf =  buf.replaceFirst(',', '.');
    // }
    double value = double.parse(newValue.text);

        final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

        buf = formatter.format(value/100);

    return newValue.copyWith(
      text: buf,
      selection: new TextSelection.collapsed(offset: buf.length));
      // selection: new TextSelection.collapsed(offset: buf.length));
      // selection: new TextSelection.collapsed(offset: newValue.selection.baseOffset + 2  ));
    
    
  }
}