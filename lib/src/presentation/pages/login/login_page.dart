import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:pidos/src/data/local/preferencias_usuario.dart';
import 'package:pidos/src/presentation/blocs/login/login_bloc.dart';
import 'package:pidos/src/presentation/states/login_message.dart';
import 'package:pidos/src/presentation/widgets/login/input_login_widget.dart';
import 'package:pidos/src/utils/colors.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  //screenSize
  double _screenSizeHeight;
  double _screenSizeWidth;

  /// subscripctions
  StreamSubscription _loginMessage$;

  //focus nodes
  FocusNode nroCelularFocus =FocusNode();
  FocusNode contrasenaFocus =FocusNode();

  @override
  void didChangeDependencies() {
    _loginMessage$ ??= BlocProvider.of<LoginBloc>(context).loginMessage$.listen((message) async { 
      if( message is LoginSuccessMessage ){
        final _prefs = PreferenciasUsuario();
        final usuario = _prefs.getUsuario();
        final idNuevoUsuario = _prefs.get(StorageKeys.newAccountFirstLogin);
        mostrarSnackBar('Login successfully');
        await Future.delayed(Duration(milliseconds: 1000));
        if( idNuevoUsuario!=null && idNuevoUsuario!="" && num.parse(idNuevoUsuario) == usuario.id ){
          Navigator.of(context).pushReplacementNamed('/mi_cuenta');
        }else{
          Navigator.of(context).pushReplacementNamed('/home');
        }
        BlocProvider.of<LoginBloc>(context).onChangeNroCelular('');
        BlocProvider.of<LoginBloc>(context).onChangeContrasena('');
      }
      if( message is LoginErrorMessage ){
        mostrarSnackBar(message.message);
      }
    });
    super.didChangeDependencies();
  }
  @override
  void dispose() { 
    _loginMessage$?.cancel();
    super.dispose();
  }

  // Metodo para mostrar un snackbar
  void mostrarSnackBar( String mensaje ) {
    final snackbar = SnackBar(
      content: Text( mensaje ),
      duration: Duration( milliseconds: 3000 ),
    );
   scaffoldKey.currentState.showSnackBar(snackbar);
  }

  //metodo unfocus
  void _unfocus(){
    nroCelularFocus.unfocus();
    contrasenaFocus.unfocus();
  }

  ///
  /// Imagen de fondo
  ///
  Widget _backgroundImage(){
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white
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
              image: AssetImage('assets/img/acerca_de_icon.png'),
              fit: BoxFit.cover,
              // width: _screenSizeWidth * 0.33, //width: 120.0
              width: _screenSizeWidth * 0.22 , //width: 80.0
            )
          ],
        ),
      ),
    );
  }

  Widget _title(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: _screenSizeHeight * 0.0337), //vertical: 20.0
      child: Text('Acceder', style: TextStyle(fontFamily: 'Raleway',color: primaryColor, fontSize: 30.0,fontWeight: FontWeight.w700)),
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
              color: Colors.black,
              fontWeight: FontWeight.w300
            ),
            children: <TextSpan>[
              TextSpan(text: '¿No tienes cuenta? Crea una '),
              TextSpan(
                text: 'aquí', 
                style: new TextStyle(fontWeight: FontWeight.bold,color: electricVioletColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Navigator.of(context).pushNamed('/registro') 
                  // ..onTap = () => Navigator.of(context).pushNamed('/registro_webview') 
              ),
            ],
          ),
        ),
        SizedBox(height: _screenSizeHeight * 0.016 ), //height: 10.0
        Text(
          '¿Olvidaste tu contraseña?',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
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
      key: scaffoldKey,
      body: GestureDetector(
        onTap: _unfocus,
        child: Stack(
          children: [
            _backgroundImage(),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _logoImage(),
                  _title(),
                  _LoginForm( nroCelularFocus: nroCelularFocus, contrasenaFocus: contrasenaFocus ),
                  bottomSection()
                ],
              )
            ),
          ],
        ),
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

  /// focusNode
  final FocusNode nroCelularFocus;
  final FocusNode contrasenaFocus;

  const _LoginForm({
    this.nroCelularFocus, 
    this.contrasenaFocus
  });

  @override
  __LoginFormState createState() => __LoginFormState();
}

