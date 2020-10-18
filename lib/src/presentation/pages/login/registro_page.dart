import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pidos/src/presentation/blocs/login/registro_bloc.dart';
import 'package:pidos/src/presentation/states/registro_message.dart';
import 'package:pidos/src/presentation/widgets/login/input_leading_login_widget.dart';
import 'package:pidos/src/presentation/widgets/login/input_login_widget.dart';
import 'package:pidos/src/presentation/widgets/respuesta_dialog.dart';
import 'package:pidos/src/utils/colors.dart';


class RegistroPage extends StatefulWidget {
  

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  double screenSizeHeight;
  double screenSizeWidth ;

  StreamSubscription registroMessage$;

  //focusNode
  FocusNode nombreFocus;
  FocusNode nroDocumentoFocus;
  FocusNode apellidosFocus;
  FocusNode emailFocus;
  FocusNode contrasenaFocus;
  FocusNode confirmarContrasenaFocus;

  @override
  void initState() {
    nombreFocus = FocusNode();
    nroDocumentoFocus = FocusNode();
    apellidosFocus = FocusNode();
    emailFocus = FocusNode();
    contrasenaFocus = FocusNode();
    confirmarContrasenaFocus = FocusNode();
    super.initState();
  }


  @override
  void dispose() {
    registroMessage$?.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    registroMessage$ ??= BlocProvider.of<RegistroBloc>(context).registroMessage$.listen((message) {
      if( message is RegistroSuccessMessage ){
        final user = message.usuario;
        Navigator.of(context).pushNamed('/enviar_codigo',arguments: user);
      }
      if( message is RegistroErrorMessage ){
        mostrarSnackBar(message.message);
      }
    });
    super.didChangeDependencies();
  }

