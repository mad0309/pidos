import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pidos/src/utils/colors.dart';


class VerificationInput extends StatelessWidget {

  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final Function(String) onSubmit;
  final Function(String) onChanged;
  final bool isLoading;

  VerificationInput({
    @required this.textEditingController,
    @required this.focusNode,
    @required this.nextFocusNode,
    @required this.onSubmit,
    @required this.onChanged,
    this.isLoading = false
  });

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    double screenSizeHeight = _screenSize.height;
    double screenSizeWidth = _screenSize.width;
    return Container(
      height: screenSizeHeight * 0.084, ///height: 50.0
      width: screenSizeWidth * 0.116,  ///width: 42.0
      child: Card(
          color: secundaryColor,
          child: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: TextField(
                  enabled: !isLoading,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  controller: this.textEditingController,
                  maxLength: 1,
                  cursorColor: Theme.of(context).primaryColor,
                  focusNode: focusNode,
                  onSubmitted: onSubmit,
                  style: (!isLoading) ? null : TextStyle(color: Colors.grey.withOpacity(0.6)),
                  inputFormatters: [
                    // WhitelistingTextInputFormatter.digitsOnly,
                    FilteringTextInputFormatter.digitsOnly,
                    // new LengthLimitingTextInputFormatter(1),
                    DigitCodeFormatter()
                  ],
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "",
                    counterText: '',
                    // hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)
                  ),
                  onChanged: onChanged
                )
          )
      )
    );
  }
  
}

class DigitCodeFormatter extends TextInputFormatter {


  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    var buf = '';

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    buf = text.substring(text.length - 1);
    buf = buf.trim();
    
      return newValue.copyWith(
        text: buf,
        selection: new TextSelection.collapsed(offset: buf.length));
    
    
  }
}

