import 'package:flutter/material.dart';
import 'package:pidos/src/utils/colors.dart';


class VerificationInput extends StatelessWidget {

  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final Function(String) onSubmit;

  VerificationInput({
    this.textEditingController,
    this.focusNode,
    this.onSubmit
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 42.0,
      child: Card(
          color: secundaryColor,
          child: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  controller: this.textEditingController,
                  maxLength: 1,
                  cursorColor: Theme.of(context).primaryColor,
                  focusNode: focusNode,
                  onSubmitted: onSubmit,
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
                  onChanged: (str) {
                    if (str.length == 1) {
                      FocusScope.of(context).requestFocus(focusNode);
                    }
                  }
                )
          )
      )
    );
  }
  
}

