import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pidos/src/presentation/blocs/login/recuperar_contrasena_bloc.dart';
import 'package:pidos/src/presentation/states/recuperar_contrasena_message.dart';
import 'package:pidos/src/presentation/widgets/login/input_login_widget.dart';
import 'package:pidos/src/utils/colors.dart';


class RecuperarContrasenaPage extends StatefulWidget {

  @override
  _RecuperarContrasenaPageState createState() => _RecuperarContrasenaPageState();
}

class _RecuperarContrasenaPageState extends State<RecuperarContrasenaPage> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController emailController;
  FocusNode emailFocus;

  //screenSize
  double _screenSizeHeight;
  double _screenSizeWidth;

  StreamSubscription recuperarContrasenaMessage$;


  @override
  void initState() { 
    emailController = TextEditingController();
    emailFocus = FocusNode();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    recuperarContrasenaMessage$ ??= BlocProvider.of<RecuperarContrasenaBloc>(context).recuperarContrasenaMessage$.listen((message) {
      if( message is RecuperarContrasenaSuccessMessage ){
        Navigator.of(context).pushNamed('/recuperar_contrasena_message', arguments: true);
      }
      if( message is RecuperarContrasenaErrorMessage ){
        Navigator.of(context).pushNamed('/recuperar_contrasena_message', arguments: false);
      }
    });
    super.didChangeDependencies();
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
              width: _screenSizeWidth * 0.277, //width: 100.0
              // width: _screenSizeWidth * 0.22 , //width: 80.0
            )
          ],
        ),
      ),
    );
  }

  Widget _title(){
    return Padding(
      padding: EdgeInsets.only(top: _screenSizeHeight * 0.0337, bottom: _screenSizeHeight * 0.016 ), //top: 20.0, bottom: 10.0
      child: Text('¡No te preocupes!', style: TextStyle(fontFamily: 'Raleway',color: primaryColor, fontSize: 20.0,fontWeight: FontWeight.w700)),
    );
  }

  Widget _descripcion(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: _screenSizeWidth * 0.138), //vertical: 0.0, horizontal: 50.0
      child: Text(
        'Escríbe a continuación la dirección de correo asociada a tu cuenta y te enviaremos un enlace de recuperación.',
        textAlign: TextAlign.center,
        style: TextStyle(color: Color(0xFF666666), fontSize: 18.0,fontWeight: FontWeight.w300)),
    );
  }

  Widget _ingresaEmail(){
    final _recuperarContrasenaBloc = BlocProvider.of<RecuperarContrasenaBloc>(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: _screenSizeWidth * 0.138),
      child: InputLoginWidget(
        focusNode: emailFocus,
        textEditingController: emailController,
        inputType: TextInputType.emailAddress,
        obscureText: false, 
        placeholderText: 'Ingrese su email',
        onChange: _recuperarContrasenaBloc.onChangedEmail
      ),
    );
  }

  ///
  /// Boton de enviar
  ///
  Widget _enviarButton(){
    final _recuperarContrasenaBloc = BlocProvider.of<RecuperarContrasenaBloc>(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: _screenSizeWidth * 0.138 ), //vertical: 5.0, horizontal: 50.0
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          child: Container( 
            padding: EdgeInsets.symmetric( vertical: _screenSizeHeight * 0.016 ), //vertical: 10.0
            child: StreamBuilder<bool>(
              stream: BlocProvider.of<RecuperarContrasenaBloc>(context).isLoading$,
              builder: (context, snapshot) {
                final isLoading = snapshot.data ?? false;
                if( !isLoading ){
                  return Text(
                    'Enviar',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0
                    )
                  );
                }else{
                  return SpinKitWave(
                    color: Colors.white,
                    size: 22.0,
                  );
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
          onPressed: () async {
            emailFocus.unfocus();
            final isValid = await _validarEmail();
            if( !isValid ) return;
            _recuperarContrasenaBloc.onSubmit();
          }
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
                SizedBox(height: _screenSizeHeight *0.0473), //height: 28.0
                _title(),
                _descripcion(),
                _ingresaEmail(),
                _enviarButton()
              ],
            )
          ),
        ),
      ),
    );
  }
  // Metodo para mostrar un snackbar
  void mostrarSnackBar( String mensaje ) {
    final snackbar = SnackBar(
      content: Text( mensaje ),
      duration: Duration( milliseconds: 3000 ),
    );
   scaffoldKey.currentState.showSnackBar(snackbar);
  }


  Future<bool> _validarEmail() async {
    final email = BlocProvider.of<RecuperarContrasenaBloc>(context).email$.value;
    if(email==null || email.length==0){
      mostrarSnackBar('Ingrese un email');
      return Future.value(false);
    }else{
      Pattern pattern=  r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
      RegExp regExp = new RegExp(pattern);

      if(regExp.hasMatch(email) && email.length >=1){
        return Future.value(true);
      }else{
        mostrarSnackBar('Ingrese un email valido');
        return Future.value(false);
      }
    }
    
  }
}