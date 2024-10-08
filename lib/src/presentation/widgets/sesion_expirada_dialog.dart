import 'package:flutter/material.dart';
import 'package:pidos/src/presentation/widgets/button_submit.dart';
import 'package:pidos/src/utils/colors.dart';

/// (Dialog)
/// Cuadro de dialogo
///
Future<dynamic> sesionExpiradaDialog({
  @required BuildContext context,
}) async {
  return await showDialog(
    barrierDismissible: false,
    context: context,
    child: _SesionExpirada()
  );
}



class _SesionExpirada extends StatefulWidget {


  @override
  __SesionExpiradaState createState() => __SesionExpiradaState();
}

class __SesionExpiradaState extends State<_SesionExpirada> with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation<double> scaleAnimation;
  // Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        // color: Colors.black.withOpacity(opacityAnimation.value),
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)
              )
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 210.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Sesion expirada', style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600, fontSize: 16.0 )),
                    Text(
                      'Por favor intente logearse nuevamente', 
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF666666), fontWeight: FontWeight.w300,fontSize: 15.0 ) 
                    ),
                    SizedBox(height: 5.0),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 0.0),
                      child: _buttons(title: 'Entendido')
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///
  /// Boton de enviar
  ///
  Widget _buttons({String title }){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0 ), //vertical: 5.0, horizontal: 50.0
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric( vertical: 10.0 ), //vertical: 10.0
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13.0
              )
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          color: primaryColor,
          elevation: 0.0,
          textColor: Colors.white,
          onPressed: () => Navigator.of(context).pop()
        ),
      ),
    );
  }

}