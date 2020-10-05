import 'package:flutter/material.dart';
import 'package:pidos/src/presentation/widgets/button_submit.dart';
import 'package:pidos/src/utils/colors.dart';


class NoActionAvaiblePage extends StatelessWidget {

  final String text;

  const NoActionAvaiblePage({
    this.text
  });

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    double screenSizeHeight=_screenSize.height; 
    double screenSizeWidth=_screenSize.width; 
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.138 * screenSizeWidth ),//horizontal: 50.0
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/img/action-not-available.png'),
                fit: BoxFit.cover,
                width: 0.555 * screenSizeWidth, //width: 200.0,
              ),
              SizedBox(height: 8.0),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.025 * screenSizeHeight), //vertical: 15.0
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black, fontSize: 22.0, fontWeight: FontWeight.w400
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.025 * screenSizeHeight), //vertical: 15.0
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF01F6FE),
                        electricVioletColor,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )
                  ),
                ),
              ),
              _button(context, screenSizeHeight, screenSizeWidth)
            ],
          ),
        ),
      ),
    );
  }


  Widget _button(BuildContext context, double screenSizeHeight, double screenSizeWidth ){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.067 * screenSizeHeight, horizontal: 0.0277 * screenSizeWidth), //vertical: 40.0, horizontal: 10.0
      child: ButtonSubmit(
        color: electricVioletColor,
        onPressed: () => Navigator.of(context).pop(),
        textColor: Colors.white,
        title: 'Aceptar',
      ),
    );
  }
}