import 'package:flutter/material.dart';
import 'package:pidos/src/presentation/widgets/login/input_login_widget.dart';
import 'package:pidos/src/utils/colors.dart';


class RegistroPage extends StatefulWidget {
  

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {

  double screenSizeHeight;
  double screenSizeWidth ;

  ///
  /// Imagen de fondo
  ///
  Widget _backgroundImage(){
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
    ); 
  }

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
            SizedBox(height: screenSizeHeight * 0.067),  ///height: 40.0
            Image(
              image: AssetImage('assets/img/acerca_de_icon.png'),
              fit: BoxFit.cover,
              width: screenSizeWidth * 0.222, //width: 80.0
            )
          ],
        ),
      ),
    );
  }

  ///
  /// Crea tu cuenta
  ///
  Widget _creaTuCuentSection(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      child: Text(
        'Crea tu cuenta', 
        style: TextStyle(
          fontFamily: 'Raleway',
          // color: Colors.white,
          color: primaryColor,
          fontSize: 30.0,
          fontWeight: FontWeight.w700
        ),
      )
    );
  }



  @override
  Widget build(BuildContext context) {
    screenSizeHeight = MediaQuery.of(context).size.height;
    screenSizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          _backgroundImage(),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _logoImage(),
                _creaTuCuentSection(),
                _RegistroForm(),
              ],
            )
          ),
        ],
      ),
    );
  }
}

class _RegistroForm extends StatefulWidget {
  

  @override
  __RegistroFormState createState() => __RegistroFormState();
}

class __RegistroFormState extends State<_RegistroForm> {

  double screenSizeHeight;
  double screenSizeWidth;

  /// controllers
  TextEditingController nroCelularController;
  TextEditingController nombreController;

  //focusNode
  FocusNode nroCelularFocus;
  FocusNode nombreFocus;

  /// Metodo de ciclo de vida
  @override
  void initState() { 
    nroCelularController = TextEditingController(text: '');
    nombreController = TextEditingController(text: '');
    nroCelularFocus = FocusNode();
    nombreFocus = FocusNode();
    super.initState();
  }
  /// Metodo de ciclo de vida
  @override
  void dispose() { 
    nroCelularController?.dispose();
    nombreController?.dispose();
    super.dispose();
  }

  void _unfocus(){
    nroCelularFocus.unfocus();
    nombreFocus.unfocus();
  }

  ///
  /// Caja de texto para ingresar numero de celular
  ///
  Widget _nameSection(){
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: screenSizeHeight * 0.016 ), // vertical: 10.0
            child: Text(
              'Tus nombres',
              style: TextStyle(
                fontSize: 18.0,
                color: primaryColor,
                fontWeight: FontWeight.w700
              )),
          ),
          // SizedBox(height: 10.0),
          InputLoginWidget(
            focusNode: nombreFocus,
            textEditingController: nombreController,
            inputType: TextInputType.text,
            obscureText: false,
            placeholderText: 'Ingeresa su nombre',
          )
      ],
    );
  }

  ///
  /// Caja de texto para ingresar contraseña
  ///
  Widget _phoneSection(){
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: screenSizeHeight * 0.016 ), // vertical: 10.0
            child: Text(
              'Tu número de celular',
              style: TextStyle(
                fontSize: 18.0,
                color: primaryColor,
                fontWeight: FontWeight.w700
              )),
          ),
          InputLoginWidget(
            focusNode: nroCelularFocus,
            textEditingController: nroCelularController,
            inputType: TextInputType.number,
            obscureText: false, 
            placeholderText: 'Ingeresa tu numero',
            prefixIcon: Container(
              child: Padding(
                padding: EdgeInsets.only(top: 0.0,left: 10.0),
                child: Text('+57 |',style: TextStyle(
                  fontSize: 18.0,
                  color: Color(0xFF666666)
                )),
              ),
            ),
          )
      ],
    );
  }

  ///
  /// Boton de logeo
  ///
  Widget _accederButton(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenSizeHeight  * 0.0506 ), //vertical: 30.0
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          child: Container( 
            padding: EdgeInsets.symmetric( vertical: screenSizeHeight * 0.016 ), // vertical: 10.0
            child: Text(
              'Siguiente',
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
          onPressed: () => Navigator.of(context).pushNamed('/ingresa_codigo')
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    screenSizeHeight = MediaQuery.of(context).size.height;
    screenSizeWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: 0.0,left: 40.0, right: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _nameSection(),
          _phoneSection(),
          _accederButton()
        ],
      ),
    );
  }
}