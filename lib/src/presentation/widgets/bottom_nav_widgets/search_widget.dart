import 'package:flutter/material.dart';



class SearchWidget extends StatefulWidget {

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {

  

  Widget suffixIcon(){
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Icon(Icons.search, color: Colors.white, size: 25.0),
    );
    // return IconButton(
    //   icon: Icon(Icons.search, color: Colors.white), 
    //   onPressed: () {}
    // );
  }


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
        hintText: 'Tu búsqueda...',
        suffixIcon: suffixIcon(),
        suffixIconConstraints: BoxConstraints(
              minHeight: 0,
              minWidth: 0,
        ),
        hintStyle: TextStyle(color: Colors.white24),
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