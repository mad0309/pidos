import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pidos/src/data/local/preferencias_usuario.dart';
import 'package:pidos/src/presentation/widgets/login/input_login_widget.dart';
import 'package:pidos/src/utils/colors.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  double _screenSizeHeight;
  double _screenSizeWidth;

  ///
  /// Imagen de fondo
  ///
  Widget _backgroundImage(){
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image(
        image: AssetImage('assets/img/fondo.jpg'),
        fit: BoxFit.cover,
      ),
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
            SizedBox(height: _screenSizeHeight * 0.084), /// height: 50.0
            Image(
              image: AssetImage('assets/img/logo_blank.png'),
              fit: BoxFit.cover,
              width: _screenSizeWidth * 0.33, //width: 120.0
            )
          ],
        ),
      ),
    );
  }


  /// 
  /// Seccion para crear cuenta y recuperar cuenta
  ///
  Widget bottomSection(){
    return Column(
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
              fontWeight: FontWeight.w300
            ),
            children: <TextSpan>[
              TextSpan(text: '¿No tienes cuenta? Crea una '),
              TextSpan(
                text: 'aquí', 
                style: new TextStyle(fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Navigator.of(context).pushNamed('/registro') 
              ),
            ],
          ),
        ),
        SizedBox(height: _screenSizeHeight * 0.016 ), //height: 10.0
        Text(
          '¿Olvidaste tu contraseña?',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.w300,
            decoration: TextDecoration.underline,
          ),
        ),
        SizedBox(height: _screenSizeHeight * 0.0337 ) //height: 20.0
      ]     
    );
  }

  ///
  /// metodo Build
  ///
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    _screenSizeHeight = _screenSize.height;
    _screenSizeWidth = _screenSize.width;
    print('_screenSizeHeight: $_screenSizeHeight');
    print('_screenSizeWidth: $_screenSizeWidth');

    return Scaffold(
      body: Stack(
        children: [
          _backgroundImage(),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _logoImage(),
                _LoginForm(),
                bottomSection()
              ],
            )
          ),
        ],
      ),
    );
  }
}




///
/// SECCION FORMULARIO
/// formulario de registro:
///   - Caja de texto: numero de celular
///   - Caja de texto: contraseña
///   - Boton: Acceder
///
///
class _LoginForm extends StatefulWidget {

  @override
  __LoginFormState createState() => __LoginFormState();
}

class __LoginFormState extends State<_LoginForm> {

   double _screenSizeHeight;
   double _screenSizeWidth;

  /// controllers
  TextEditingController nroCelularController;
  TextEditingController contrasenaController;

  /// Metodo de ciclo de vida
  @override
  void initState() { 
    nroCelularController = TextEditingController(text: '');
    contrasenaController = TextEditingController(text: '');
    super.initState();
  }
  /// Metodo de ciclo de vida
  @override
  void dispose() { 
    nroCelularController?.dispose();
    contrasenaController?.dispose();
    super.dispose();
  }


  ///
  /// Login Action
  /// (data de prueba)
  ///
  _loginHandle(){
    //guarda los registros en el Storage Local
    final _sharedPrefs = PreferenciasUsuario();
    if( nroCelularController.value.text.startsWith('7') ){
      _sharedPrefs.set(StorageKeys.usuario, 'Ricardo');
      _sharedPrefs.set(StorageKeys.perfil, 'COMERCIANTE');
      _sharedPrefs.set(StorageKeys.pid, '30908798');
      _sharedPrefs.set(StorageKeys.shortName, 'RC');
    }else{
      _sharedPrefs.set(StorageKeys.usuario, 'KFC');
      _sharedPrefs.set(StorageKeys.perfil, 'CLIENTE');
      _sharedPrefs.set(StorageKeys.pid, 'A30908798');
      _sharedPrefs.set(StorageKeys.shortName, 'K');
    }
    Navigator.of(context).pushReplacementNamed('/home');
  }

  ///
  /// Caja de texto para ingresar numero de celular
  ///
  Widget _phoneSection(){
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              'Tu número celular',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.w600
              )),
          ),
          // SizedBox(height: 10.0),
          InputLoginWidget(
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
  /// Caja de texto para ingresar contraseña
  ///
  Widget _passwordSection(){
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: _screenSizeHeight * 0.016), //vertical: 10.0
            child: Text(
              'Tu Contraseña',
              style: TextStyle(
                fontSize: 18.0, //fontSize: 18.0, 
                color: Colors.white,
                fontWeight: FontWeight.w600
              )),
          ),
          InputLoginWidget(
            textEditingController: contrasenaController,
            inputType: TextInputType.text,
            obscureText: true,
            placeholderText: 'Ingeresa tu contraseña',
          )
      ],
    );
  }

  ///
  /// Boton de logeo
  ///
  Widget _accederButton(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: _screenSizeHeight * 0.0506 ), //vertical: 30.0
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          child: Container( 
            padding: EdgeInsets.symmetric( vertical: _screenSizeHeight * 0.016 ), //vertical: 10.0
            child: Text(
              'Acceder',
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
          onPressed: _loginHandle
        ),
      ),
    );
  }



  
  ///
  /// Metodo Build
  ///
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    _screenSizeHeight = _screenSize.height;
    _screenSizeWidth = _screenSize.width;
    return Padding(
      padding: EdgeInsets.only(top: 10.0,left: 40.0, right: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _phoneSection(),
          _passwordSection(),
          _accederButton()
        ],
      ),
    );
  }
}