class __LoginFormState extends State<_LoginForm> with SingleTickerProviderStateMixin {

   double _screenSizeHeight;
   double _screenSizeWidth;

  /// controllers
  TextEditingController nroCelularController;
  TextEditingController contrasenaController;
  

  Widget loadingWidget;



  /// Metodo de ciclo de vida
  @override
  void initState() { 
    //controllers
    nroCelularController = TextEditingController(text: '');
    contrasenaController = TextEditingController(text: '');
    
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //se crea la variable una sola vez para que no se este creando en el streambuilder
    loadingWidget ??= SpinKitWave(
      color: Colors.white,
      size: 22.0,
      // controller: animationController,
    );
    super.didChangeDependencies();
  }


  /// Metodo de ciclo de vida
  @override
  void dispose() { 
    nroCelularController?.dispose();
    contrasenaController?.dispose();
    super.dispose();
  }



  ///
  /// Caja de texto para ingresar numero de celular
  /// obs: por el momento sera un input para ingresar email
  ///
  Widget _phoneSection(){
    final _loginBloc = BlocProvider.of<LoginBloc>(context);
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              // 'Tu número celular',
              'Tu email',
              style: TextStyle(
                fontSize: 18.0,
                color: primaryColor,
                fontWeight: FontWeight.w700
              )),
          ),
          // SizedBox(height: 10.0),
          InputLoginWidget(
            focusNode: widget.nroCelularFocus,
            textEditingController: nroCelularController,
            // inputType: TextInputType.number,
            inputType: TextInputType.emailAddress,
            obscureText: false, 
            // placeholderText: 'Ingresa tu numero',
            placeholderText: 'Ingresa tu email',
            // prefixIcon: Container(
            //   child: Padding(
            //     padding: EdgeInsets.only(top: 0.0,left: 10.0),
            //     child: Text('+57 |',style: TextStyle(
            //       fontSize: 18.0,
            //       color: Color(0xFF666666)
            //     )),
            //   ),
            // ),
            onChange: _loginBloc.onChangeNroCelular
          )
      ],
    );
  }

  ///
  /// Caja de texto para ingresar contraseña
  ///
  Widget _passwordSection(){
    final _loginBloc = BlocProvider.of<LoginBloc>(context);
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: _screenSizeHeight * 0.016), //vertical: 10.0
            child: Text(
              'Tu Contraseña',
              style: TextStyle(
                fontSize: 18.0, //fontSize: 18.0, 
                color: primaryColor,
                fontWeight: FontWeight.w700
              )),
          ),
          InputLoginWidget(
            focusNode: widget.contrasenaFocus,
            textEditingController: contrasenaController,
            inputType: TextInputType.text,
            obscureText: true,
            placeholderText: 'Ingresa tu contraseña',
            onChange: _loginBloc.onChangeContrasena,
          )
      ],
    );
  }

  ///
  /// Boton de logeo
  ///
  Widget _accederButton(){
    final _loginBloc = BlocProvider.of<LoginBloc>(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: _screenSizeHeight * 0.0506 ), //vertical: 30.0
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          child: Container( 
            padding: EdgeInsets.symmetric( vertical: _screenSizeHeight * 0.016 ), //vertical: 10.0
            child: StreamBuilder<bool>(
              stream: _loginBloc.isLoading$,
              initialData: false,
              builder: (context, snapshot) {
                final isLoading = snapshot.data ?? false;
                if(!isLoading){
                  return Text(
                    'Acceder',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0
                    )
                  );
                }else{
                  return loadingWidget;
                }
              }
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          color: primaryColor,
          elevation: 0.0,
          textColor: Colors.white,
          // onPressed: _loginHandle
          onPressed: () {
            widget.nroCelularFocus.unfocus();
            widget.contrasenaFocus.unfocus();
            _loginBloc.doLogin();
          }
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