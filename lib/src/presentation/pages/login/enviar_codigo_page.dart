import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pidos/src/presentation/blocs/login/enviar_codigo_bloc.dart';
import 'package:pidos/src/presentation/states/registro_message.dart';
import 'package:pidos/src/presentation/widgets/login/input_login_widget.dart';
import 'package:pidos/src/utils/colors.dart';


class EnviarCodigoPage extends StatefulWidget {


  @override
  _EnviarCodigoPageState createState() => _EnviarCodigoPageState();
}

class _EnviarCodigoPageState extends State<EnviarCodigoPage> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  double screenSizeHeight;
  double screenSizeWidth;

  TextEditingController nroCelularController;
  FocusNode nroCelularFocus;

  StreamSubscription enviarCodigoMessage$;

  @override
  void initState() { 
    nroCelularController = TextEditingController();
    nroCelularFocus = FocusNode();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    enviarCodigoMessage$ ??= BlocProvider.of<EnviarCodigoBloc>(context).enviarCodigoMessage$.listen((message) {
      if( message is EnviarCodigoSuccessMessage ){
        Navigator.of(context).pushNamed('/ingresa_codigo',arguments: message.usuario);
      }
      if( message is EnviarCodigoErrorMessage ){
        mostrarSnackBar(message.message);
      }
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() { 
    enviarCodigoMessage$?.cancel();
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
            SizedBox(height: screenSizeHeight * 0.1013),  //height: 60.0
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
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: Text(
        'Crea tu cuenta', 
        style: TextStyle(
          fontFamily: 'Raleway',
          color: primaryColor,
          fontSize: 30.0,
          fontWeight: FontWeight.w700
        ),
      )
    );
  }

  ///
  /// Caja de texto para ingresar telefono
  ///
  Widget _phoneSection(){
    final _enviarCodigoBloc = BlocProvider.of<EnviarCodigoBloc>(context);
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
            placeholderText: 'Ingresa tu numero',
            prefixIcon: Container(
              child: Padding(
                padding: EdgeInsets.only(top: 0.0,left: 10.0),
                child: Text('+57 |',style: TextStyle(
                  fontSize: 18.0,
                  color: Color(0xFF666666)
                )),
              ),
            ),
            onChange: _enviarCodigoBloc.onChangedNroCelular,
          )
      ],
    );
  }

  ///
  /// Boton de siguiente
  ///
  Widget _accederButton(){
    final _enviarCodigoBloc = BlocProvider.of<EnviarCodigoBloc>(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenSizeHeight  * 0.0506 ), //vertical: 30.0
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          child: Container( 
            padding: EdgeInsets.symmetric( vertical: screenSizeHeight * 0.016 ), // vertical: 10.0
            child: StreamBuilder<bool>(
              stream: _enviarCodigoBloc.isLoadingEnviarCodigo$,
              builder: (context, snapshot) {
                final isLoading = snapshot.data ?? false;
                if( !isLoading ){
                  return Text(
                    'Enviar codigo',
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
          onPressed: _enviarCodigo
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    screenSizeHeight = MediaQuery.of(context).size.height;
    screenSizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _logoImage(),
                _creaTuCuentSection(),
                _phoneSection(),
                _accederButton()
              ],
            ),
          ),
        ),
      )
    );
  }

  _enviarCodigo(){
    final _enviarCodigoBloc = BlocProvider.of<EnviarCodigoBloc>(context);
    final nroCelular = _enviarCodigoBloc.nroCelular$.value;
    if(nroCelular!=null && nroCelular.length>=9){
      _enviarCodigoBloc.onSubmitEnviarCodigo();
    }else{
      mostrarSnackBar('Numero de telefono invalido');
    }
  }
}