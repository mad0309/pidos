import 'package:flutter/material.dart';
import 'package:pidos/src/utils/colors.dart';

class RecuperarContrasenaMessagePage extends StatefulWidget {

  final bool success;

  const RecuperarContrasenaMessagePage({
    this.success = false
  });

  @override
  _RecuperarContrasenaMessagePageState createState() => _RecuperarContrasenaMessagePageState();
}

class _RecuperarContrasenaMessagePageState extends State<RecuperarContrasenaMessagePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  double _screenSizeHeight;

  double _screenSizeWidth;

  ///
  /// Logo
  ///
  Widget _logoImage(){
    return SafeArea(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 70.0), /// height: 50.0
            Image(
              image: AssetImage('assets/img/logo_solo.png'),
              fit: BoxFit.cover,
              width: _screenSizeWidth * 0.152 , //width: 55.0
            )
          ],
        ),
      ),
    );
  }

  Widget _title(){
    return Padding(
      padding: EdgeInsets.only(top: _screenSizeHeight * 0.0337, bottom: _screenSizeHeight * 0.016 ), //top: 20.0, bottom: 10.0
      child: Text(
        (widget.success) ? '¡Súper!' : '¡Lo sentimos!', 
        style: TextStyle(fontFamily: 'Raleway',color: primaryColor, fontSize: 30.0,fontWeight: FontWeight.w700)),
    );
  }

  Widget _descripcion(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: _screenSizeWidth * 0.138), //vertical: 0.0, horizontal: 50.0
      child: Text(
        (widget.success) 
        ? 'Enviamos un link de recuperación a tu correo.'
        : 'No encontramos una cuenta asociada a ese correo.',
        textAlign: TextAlign.center,
        style: TextStyle(color: Color(0xFF666666), fontSize: 18.0,fontWeight: FontWeight.w300)),
    );
  }

  ///
  /// Boton de enviar
  ///
  Widget _volverButton(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: _screenSizeWidth * 0.138 ), //vertical: 5.0, horizontal: 50.0
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          child: Container( 
            padding: EdgeInsets.symmetric( vertical: _screenSizeHeight * 0.016 ), //vertical: 10.0
            child: Text(
              'Volver',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20.0
              )
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          color: primaryColor,
          elevation: 0.0,
          textColor: Colors.white,
          onPressed: (widget.success) 
           ? () => Navigator.of(context).pushReplacementNamed('/login')
           : () => Navigator.of(context).pop()
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    _screenSizeHeight = _screenSize.height;
    _screenSizeWidth = _screenSize.width;
    return Scaffold(
      key: scaffoldKey,
      body: GestureDetector(
        onTap: (){},
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _logoImage(),
                SizedBox(height: 50.0), //height: 28.0
                _title(),
                _descripcion(),
                _volverButton()
              ],
            )
          ),
        ),
      ),
    );
  }
}