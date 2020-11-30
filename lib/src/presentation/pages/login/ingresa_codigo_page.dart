import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pidos/src/presentation/blocs/login/ingresa_codigo_bloc.dart';
import 'package:pidos/src/presentation/states/registro_message.dart';
import 'package:pidos/src/presentation/widgets/login/verification_input.dart';
import 'package:pidos/src/utils/colors.dart';
import 'package:pidos/src/utils/screen_aware_size.dart';


class IngresaCodigoPage extends StatefulWidget {

  @override
  _IngresaCodigoPageState createState() => _IngresaCodigoPageState();
}

class _IngresaCodigoPageState extends State<IngresaCodigoPage> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  double screenSizeHeight;
  double screenSizeWidth;

  /// controller
  TextEditingController _primerDigitoController;
  TextEditingController _segundoDigitoController;
  TextEditingController _terceroDigitoController;
  TextEditingController _cuartoDigitoController;
  TextEditingController _quintoDigitoController;
  TextEditingController _sextoDigitoController;

  /// Focusnode
  FocusNode _primerDigitoFocus;
  FocusNode _segundoDigitoFocus;
  FocusNode _terceroDigitoFocus;
  FocusNode _cuartoDigitoFocus;
  FocusNode _quintoDigitoFocus;
  FocusNode _sextoDigitoFocus;

  StreamSubscription ingresarCodigoMessage$;
  


  @override
  void initState() { 
    /// ====== inicilazar controllers ====== ///
    _primerDigitoController = TextEditingController(text: '');
    _segundoDigitoController = TextEditingController(text: '');
    _terceroDigitoController = TextEditingController(text: '');
    _cuartoDigitoController = TextEditingController(text: '');
    _quintoDigitoController = TextEditingController(text: '');
    _sextoDigitoController = TextEditingController(text: '');

    /// ====== inicilazar foscusNode ====== ///
    _primerDigitoFocus = FocusNode();
    _segundoDigitoFocus = FocusNode();
    _terceroDigitoFocus = FocusNode();
    _cuartoDigitoFocus = FocusNode();
    _quintoDigitoFocus = FocusNode();
    _sextoDigitoFocus = FocusNode();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    ingresarCodigoMessage$ ??= BlocProvider.of<IngresaCodigoBloc>(context).ingresarCodigoMessage$.listen((message) async {
      if( message is CodigoIngresadoSuccessMessage ) {
        mostrarSnackBar('Codigo Valido');
        await Future.delayed(Duration(milliseconds: 800));
        // Navigator.of(context).pushReplacementNamed('/login');
        Navigator.of(context)..pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      }
      if( message is CodigoIngresadoErrorMessage ){
        _cleanControllers();
        BlocProvider.of<IngresaCodigoBloc>(context).cleanControllers();
        mostrarSnackBar(message.message ?? 'Ocurrio un error, intentelo más tarde');
      }
    });
    super.didChangeDependencies();
  }


  /// metodo dispose
  @override
  void dispose() { 
    _primerDigitoController?.dispose();
    _segundoDigitoController?.dispose();
    _terceroDigitoController?.dispose();
    _cuartoDigitoController?.dispose();
    _quintoDigitoController?.dispose();
    _sextoDigitoController?.dispose();
    ingresarCodigoMessage$?.cancel();
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

  _unfocus(){
    _primerDigitoFocus.unfocus();
    _segundoDigitoFocus.unfocus();
    _terceroDigitoFocus.unfocus();
    _cuartoDigitoFocus.unfocus();
    _quintoDigitoFocus.unfocus();
    _sextoDigitoFocus.unfocus();
  }

  _cleanControllers(){
    _primerDigitoController.text = '';
    _segundoDigitoController.text = '';
    _terceroDigitoController.text = '';
    _cuartoDigitoController.text = '';
    _quintoDigitoController.text = '';
    _sextoDigitoController.text = '';
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
  /// Seccion para insertar le codigo recivido
  ///
  Widget _ingresaCodigoSection(){
    final _ingresarCodigoBloc = BlocProvider.of<IngresaCodigoBloc>(context);
    return Column(
      children: [
        Text(
          'Ingresa el código enviado al',
          style: TextStyle(
            color: primaryColor,
            fontSize: 15.0,
            fontWeight: FontWeight.w500
          ),
        ),
        Text(
          '300 1234567',
          style: TextStyle(
            color: primaryColor,
            fontSize: 15.0,
            fontWeight: FontWeight.w500
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: screenSizeHeight * 0.042),  //vertical: 25.0
          child: StreamBuilder<bool>(
            stream: _ingresarCodigoBloc.isLoaindgIngresaCodigo$,
            initialData: false,
            builder: (context, snapshot) {
              final isLoading = snapshot.data ?? false;
              print(isLoading);
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (isLoading) ? (){} : () => FocusScope.of(context).requestFocus(_primerDigitoFocus),
                    child: VerificationInput(
                      isLoading: isLoading,
                      textEditingController: _primerDigitoController,
                      focusNode: _primerDigitoFocus,
                      nextFocusNode: _segundoDigitoFocus,
                      onSubmit: _onSubmit,
                      onChanged: (value) {
                        _ingresarCodigoBloc.onChangedPrimerDigito(value);
                        if (value.length == 1) {
                          FocusScope.of(context).requestFocus(_segundoDigitoFocus);
                        }
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: (isLoading) ? (){} : () => FocusScope.of(context).requestFocus(_segundoDigitoFocus),
                    child: VerificationInput(
                      isLoading: isLoading,
                      textEditingController: _segundoDigitoController,
                      focusNode: _segundoDigitoFocus,
                      nextFocusNode: _terceroDigitoFocus,
                      onSubmit: _onSubmit,
                      onChanged: (value) {
                        _ingresarCodigoBloc.onChangedSegundoDigito(value);
                        if (value.length == 1) {
                          FocusScope.of(context).requestFocus(_terceroDigitoFocus);
                        }
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: (isLoading) ? (){} : () => FocusScope.of(context).requestFocus(_terceroDigitoFocus),
                    child: VerificationInput(
                      isLoading: isLoading,
                      textEditingController: _terceroDigitoController,
                      focusNode: _terceroDigitoFocus,
                      nextFocusNode: _cuartoDigitoFocus,
                      onSubmit: _onSubmit,
                      onChanged: (value) {
                        _ingresarCodigoBloc.onChangedTercerDigito(value);
                        if (value.length == 1) {
                          FocusScope.of(context).requestFocus(_cuartoDigitoFocus);
                        }
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: (isLoading) ? (){} : () => FocusScope.of(context).requestFocus(_cuartoDigitoFocus),
                    child: VerificationInput(
                      isLoading: isLoading,
                      textEditingController: _cuartoDigitoController,
                      focusNode: _cuartoDigitoFocus,
                      nextFocusNode: _quintoDigitoFocus,
                      onSubmit: _onSubmit,
                      onChanged: (value) {
                        _ingresarCodigoBloc.onChangedCuartoDigito(value);
                        if (value.length == 1) {
                          FocusScope.of(context).requestFocus(_quintoDigitoFocus);
                        }
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: (isLoading) ? (){} : () => FocusScope.of(context).requestFocus(_quintoDigitoFocus),
                    child: VerificationInput(
                      isLoading: isLoading,
                      textEditingController: _quintoDigitoController,
                      focusNode: _quintoDigitoFocus,
                      nextFocusNode: _sextoDigitoFocus,
                      onSubmit: _onSubmit,
                      onChanged: (value) {
                        _ingresarCodigoBloc.onChangedQuintoDigito(value);
                        if (value.length == 1) {
                          FocusScope.of(context).requestFocus(_sextoDigitoFocus);
                        }
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: (isLoading) ? (){} : () => FocusScope.of(context).requestFocus(_sextoDigitoFocus),
                    child: VerificationInput(
                      isLoading: isLoading,
                      textEditingController: _sextoDigitoController,
                      focusNode: _sextoDigitoFocus,
                      nextFocusNode: _sextoDigitoFocus,
                      onSubmit: _onSubmit,
                      onChanged: (value) {
                        _ingresarCodigoBloc.onChangedSextoDigito(value);
                        if (value.length == 1) {
                          FocusScope.of(context).requestFocus(_sextoDigitoFocus);
                        }
                      },
                    ),
                  ),
                ],
              );
            }
          )
        ),
        Text(
          'Enviar de nuevo',
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: primaryColor,
            fontSize: 15.0,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 60.0),
        StreamBuilder<bool>(
          stream: _ingresarCodigoBloc.isLoaindgIngresaCodigo$,
          initialData: false,
          builder: (context, snapshot) {
            final isLoading = snapshot.data ?? false;
            if( isLoading ){
              return SpinKitCircle(
              color: primaryColor,
              size: 30.0,
            );
            }else{
              return Container();
            }
            
          }
        )
      ],
    );
  }

  ///
  /// on submit function
  ///
  void _onSubmit(String value){
    // Navigator.of(context).pushNamed('/registro_form');
  }


///
/// metodo build
///
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
          child: GestureDetector(
            onTap: _unfocus,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _logoImage(),
                _creaTuCuentSection(),
                _ingresaCodigoSection()
              ],
            ),
          ),
        ),
      )
    );
  }
}