  // Metodo para mostrar un snackbar
  void mostrarSnackBar( String mensaje ) {
    final snackbar = SnackBar(
      content: Text( mensaje ),
      duration: Duration( milliseconds: 3000 ),
    );
   scaffoldKey.currentState.showSnackBar(snackbar);
  }

  
  void _unfocus(){
    nombreFocus.unfocus();
    nroDocumentoFocus.unfocus();
    apellidosFocus.unfocus();
    emailFocus.unfocus();
    contrasenaFocus.unfocus();
    confirmarContrasenaFocus.unfocus();
  }

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
        child: GestureDetector(
          onTap: _unfocus,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: screenSizeHeight * 0.0506),  ///height: 40.0
              Image(
                image: AssetImage('assets/img/acerca_de_icon.png'),
                fit: BoxFit.cover,
                width: screenSizeWidth * 0.18055, //width: 65.0
              )
            ],
          ),
        ),
      ),
    );
  }

  ///
  /// Crea tu cuenta
  ///
  Widget _creaTuCuentSection(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Text(
        'Crea tu cuenta', 
        style: TextStyle(
          fontFamily: 'Raleway',
          color: primaryColor,
          fontSize: 25.0,
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
      key: scaffoldKey,
      body: Stack(
        children: [
          _backgroundImage(),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _logoImage(),
                _creaTuCuentSection(),
                _RegistroForm(
                  nombreFocus: nombreFocus,
                  nroDocumentoFocus: nroDocumentoFocus,
                  apellidosFocus: apellidosFocus,
                  emailFocus: emailFocus,
                  contrasenaFocus: contrasenaFocus,
                  confirmarContrasenaFocus: confirmarContrasenaFocus,
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}

class _RegistroForm extends StatefulWidget {
  
  final FocusNode nombreFocus;
  final FocusNode nroDocumentoFocus;
  final FocusNode apellidosFocus;
  final FocusNode emailFocus;
  final FocusNode contrasenaFocus;
  final FocusNode confirmarContrasenaFocus;

  const _RegistroForm({
    this.nombreFocus, 
    this.nroDocumentoFocus, 
    this.apellidosFocus, 
    this.emailFocus, 
    this.contrasenaFocus, 
    this.confirmarContrasenaFocus
  });

  @override
  __RegistroFormState createState() => __RegistroFormState();
}

class __RegistroFormState extends State<_RegistroForm> {

  double screenSizeHeight;
  double screenSizeWidth;

  RegistroBloc _regsitroBloc;

  /// controllers
  // TextEditingController nroCelularController;
  TextEditingController nombreController;
  TextEditingController nroDocumentoController;
  TextEditingController apellidosController;
  TextEditingController emailController;
  TextEditingController contrasenaController;
  TextEditingController confirmarContrasenaController;

  

  /// Metodo de ciclo de vida
  @override
  void initState() { 
    // nroCelularController = TextEditingController(text: '');
    nombreController = TextEditingController(text: '');
    apellidosController = TextEditingController(text: '');
    emailController = TextEditingController(text: '');
    nroDocumentoController = TextEditingController(text: '');
    contrasenaController = TextEditingController(text: '');
    confirmarContrasenaController = TextEditingController(text: '');
    
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _regsitroBloc ??= BlocProvider.of<RegistroBloc>(context);
    super.didChangeDependencies();
  }

  /// Metodo de ciclo de vida
  @override
  void dispose() { 
    // nroCelularController?.dispose();
    nombreController?.dispose();
    nroDocumentoController?.dispose();
    super.dispose();
  }


  ///
  /// Caja de texto para ingresar nombre
  ///
  Widget _nameSection(){
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: screenSizeHeight * 0.016 ), // vertical: 10.0
            child: Text(
              'Tus nombres',
              style: TextStyle(
                fontSize: 15.0,
                color: primaryColor,
                fontWeight: FontWeight.w700
              )),
          ),
          // SizedBox(height: 10.0),
          InputLoginWidget(
            focusNode: widget.nombreFocus,
            textEditingController: nombreController,
            inputType: TextInputType.name,
            obscureText: false,
            placeholderText: 'Ingresa su nombre',
            onChange: _regsitroBloc.onChangedNombre,
          )
      ],
    );
  }

  ///
  /// Caja de texto para ingresar apellidos
  ///
  Widget _apellidosSection(){
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: screenSizeHeight * 0.016 ), // vertical: 10.0
            child: Text(
              'Tus apellidos',
              style: TextStyle(
                fontSize: 15.0,
                color: primaryColor,
                fontWeight: FontWeight.w700
              )),
          ),
          InputLoginWidget(
            focusNode: widget.apellidosFocus,
            textEditingController: apellidosController,
            inputType: TextInputType.name,
            obscureText: false,
            placeholderText: 'Ingresa su apellido',
            onChange: _regsitroBloc.onChangedApellido
          )
      ],
    );
  }
  ///
  /// Caja de texto para correo
  ///
  Widget _emailSection(){
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: screenSizeHeight * 0.016 ), // vertical: 10.0
            child: Text(
              'Correo electrónico',
              style: TextStyle(
                fontSize: 15.0,
                color: primaryColor,
                fontWeight: FontWeight.w700
              )),
          ),
          InputLoginWidget(
            focusNode: widget.emailFocus,
            textEditingController: emailController,
            inputType: TextInputType.emailAddress,
            obscureText: false,
            placeholderText: 'Ingresa su correo',
            onChange: _regsitroBloc.onChangedEmail
          )
      ],
    );
  }

  ///
  /// Caja de texto para ingresar neo Documento
  ///
  Widget _nroDocumentoSection(){
    return _titleWithInputFormWithLeading(
      title: 'Nº de Documento',
      placeholderText: 'Ingrese nro de documento',
      inputType: TextInputType.number,
      documentType: 'C.C.'
    );
  }


  /// contruye el titulo del input con el input de nro de documento
  Widget _titleWithInputFormWithLeading({
    String title,
    TextInputType inputType,
    String placeholderText,
    String documentType
  }){
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: screenSizeHeight * 0.016 ), // vertical: 10.0
          child: Text(title, style: TextStyle(color: primaryColor, fontSize: 15.0,fontWeight: FontWeight.w700)),
        ),
        InputLeadingLoginWidget(
          textEditingController: nroDocumentoController,
          focusNode: widget.nroDocumentoFocus,
          obscureText: false,
          inputType: inputType,
          placeholderText: placeholderText,
          documentType: documentType,
          onChange: _regsitroBloc.onChangedNroDocumento
        )
      ],
    );
  }

  ///
  /// Caja de texto para ingresar contraña
  ///
  Widget _contrasenaSection(){
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: screenSizeHeight * 0.016 ), // vertical: 10.0
            child: Text(
              'Tu contraseña',
              style: TextStyle(
                fontSize: 15.0,
                color: primaryColor,
                fontWeight: FontWeight.w700
              )),
          ),
          InputLoginWidget(
            focusNode: widget.contrasenaFocus,
            textEditingController: contrasenaController,
            inputType: TextInputType.text,
            obscureText: true,
            placeholderText: 'Ingresa contraseña',
            onChange: _regsitroBloc.onChangedContrasena
          )
      ],
    );
  }
  ///
  /// Caja de texto para ingresar contraña
  ///
  Widget _confirmarContrasenaSection(){
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: screenSizeHeight * 0.016 ), // vertical: 10.0
            child: Text(
              'Confirma contraseña',
              style: TextStyle(
                fontSize: 15.0,
                color: primaryColor,
                fontWeight: FontWeight.w700
              )),
          ),
          InputLoginWidget(
            focusNode: widget.confirmarContrasenaFocus,
            textEditingController: confirmarContrasenaController,
            inputType: TextInputType.text,
            obscureText: true,
            placeholderText: 'Repetir contraseña',
            onChange: _regsitroBloc.onChangedRepetirContrasena
          )
      ],
    );
  }


  ///
  /// Boton de siguiente
  ///
  Widget _accederButton(){
    final _registroBloc =BlocProvider.of<RegistroBloc>(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenSizeHeight  * 0.0506 ), //vertical: 30.0
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          child: Container( 
            padding: EdgeInsets.symmetric( vertical: screenSizeHeight * 0.016 ), // vertical: 10.0
            child: StreamBuilder<bool>(
              stream: _registroBloc.isLoading$,
              builder: (context, snapshot) {
                final isLoading = snapshot.data ?? false;
                if( !isLoading ){
                  return Text(
                    'Siguiente',
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
          onPressed: () => _submit(_registroBloc)
        ),
      ),
    );
  }

  _submit(RegistroBloc registroBloc){
    
    final nombre = registroBloc.nombre$.value;
    final apellido = registroBloc.apellido$.value;
    final email = registroBloc.email$.value;
    final nroDocumento = registroBloc.nroDocumento$.value;
    final contrasena = registroBloc.contrasena$.value;
    final repetirContrasena = registroBloc.repetirContrasena$.value;

    if(
      (nombre!=null && nombre!='') &&
      (apellido!=null && apellido!='') &&
      (email!=null && email!='') &&
      (nroDocumento!=null && nroDocumento!='') &&
      (contrasena!=null && contrasena!='') &&
      (repetirContrasena!=null && repetirContrasena!='')
    ){
      registroBloc.onSubmit();
    }else{
      respuestaDialog(
        context: context, 
        message: 'Porfavor complete todo los campos del formulario', 
        title: 'Campos incompletos', 
        icon: Icon(Icons.warning, color: electricVioletColor, size: 30.0)
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    screenSizeHeight = MediaQuery.of(context).size.height;
    screenSizeWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: 0.0,left: 40.0, right: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,
        children: [
          _nameSection(),
          _apellidosSection(),
          _emailSection(),
          _nroDocumentoSection(),
          _contrasenaSection(),
          _confirmarContrasenaSection(),
          // _phoneSection(),
          _accederButton()
        ],
      ),
    );
  }
}