import 'package:flutter/material.dart';
import 'package:pidos/src/domain/models/usuario.dart';
import 'package:pidos/src/utils/colors.dart';


class TerminosYPoliticasDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TerminosYPoliticasDialogState();
}

class TerminosYPoliticasDialogState extends State<TerminosYPoliticasDialog> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;
  // Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    // opacityAnimation = Tween<double>(begin: 0.0, end: 0.4).animate(
    //     CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
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
                    Text('Terminos y políticas uso', style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600, fontSize: 16.0 )),
                    Text(
                      'Revisa o descarga nuestros terminos y políticas de uso de Pidos', 
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF666666), fontWeight: FontWeight.w300,fontSize: 15.0 ) 
                    ),
                    SizedBox(height: 5.0),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 0.0),
                      child: _buttons(title: 'Términos y condiciones', terminosYPoliticasDeUso: TerminosYPoliticasDeUso.terminosYcondiones)
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 0.0),
                      child: _buttons(title: 'Políticas de privacidad', terminosYPoliticasDeUso: TerminosYPoliticasDeUso.politcasDePrivacidad)
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 0.0),
                      child: _buttons(title: 'Política de datos', terminosYPoliticasDeUso: TerminosYPoliticasDeUso.politicaDeDatos)
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
  Widget _buttons({String title, TerminosYPoliticasDeUso terminosYPoliticasDeUso }){
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
          onPressed: () => Navigator.of(context).pop(terminosYPoliticasDeUso)
        ),
      ),
    );
  }
}