import 'dart:async';
import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pidos/src/data/constanst.dart';
import 'package:pidos/src/domain/models/usuario.dart';
import 'package:pidos/src/presentation/blocs/login/registro_bloc.dart';
import 'package:pidos/src/presentation/states/registro_message.dart';
import 'package:pidos/src/presentation/widgets/circle_color.dart';
import 'package:pidos/src/presentation/widgets/login/input_leading_login_widget.dart';
import 'package:pidos/src/presentation/widgets/login/input_login_widget.dart';
import 'package:pidos/src/presentation/widgets/login/terminos_politicas_dialog.dart';
import 'package:pidos/src/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';


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

  FocusNode razonSocialFocus;
  FocusNode nitFocus;
  FocusNode correoEmpresaFocus;
  FocusNode contrasenaEmpresaFocus;
  FocusNode repetirContrasenaEmpresaFocus;
  FocusNode codigoDeVendedorFocus;

  @override
  void initState() {
    nombreFocus = FocusNode();
    nroDocumentoFocus = FocusNode();
    apellidosFocus = FocusNode();
    emailFocus = FocusNode();
    contrasenaFocus = FocusNode();
    confirmarContrasenaFocus = FocusNode();

    //Empresa
    razonSocialFocus = FocusNode();
    nitFocus = FocusNode();
    correoEmpresaFocus = FocusNode();
    contrasenaEmpresaFocus = FocusNode();
    repetirContrasenaEmpresaFocus = FocusNode();
    codigoDeVendedorFocus = FocusNode();
    super.initState();
  }


  @override
  void dispose() {
    registroMessage$?.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    registroMessage$ ??= BlocProvider.of<RegistroBloc>(context).registroMessage$.listen((message) async {
      if( message is RegistroSuccessMessage ){
        final user = message.usuario;
        Navigator.of(context).pushNamed('/enviar_codigo',arguments: user);
      }
      if( message is RegistroEmpresaSuccessMessage ){
        mostrarSnackBar('Registro exitoso!');
        await Future.delayed(Duration(milliseconds: 1000));
        Navigator.of(context).pop();
      }
      if( message is RegistroErrorMessage ){
        mostrarSnackBar(message.message);
      }
      if( message is RegistroEmpresaErrorMessage ){
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

    razonSocialFocus.unfocus();
    nitFocus.unfocus();
    correoEmpresaFocus.unfocus();
    contrasenaEmpresaFocus.unfocus();
    repetirContrasenaEmpresaFocus.unfocus();
    codigoDeVendedorFocus.unfocus();
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

  Widget _buildTipoRegistro( TipoRegistro tipoRegistro ){
    final _registroBloc = BlocProvider.of<RegistroBloc>(context);
    return StreamBuilder<TipoRegistro>(
      stream: _registroBloc.tipoRegistro$,
      initialData: _registroBloc.tipoRegistro$.value,
      builder: (context, snapshot){
        final tRegistro = snapshot.data;
        bool active = false;
        if( tRegistro == tipoRegistro ){
          active = true;
        }else{
          active = false;
        }
        return _radioButtonWithLabel(tipoRegistroName[tipoRegistro], active,tipoRegistro);
      },
    );
  }

  // RADIO BUTTONS with labe
  Widget _radioButtonWithLabel(String title, bool value, TipoRegistro tipoRegistro ){
    final _registroBloc = BlocProvider.of<RegistroBloc>(context);
    return GestureDetector(
      onTap: () async {
        if( _registroBloc.tipoRegistro$.value.toString() != tipoRegistro.toString() ){
          _unfocus();
          _registroBloc.cleanInputsText();
        }
        _registroBloc.onChangedTipoRegistro(tipoRegistro);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _radioButton(value),
          SizedBox(width: 5.0),
          Text(title, style: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  // RADIO BUTTONS
  Widget _radioButton(bool active){
    return CircleWidget(
      width: 20.0, //width: 40.0,
      height: 20.0, //height: 40.0
      color: Colors.transparent,
      borderColor: primaryColor,
      borderWidth: 2.5,
      widget: Center(
        child: CircleWidget(
          width: 10.0, //width: 15.0, 
          height: 10.0,  //height: 15.0,  
          color: (active) ?  primaryColor : Colors.transparent
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    screenSizeHeight = MediaQuery.of(context).size.height;
    screenSizeWidth = MediaQuery.of(context).size.width;
    final _registroBloc = BlocProvider.of<RegistroBloc>(context);
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [
          _backgroundImage(),
          GestureDetector(
            onTap: _unfocus,
            child: Container(
              color: Colors.transparent,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _logoImage(),
                    _creaTuCuentSection(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildTipoRegistro(TipoRegistro.persona),
                          SizedBox(width: 20.0),
                          _buildTipoRegistro(TipoRegistro.empresa)
                        ],
                      ),
                    ),
                    StreamBuilder<TipoRegistro>(
                      stream: _registroBloc.tipoRegistro$,
                      initialData: _registroBloc.tipoRegistro$.value,
                      builder: (context, snapshot) {
                        final tipoRegistro = snapshot.data;
                        if( tipoRegistro == TipoRegistro.persona) {
                          return _RegistroForm(
                            nombreFocus: nombreFocus,
                            nroDocumentoFocus: nroDocumentoFocus,
                            apellidosFocus: apellidosFocus,
                            emailFocus: emailFocus,
                            contrasenaFocus: contrasenaFocus,
                            confirmarContrasenaFocus: confirmarContrasenaFocus,
                          );  
                        }else{
                          return _RegistroEmpresaForm(
                            razonSocialFocus: razonSocialFocus,
                            nitFocus: nitFocus,
                            correoEmpresaFocus: correoEmpresaFocus,
                            contrasenaEmpresaFocus: contrasenaEmpresaFocus,
                            repetirContrasenaEmpresaFocus: repetirContrasenaEmpresaFocus,
                            codigoDeVendedorFocus: codigoDeVendedorFocus,
                          );
                        }
                      }
                    ),
                  ],
                )
              ),
            ),
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

class __RegistroFormState extends State<_RegistroForm> with TickerProviderStateMixin {
  //AnimationController
  AnimationController nombreAnimationController;
  AnimationController apellidoAnimationController;
  AnimationController correoAnimationController;
  AnimationController nroDocumentoAnimationController;
  AnimationController contrasenaAnimationController;
  AnimationController confirmarContrasenaAnimationController;

  //AnimationController
  AnimationController nombreAnimationColorAnimationController;
  AnimationController apellidoAnimationColorAnimationController;
  AnimationController correoAnimationColorAnimationController;
  AnimationController nroDocumentoAnimationColorAnimationController;
  AnimationController contrasenaAnimationColorAnimationController;
  AnimationController confirmarContrasenaColorAnimationController;
  AnimationController terminosYcondicionesColorAnimationController;
  Animation _nombreAnimationColorTween;
  Animation _apellidoAnimationColorTween;
  Animation _correoAnimationColorTween;
  Animation _nroDocumentoAnimationColorTween;
  Animation _contrasenaAnimationColorTween;
  Animation _confirmarContrasenaAnimationColorTween;
  Animation _terminosYcondicionesAnimationColorTween;



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

  StreamSubscription cleanControllers$;

  bool isIos = false;

  bool initialAnimated = false;

  bool isValidConfirmaCotrasena = true;

  /// Metodo de ciclo de vida
  @override
  void initState() { 
    //INIT ANIMATIONS
    nombreAnimationColorAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    apellidoAnimationColorAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    correoAnimationColorAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    nroDocumentoAnimationColorAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    contrasenaAnimationColorAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    confirmarContrasenaColorAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    terminosYcondicionesColorAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _nombreAnimationColorTween = ColorTween(begin: Colors.transparent, end: Colors.red).animate(nombreAnimationColorAnimationController);
    _apellidoAnimationColorTween = ColorTween(begin: Colors.transparent, end: Colors.red).animate(apellidoAnimationColorAnimationController);
    _correoAnimationColorTween = ColorTween(begin: Colors.transparent, end: Colors.red).animate(correoAnimationColorAnimationController);
    _nroDocumentoAnimationColorTween = ColorTween(begin: Colors.transparent, end: Colors.red).animate(nroDocumentoAnimationColorAnimationController);
    _contrasenaAnimationColorTween = ColorTween(begin: Colors.transparent, end: Colors.red).animate(contrasenaAnimationColorAnimationController);
    _confirmarContrasenaAnimationColorTween = ColorTween(begin: Colors.transparent, end: Colors.red).animate(confirmarContrasenaColorAnimationController);
    _terminosYcondicionesAnimationColorTween = ColorTween(begin: Colors.transparent, end: Colors.red).animate(terminosYcondicionesColorAnimationController);


    if( Platform.isIOS ) isIos = true;
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
    cleanControllers$ ??= _regsitroBloc.cleanControllers$.listen((_) {
      cleanControllersPersona();
    });
    super.didChangeDependencies();
  }

  /// Metodo de ciclo de vida
  @override
  void dispose() { 
    nombreController?.dispose();
    apellidosController?.dispose();
    emailController?.dispose();
    nroDocumentoController?.dispose();
    contrasenaController?.dispose();
    confirmarContrasenaController?.dispose();
    //DISPOSE ANIMATION
    nombreAnimationColorAnimationController?.dispose();
    apellidoAnimationColorAnimationController?.dispose();
    correoAnimationColorAnimationController?.dispose();
    nroDocumentoAnimationColorAnimationController?.dispose();
    contrasenaAnimationColorAnimationController?.dispose();
    confirmarContrasenaColorAnimationController?.dispose();
    terminosYcondicionesColorAnimationController?.dispose();


    cleanControllers$.cancel();
    super.dispose();
  }


  void cleanControllersPersona(){ 
    nombreController.text = '';
    apellidosController.text = '';
    emailController.text = '';
    nroDocumentoController.text = '';
    contrasenaController.text = '';
    confirmarContrasenaController.text = '';
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
              'Tus nombres${isIos?'*':''}',
              style: TextStyle(
                fontSize: 15.0,
                color: primaryColor,
                fontWeight: FontWeight.w700
              )),
          ),
          // SizedBox(height: 10.0),
          ElasticInRight(
            manualTrigger: true,
            duration: const Duration(milliseconds: 800),
            from: 5.0,
            controller: (controller) => nombreAnimationController = controller,
            child: AnimatedBuilder(
              animation: _nombreAnimationColorTween,
              builder: (context, child) {
                return StreamBuilder<bool>(
                  stream: _regsitroBloc.isValidNombre$,
                  initialData: true,
                  builder: (context, snapshot) {
                    bool isValidNombre = snapshot.data;
                    return Column(
                      children: [
                        InputLoginWidget(
                          focusNode: widget.nombreFocus,
                          textEditingController: nombreController,
                          inputType: TextInputType.name,
                          obscureText: false,
                          placeholderText: 'Ingresa su nombre',
                          onChange: _regsitroBloc.onChangedNombre,
                          borderColor: _nombreAnimationColorTween?.value,
                        ),
                        if(isValidNombre!=null && !isValidNombre)
                          Text('Ingrese un nombre valido', style: TextStyle(color: Colors.red, fontSize: 12.0))
                      ],
                    );
                  }
                );
              }
            ),
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
              'Tus apellidos${isIos?'*':''}',
              style: TextStyle(
                fontSize: 15.0,
                color: primaryColor,
                fontWeight: FontWeight.w700
              )),
          ),
          ElasticInRight(
            manualTrigger: true, 
            duration: const Duration(milliseconds: 800),
            from: 5.0,
            controller: (controller) => apellidoAnimationController = controller,
            child: AnimatedBuilder(
              animation: _apellidoAnimationColorTween,
              builder: (context, child) {
                return StreamBuilder<bool>(
                  stream: _regsitroBloc.isValidApellido$,
                  initialData: true,
                  builder: (context, snapshot) {
                    final isValid = snapshot.data;
                    return Column(
                      children: [
                        InputLoginWidget(
                          focusNode: widget.apellidosFocus,
                          textEditingController: apellidosController,
                          inputType: TextInputType.name,
                          obscureText: false,
                          placeholderText: 'Ingresa su apellido',
                          onChange: _regsitroBloc.onChangedApellido,
                          borderColor: _apellidoAnimationColorTween?.value,
                        ),
                        if(isValid!=null && !isValid)
                          Text('Ingrese un apellido valido', style: TextStyle(color: Colors.red, fontSize: 12.0))
                      ],
                    );
                  }
                );
              }
            ),
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
              'Correo electrónico${isIos?'*':''}',
              style: TextStyle(
                fontSize: 15.0,
                color: primaryColor,
                fontWeight: FontWeight.w700
              )),
          ),
          ElasticInRight(
            manualTrigger: true, 
            duration: const Duration(milliseconds: 800),
            from: 5.0,
            controller: (controller) => correoAnimationController = controller,
            child: AnimatedBuilder(
              animation: _correoAnimationColorTween,
              builder: (context, child) {
                return StreamBuilder<bool>(
                  stream: _regsitroBloc.isValidEmail$,
                  initialData: true,
                  builder: (context, snapshot) {
                    final isValid = snapshot.data;
                    return Column(
                      children: [
                        InputLoginWidget(
                          focusNode: widget.emailFocus,
                          textEditingController: emailController,
                          inputType: TextInputType.emailAddress,
                          obscureText: false,
                          placeholderText: 'Ingresa su correo',
                          onChange: _regsitroBloc.onChangedEmail,
                          borderColor: _correoAnimationColorTween?.value,
                        ),
                        if(isValid!=null && !isValid)
                          Text('Ingrese un email valido', style: TextStyle(color: Colors.red, fontSize: 12.0))
                      ],
                    );
                  }
                );
              }
            ),
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
        ElasticInRight(
          manualTrigger: true, 
          duration: const Duration(milliseconds: 800),
          from: 5.0,
          controller: (controller) => nroDocumentoAnimationController = controller,
          child: AnimatedBuilder(
            animation: _nroDocumentoAnimationColorTween,
            builder: (context, child) {
              return StreamBuilder<bool>(
                stream: _regsitroBloc.isValidNroDocumento$,
                initialData: true,
                builder: (context, snapshot) {
                  final isValid = snapshot.data;
                  return Column(
                    children: [
                      Column(
                        children: [
                          InputLeadingLoginWidget(
                            textEditingController: nroDocumentoController,
                            focusNode: widget.nroDocumentoFocus,
                            obscureText: false,
                            inputType: inputType,
                            placeholderText: placeholderText,
                            documentType: documentType,
                            onChange: _regsitroBloc.onChangedNroDocumento,
                            borderColor: _nroDocumentoAnimationColorTween?.value,
                          ),
                          if(isValid!=null && !isValid)
                            Text('Ingrese un nro de documento valido', style: TextStyle(color: Colors.red, fontSize: 12.0))
                        ],
                      ),
                    ],
                  );
                }
              );
            }
          ),
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
              'Tu contraseña${isIos?'*':''}',
              style: TextStyle(
                fontSize: 15.0,
                color: primaryColor,
                fontWeight: FontWeight.w700
              )),
          ),
          ElasticInRight(
            manualTrigger: true, 
            duration: const Duration(milliseconds: 800),
            from: 5.0,
            controller: (controller) => contrasenaAnimationController = controller,
            child: AnimatedBuilder(
              animation: _contrasenaAnimationColorTween,
              builder: (context, child) {
                return StreamBuilder<bool>(
                  stream: _regsitroBloc.isValidContrasena$,
                  initialData: true,
                  builder: (context, snapshot) {
                    final isValid = snapshot.data;
                    return Column(
                      children: [
                        InputLoginWidget(
                          focusNode: widget.contrasenaFocus,
                          textEditingController: contrasenaController,
                          inputType: TextInputType.text,
                          obscureText: true,
                          placeholderText: 'Ingresa contraseña',
                          onChange: _regsitroBloc.onChangedContrasena,
                          borderColor: _contrasenaAnimationColorTween?.value,
                        ),
                        if(isValid!=null && !isValid)
                            Text('Ingrese una contraseña valida', style: TextStyle(color: Colors.red, fontSize: 12.0))
                      ],
                    );
                  }
                );
              }
            ),
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
              'Confirma contraseña${isIos?'*':''}',
              style: TextStyle(
                fontSize: 15.0,
                color: primaryColor,
                fontWeight: FontWeight.w700
              )),
          ),
          ElasticInRight(
            manualTrigger: true, 
            duration: const Duration(milliseconds: 800),
            from: 5.0,
            controller: (controller) => confirmarContrasenaAnimationController = controller,
            child: AnimatedBuilder(
              animation: _confirmarContrasenaAnimationColorTween,
              builder: (context, child) {
                return Column(
                  children: [
                    InputLoginWidget(
                      focusNode: widget.confirmarContrasenaFocus,
                      textEditingController: confirmarContrasenaController,
                      inputType: TextInputType.text,
                      obscureText: true,
                      placeholderText: 'Repetir contraseña',
                      onChange: _onChangedRepetirContrasena,
                      borderColor: _confirmarContrasenaAnimationColorTween?.value,
                    ),
                    if(isValidConfirmaCotrasena!=null && !isValidConfirmaCotrasena)
                      Text('Las contraseñas no coinciden', style: TextStyle(color: Colors.red, fontSize: 12.0))
                  ],
                );
              }
            ),
          )
      ],
    );
  }
  _onChangedRepetirContrasena(String value){
    _regsitroBloc.onChangedRepetirContrasena(value);
    if( value != _regsitroBloc.contrasena$.value ){
      isValidConfirmaCotrasena = false;
    }else{
      isValidConfirmaCotrasena = true;
    }
    setState(() {});
  }

  ///
  /// Terminos y condiciones
  ///
  Widget _aceptarTerminosYcondiciones() {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: AnimatedBuilder(
        animation: _terminosYcondicionesAnimationColorTween,
        builder: (context, snapshot) {
          return Container(
            color: _terminosYcondicionesAnimationColorTween.value,
            child: Row(
              children: [
                StreamBuilder<bool>(
                  stream: _regsitroBloc.terminosYcondiciones$,
                  initialData: _regsitroBloc.terminosYcondiciones$.value,
                  builder: (context, snapshot) {
                    final active = snapshot.data ?? false;
                    return Checkbox(
                      activeColor: primaryColor,
                      checkColor: Colors.white,
                      value: active,
                      onChanged: _regsitroBloc.onChangedTerminosYcondiciones
                    );
                  }
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w300
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'Al crear una cuenta aceptas nuestros '),
                        TextSpan(
                          text: 'términos y condiciones, políticas de privacidad y política de datos', 
                          style: new TextStyle(fontWeight: FontWeight.w500,color: electricVioletColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = (Platform.isIOS)
                              ? () => _mostrarCupertinoDialogIos()
                              : () => showAnimatedDialog()
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      ),
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
          // onPressed: () => _testAnimation()
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
    final terminosYcondiciones = registroBloc.terminosYcondiciones$.value;
    RegExp regExp = new RegExp(pattern);
    
    bool isValidForm = true;
    if( nombre==null || nombre.length<2 ){
      nombreAnimationController.forward(from: 0.5);
      nombreAnimationColorAnimationController.reverse(from: 1.0);
      isValidForm = false;
    }
    if( apellido==null || apellido.length<2 ){
      apellidoAnimationController.forward(from: 0.5);
      apellidoAnimationColorAnimationController.reverse(from: 1.0);
      isValidForm = false;
    }
    if( email==null || !(regExp.hasMatch(email) && email.length >=1) ){
      correoAnimationController.forward(from: 0.5);
      correoAnimationColorAnimationController.reverse(from: 1.0);
      isValidForm = false;
    }
    if( !Platform.isIOS ){
      if( nroDocumento==null || nroDocumento=='' || nroDocumento.length>10 ){
        nroDocumentoAnimationController.forward(from: 0.5);
        nroDocumentoAnimationColorAnimationController.reverse(from: 1.0);
        isValidForm = false;
      }
    }
    if( contrasena==null || contrasena=='' ){
      contrasenaAnimationController.forward(from: 0.5);
      contrasenaAnimationColorAnimationController.reverse(from: 1.0);
      isValidForm = false;
    }
    if( repetirContrasena==null || repetirContrasena=='' || repetirContrasena!=contrasena ){
      confirmarContrasenaAnimationController.forward(from: 0.5);
      confirmarContrasenaColorAnimationController.reverse(from: 1.0);
      isValidForm = false;
    }
    if( terminosYcondiciones==null || !terminosYcondiciones ){
      terminosYcondicionesColorAnimationController.reverse(from: 1.0);
      isValidForm = false;
    }
    if( isValidForm ){
      registroBloc.onSubmit();
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
          _aceptarTerminosYcondiciones(),
          _accederButton()
        ],
      ),
    );
  }

  void _mostrarCupertinoDialogIos() async {
    final action = await showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Terminos y políticas uso'),
          content: Text('Revisa o descarga nuestros terminos y políticas de uso de Pidos'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Términos y condiciones'),
              onPressed: () {
                Navigator.of(context).pop( TerminosYPoliticasDeUso.terminosYcondiones );
              },
            ),
            CupertinoDialogAction(
              child: Text('Políticas de privacidad'),
              onPressed: () {
                Navigator.of(context).pop( TerminosYPoliticasDeUso.politcasDePrivacidad );
              },
            ),
            CupertinoDialogAction(
              child: Text('Política de datos'),
              onPressed: () {
                Navigator.of(context).pop( TerminosYPoliticasDeUso.politicaDeDatos );
              },
            ),
          ],
        );
      },
    );

    if( action!=null ){
      String url = '';
      switch( action ) {
        case TerminosYPoliticasDeUso.terminosYcondiones:
          url = 'https://pidoscolombia.com/terminos-condiciones';
          break;
        case TerminosYPoliticasDeUso.politcasDePrivacidad:
          url = 'https://pidoscolombia.com/politica-privacidad';
          break;
        case TerminosYPoliticasDeUso.politicaDeDatos:
          url = 'https://pidoscolombia.com/politica-datos';
          break;
      }
      _launchURL(url);
    }

  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  showAnimatedDialog() async {
    final action = await showDialog(
      context: context,
      builder: (_) => TerminosYPoliticasDialog(),
    );
    if( action!=null ){
      String url = '';
      switch( action ) {
        case TerminosYPoliticasDeUso.terminosYcondiones:
          url = 'https://pidoscolombia.com/terminos-condiciones';
          break;
        case TerminosYPoliticasDeUso.politcasDePrivacidad:
          url = 'https://pidoscolombia.com/politica-privacidad';
          break;
        case TerminosYPoliticasDeUso.politicaDeDatos:
          url = 'https://pidoscolombia.com/politica-datos';
          break;
      }
      _launchURL(url);
    }
  }


}



// _RegistroEmpresaForm

class _RegistroEmpresaForm extends StatefulWidget {

  final FocusNode razonSocialFocus;
  final FocusNode nitFocus;
  final FocusNode correoEmpresaFocus;
  final FocusNode contrasenaEmpresaFocus;
  final FocusNode repetirContrasenaEmpresaFocus;
  final FocusNode codigoDeVendedorFocus;

  const _RegistroEmpresaForm({
    this.razonSocialFocus, 
    this.nitFocus, 
    this.correoEmpresaFocus, 
    this.contrasenaEmpresaFocus,
    this.repetirContrasenaEmpresaFocus,
    this.codigoDeVendedorFocus
  });

  @override
  __RegistroEmpresaFormState createState() => __RegistroEmpresaFormState();
}

class __RegistroEmpresaFormState extends State<_RegistroEmpresaForm> with TickerProviderStateMixin {

  //AnimationControllers
  AnimationController razonSocialAnimationController;
  AnimationController nitAnimationController;
  AnimationController correoEmpresaAnimationController;
  AnimationController contrasenaEmpresaAnimationController;
  AnimationController repetirContrasenaAnimationController;
  AnimationController codigoDeVendedorAnimationController;
  AnimationController rutFileAnimationController;
  AnimationController camaraDeComercioFileAnimationController;
  AnimationController cedulaFileAnimationController;
  AnimationController logoFileAnimationController;

  AnimationController razonSocialColorAnimationController;
  AnimationController nitColorAnimationController;
  AnimationController correoEmpresaColorAnimationController;
  AnimationController contrasenaEmpresaColorAnimationController;
  AnimationController repetirContrasenaColorAnimationController;
  AnimationController codigoDeVendedorColorAnimationController;
  AnimationController rutFileColorAnimationController;
  AnimationController camaraDeComercioFileColorAnimationController;
  AnimationController cedulaFileColorAnimationController;
  AnimationController logoFileColorAnimationController;
  AnimationController terminosYcondicionesEmpresaColorAnimationController;
  Animation _razonSocialAnimationColorTween;
  Animation _nitAnimationColorTween;
  Animation _correoEmpresaAnimationColorTween;
  Animation _contrasenaEmpresaAnimationColorTween;
  Animation _repetirContrasenaAnimationColorTween;
  Animation _codigoDeVendedorAnimationColorTween;
  Animation _rutFileAnimationColorTween;
  Animation _camaraDeComercioFileAnimationColorTween;
  Animation _cedulaFileAnimationColorTween;
  Animation _logoFileAnimationColorTween;
  Animation _terminosYcondicionesEmpresaAnimationColorTween;

  


  double screenSizeHeight;
  double screenSizeWidth;

  RegistroBloc _regsitroBloc;

  TextEditingController razonSocialController;
  TextEditingController nitController;
  TextEditingController correoEmpresaController;
  TextEditingController contrasenaEmpresaController;
  TextEditingController repetirContrasenaController;
  TextEditingController codigoDeVendedorController;

  File rutFile;
  File camaraDeComercioFile;
  File cedulaFile;
  File logoFile;


  String rutFileName = '';
  String camaraDeComercioFileName = '';
  String cedulaFileName = '';
  String logoFileName = '';

  bool isValidConfirmaCotrasenaEmpresa = true;

  @override
  void initState() {
    //Animations
    razonSocialColorAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    nitColorAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    correoEmpresaColorAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    contrasenaEmpresaColorAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    repetirContrasenaColorAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    codigoDeVendedorColorAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    rutFileColorAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    camaraDeComercioFileColorAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    cedulaFileColorAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    logoFileColorAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    terminosYcondicionesEmpresaColorAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _razonSocialAnimationColorTween = ColorTween(begin: Colors.transparent, end: Colors.red).animate(razonSocialColorAnimationController);
    _nitAnimationColorTween = ColorTween(begin: Colors.transparent, end: Colors.red).animate(nitColorAnimationController);
    _correoEmpresaAnimationColorTween = ColorTween(begin: Colors.transparent, end: Colors.red).animate(correoEmpresaColorAnimationController);
    _contrasenaEmpresaAnimationColorTween = ColorTween(begin: Colors.transparent, end: Colors.red).animate(contrasenaEmpresaColorAnimationController);
    _repetirContrasenaAnimationColorTween = ColorTween(begin: Colors.transparent, end: Colors.red).animate(repetirContrasenaColorAnimationController);
    _codigoDeVendedorAnimationColorTween = ColorTween(begin: Colors.transparent, end: Colors.red).animate(codigoDeVendedorColorAnimationController);
    _rutFileAnimationColorTween = ColorTween(begin: Colors.transparent, end: Colors.red).animate(rutFileColorAnimationController);
    _camaraDeComercioFileAnimationColorTween = ColorTween(begin: Colors.transparent, end: Colors.red).animate(camaraDeComercioFileColorAnimationController);
    _cedulaFileAnimationColorTween = ColorTween(begin: Colors.transparent, end: Colors.red).animate(cedulaFileColorAnimationController);
    _logoFileAnimationColorTween = ColorTween(begin: primaryColor, end: Colors.red).animate(logoFileColorAnimationController);
    _terminosYcondicionesEmpresaAnimationColorTween = ColorTween(begin: Colors.transparent, end: Colors.red).animate(terminosYcondicionesEmpresaColorAnimationController);


    razonSocialController = TextEditingController(text: '');
    nitController = TextEditingController(text: '');
    correoEmpresaController = TextEditingController(text: '');
    contrasenaEmpresaController = TextEditingController(text: '');
    repetirContrasenaController = TextEditingController(text: '');
    codigoDeVendedorController = TextEditingController(text: '');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _regsitroBloc ??= BlocProvider.of<RegistroBloc>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() { 
    razonSocialController.dispose();
    nitController.dispose();
    correoEmpresaController.dispose();
    contrasenaEmpresaController.dispose();
    repetirContrasenaController.dispose();

    razonSocialColorAnimationController?.dispose();
    nitColorAnimationController?.dispose();
    correoEmpresaColorAnimationController?.dispose();
    contrasenaEmpresaColorAnimationController?.dispose();
    repetirContrasenaColorAnimationController?.dispose();
    codigoDeVendedorColorAnimationController?.dispose();
    rutFileColorAnimationController?.dispose();
    camaraDeComercioFileColorAnimationController?.dispose();
    cedulaFileColorAnimationController?.dispose();
    logoFileColorAnimationController?.dispose();
    terminosYcondicionesEmpresaColorAnimationController?.dispose();
    super.dispose();
  }




  ///
  /// Caja de texto para ingresar Razont Social
  ///
  Widget _razonSocialSection(){
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: screenSizeHeight * 0.016 ), // vertical: 10.0
            child: Text(
              'Razón social',
              style: TextStyle(
                fontSize: 15.0,
                color: primaryColor,
                fontWeight: FontWeight.w700
              )),
          ),
          // SizedBox(height: 10.0),
          ElasticInRight(
            manualTrigger: true, 
            duration: const Duration(milliseconds: 800),
            from: 5.0,
            controller: (controller) => razonSocialAnimationController = controller,
            child: AnimatedBuilder(
              animation: _razonSocialAnimationColorTween,
              builder: (context, child) {
                return StreamBuilder<bool>(
                  stream: _regsitroBloc.isValidRazonSocial$,
                  initialData: true,
                  builder: (context, snapshot) {
                    final isValid = snapshot.data;
                    return Column(
                      children: [
                        InputLoginWidget(
                          focusNode: widget.razonSocialFocus,
                          textEditingController: razonSocialController,
                          inputType: TextInputType.name,
                          obscureText: false,
                          placeholderText: 'Ingrese razón social',
                          onChange: _regsitroBloc.onChangedRazonSocial,
                          borderColor: _razonSocialAnimationColorTween?.value,
                        ),
                        if(isValid!=null && !isValid)
                            Text('Ingrese un nombre valido', style: TextStyle(color: Colors.red, fontSize: 12.0))
                      ],
                    );
                  }
                );
              }
            ),
          )
      ],
    );
  }

  ///
  /// Caja de texto para ingresar NIT
  ///
  Widget _nitSection(){
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: screenSizeHeight * 0.016 ), // vertical: 10.0
            child: Text(
              'NIT',
              style: TextStyle(
                fontSize: 15.0,
                color: primaryColor,
                fontWeight: FontWeight.w700
              )),
          ),
          // SizedBox(height: 10.0),
          ElasticInRight(
            manualTrigger: true, 
            duration: const Duration(milliseconds: 800),
            from: 5.0,
            controller: (controller) => nitAnimationController = controller,
            child: AnimatedBuilder(
              animation: _nitAnimationColorTween,
              builder: (context, child) {
                return StreamBuilder<bool>(
                  stream: _regsitroBloc.isValidNit$,
                  initialData: true,
                  builder: (context, snapshot) {
                    final isValid = snapshot.data;
                    return Column(
                      children: [
                        InputLoginWidget(
                          focusNode: widget.nitFocus,
                          textEditingController: nitController,
                          inputType: TextInputType.number,
                          obscureText: false,
                          placeholderText: 'Ingrese NIT',
                          onChange: _regsitroBloc.onChangedNit,
                          borderColor: _nitAnimationColorTween?.value,
                        ),
                        if(isValid!=null && !isValid)
                            Text('Ingrese un nit valido', style: TextStyle(color: Colors.red, fontSize: 12.0))
                      ],
                    );
                  }
                );
              }
            ),
          )
      ],
    );
  }
  ///
  /// Caja de texto para ingresar correoEmpresa
  ///
  Widget _correoEmpresaSection(){
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: screenSizeHeight * 0.016 ), // vertical: 10.0
            child: Text(
              'Correo empresa',
              style: TextStyle(
                fontSize: 15.0,
                color: primaryColor,
                fontWeight: FontWeight.w700
              )),
          ),
          // SizedBox(height: 10.0),
          ElasticInRight(
            manualTrigger: true, 
            duration: const Duration(milliseconds: 800),
            from: 5.0,
            controller: (controller) => correoEmpresaAnimationController = controller,
            child: AnimatedBuilder(
              animation: _correoEmpresaAnimationColorTween,
              builder: (context, child) {
                return StreamBuilder<bool>(
                  stream: _regsitroBloc.isValidCorreoEmpresa$,
                  initialData: true,
                  builder: (context, snapshot) {
                    final isValid = snapshot.data;
                    return Column(
                      children: [
                        InputLoginWidget(
                          focusNode: widget.correoEmpresaFocus,
                          textEditingController: correoEmpresaController,
                          inputType: TextInputType.emailAddress,
                          obscureText: false,
                          placeholderText: 'Ingrese correo empresa',
                          onChange: _regsitroBloc.onChangedCorreoEmpresa,
                          borderColor: _correoEmpresaAnimationColorTween?.value,
                        ),
                        if(isValid!=null && !isValid)
                            Text('Ingrese un correo valido', style: TextStyle(color: Colors.red, fontSize: 12.0))
                      ],
                    );
                  }
                );
              }
            ),
          )
      ],
    );
  }

  ///
  /// Caja de texto para ingresar contranseña
  ///
  Widget _contrasenaEmpresaSection(){
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: screenSizeHeight * 0.016 ), // vertical: 10.0
            child: Text(
              'Contraseña',
              style: TextStyle(
                fontSize: 15.0,
                color: primaryColor,
                fontWeight: FontWeight.w700
              )),
          ),
          // SizedBox(height: 10.0),
          ElasticInRight(
            manualTrigger: true, 
            duration: const Duration(milliseconds: 800),
            from: 5.0,
            controller: (controller) => contrasenaEmpresaAnimationController = controller,
            child: AnimatedBuilder(
              animation: _contrasenaEmpresaAnimationColorTween,
              builder: (context, child) {
                return StreamBuilder<bool>(
                  stream: _regsitroBloc.isValidContrasenaEmpresa$,
                  initialData: true,
                  builder: (context, snapshot) {
                    final isValid = snapshot.data;
                    return Column(
                      children: [
                        InputLoginWidget(
                          focusNode: widget.contrasenaEmpresaFocus,
                          textEditingController: contrasenaEmpresaController,
                          inputType: TextInputType.text,
                          obscureText: true,
                          placeholderText: 'Ingrese contraseña',
                          onChange: _regsitroBloc.onChangedContrasenaEmpresa,
                          borderColor: _contrasenaEmpresaAnimationColorTween?.value,
                        ),
                        if(isValid!=null && !isValid)
                            Text('Ingrese una contraseña valida', style: TextStyle(color: Colors.red, fontSize: 12.0))
                      ],
                    );
                  }
                );
              }
            ),
          )
          
      ],
    );
  }

  ///
  /// Caja de texto para ingresar contranseña
  ///
  Widget _confirmarContrasenaEmpresaSection(){
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: screenSizeHeight * 0.016 ), // vertical: 10.0
            child: Text(
              'Confirme contraseña',
              style: TextStyle(
                fontSize: 15.0,
                color: primaryColor,
                fontWeight: FontWeight.w700
              )),
          ),
          // SizedBox(height: 10.0),
          ElasticInRight(
            manualTrigger: true, 
            duration: const Duration(milliseconds: 800),
            from: 5.0,
            controller: (controller) => repetirContrasenaAnimationController = controller,
            child: AnimatedBuilder(
              animation: _repetirContrasenaAnimationColorTween,
              builder: (context, child) {
                return Column(
                  children: [
                    InputLoginWidget(
                      focusNode: widget.repetirContrasenaEmpresaFocus,
                      textEditingController: repetirContrasenaController,
                      inputType: TextInputType.text,
                      obscureText: true,
                      placeholderText: 'Confirme contraseña',
                      // onChange: _regsitroBloc.onChangedRepetirContrasenaEmpresa,
                      onChange: _onChangedRepetirContrasenaEmpresa,
                      borderColor: _repetirContrasenaAnimationColorTween?.value,
                    ),
                    if(isValidConfirmaCotrasenaEmpresa!=null && !isValidConfirmaCotrasenaEmpresa)
                        Text('Las contraseñas no coinciden', style: TextStyle(color: Colors.red, fontSize: 12.0))
                  ],
                );
              }
            ),
          )
          
      ],
    );
  }

  _onChangedRepetirContrasenaEmpresa(String value){
    _regsitroBloc.onChangedRepetirContrasenaEmpresa(value);
    if( value != _regsitroBloc.contrasenaEmpresa$.value ){
      isValidConfirmaCotrasenaEmpresa = false;
    }else{
      isValidConfirmaCotrasenaEmpresa = true;
    }
    setState(() {});
  }

  ///
  /// Caja de texto para ingresar codigo de vendedor
  ///
  Widget _codigoDeVendedor(){
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: screenSizeHeight * 0.016 ), // vertical: 10.0
            child: Text(
              'Codigo de vendedor',
              style: TextStyle(
                fontSize: 15.0,
                color: primaryColor,
                fontWeight: FontWeight.w700
              )),
          ),
          // SizedBox(height: 10.0),
          ElasticInRight(
            manualTrigger: true, 
            duration: const Duration(milliseconds: 800),
            from: 5.0,
            controller: (controller) => codigoDeVendedorAnimationController = controller,
            child: AnimatedBuilder(
              animation: _codigoDeVendedorAnimationColorTween,
              builder: (context, child) {
                return StreamBuilder<bool>(
                  stream: _regsitroBloc.isValidCodigoDeVendedor$,
                  initialData: true,
                  builder: (context, snapshot) {
                    final isValid = snapshot.data;
                    return Column(
                      children: [
                        InputLoginWidget(
                          focusNode: widget.codigoDeVendedorFocus,
                          textEditingController: codigoDeVendedorController,
                          inputType: TextInputType.number,
                          obscureText: false,
                          placeholderText: 'Ingrese codigo de vendedor',
                          onChange: _regsitroBloc.onChangedcodigoDeVendedor,
                          borderColor: _codigoDeVendedorAnimationColorTween?.value,
                        ),
                        if(isValid!=null && !isValid)
                            Text('Ingrese una codigo de vendedor valido', style: TextStyle(color: Colors.red, fontSize: 12.0))
                      ],
                    );
                  }
                );
              }
            ),
          )
          
      ],
    );
  }


  ///
  /// Caja de texto para ingresar rut
  ///
  Widget _rutSection(){
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: screenSizeHeight * 0.016 ), // vertical: 10.0
            child: Text(
              'RUT',
              style: TextStyle(
                fontSize: 15.0,
                color: primaryColor,
                fontWeight: FontWeight.w700
              )),
          ),
          // SizedBox(height: 10.0),
          ElasticInRight(
            manualTrigger: true, 
            duration: const Duration(milliseconds: 800),
            from: 5.0,
            controller: (controller) => rutFileAnimationController = controller,
            child: AnimatedBuilder(
              animation: _rutFileAnimationColorTween,
              builder: (context, child) {
                return GestureDetector(
                  onTap: () => _seleccionarDoc('RUT'),
                  child: _textDisabledContainer(
                    rutFileName ?? '', 
                    'Seleccione documento',
                    _rutFileAnimationColorTween?.value
                  )
                );
              }
            ),
          )
      ],
    );
  }
  ///
  /// Caja de texto para ingresar camara de comercio
  ///
  Widget _camaraDeComercioSection(){
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: screenSizeHeight * 0.016 ), // vertical: 10.0
            child: Text(
              'Cámara de Comercio',
              style: TextStyle(
                fontSize: 15.0,
                color: primaryColor,
                fontWeight: FontWeight.w700
              )),
          ),
          // SizedBox(height: 10.0),
          ElasticInRight(
            manualTrigger: true, 
            duration: const Duration(milliseconds: 800),
            from: 5.0,
            controller: (controller) => camaraDeComercioFileAnimationController = controller,
            child: AnimatedBuilder(
              animation: _camaraDeComercioFileAnimationColorTween,
              builder: (context, child) {
                return GestureDetector(
                  onTap: () => _seleccionarDoc('CAMARADECOMERCIO'),
                  child: _textDisabledContainer(
                    camaraDeComercioFileName ?? '', 
                    'Seleccione documento',
                    _camaraDeComercioFileAnimationColorTween?.value
                  )
                );
              }
            ),
          )
      ],
    );
  }
  ///
  /// Caja de texto para ingresar cedula
  ///
  Widget _cedulaSection(){
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: screenSizeHeight * 0.016 ), // vertical: 10.0
            child: Text(
              'Cédula de representante legal',
              style: TextStyle(
                fontSize: 15.0,
                color: primaryColor,
                fontWeight: FontWeight.w700
              )),
          ),
          // SizedBox(height: 10.0),
          ElasticInRight(
            manualTrigger: true, 
            duration: const Duration(milliseconds: 800),
            from: 5.0,
            controller: (controller) => cedulaFileAnimationController = controller,
            child: AnimatedBuilder(
              animation: _cedulaFileAnimationColorTween,
              builder: (context, child) {
                return GestureDetector(
                  onTap: () => _seleccionarDoc('CEDULA'),
                  child: _textDisabledContainer(
                    cedulaFileName ?? '', 
                    'Seleccione documento',
                    _cedulaFileAnimationColorTween?.value
                  )
                );
              }
            ),
          )
      ],
    );
  }

  /// input text disabled
  Widget _textDisabledContainer(String content, String placeHolder, Color borderColor){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: secundaryColor,
        border: Border.all(color: borderColor, width: 2.0 ),
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: (content!=null && content!='')
        ? Text(content, textAlign: TextAlign.center,style: TextStyle(fontSize: 15.0, color: Color(0xFF666666)))
        : Text(placeHolder, textAlign: TextAlign.center,style: TextStyle(fontSize: 15.0, color: Color(0xFF666666).withOpacity(0.6))),
    );
  }

  ///
  /// Caja de texto para ingresar logo
  ///
  Widget _logoSection(){
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: screenSizeHeight * 0.016 ), // vertical: 10.0
            child: Text(
              'Logo',
              style: TextStyle(
                fontSize: 15.0,
                color: primaryColor,
                fontWeight: FontWeight.w700
              )),
          ),
          // SizedBox(height: 10.0),
          ElasticInRight(
            manualTrigger: true, 
            duration: const Duration(milliseconds: 800),
            from: 5.0,
            controller: (controller) => logoFileAnimationController = controller,
            child: Column(
              children: [
                _subirUnaFotoButton(),
                _mostrarFoto()
              ],
            ),
          )
      ],
    );
  }


  Widget _subirUnaFotoButton(){
    return AnimatedBuilder(
      animation: _logoFileAnimationColorTween,
      builder: (context, child) {
        return RaisedButton(
          onPressed: () => _seleccionarLogo(),
          // color: primaryColor,
          color: _logoFileAnimationColorTween?.value,
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Subir una imagen".toUpperCase(),style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w500),textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  Widget _mostrarFoto() {
    return Container(
      color: secundaryColor,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        child: (logoFile?.path!=null)
          ? Image.file(
              File(logoFile.path),
              height: 250.0,
              fit: BoxFit.contain,
            )
          : Image(
              image: AssetImage('assets/img/no-image.png'),
              height: 250.0,
              fit: BoxFit.cover,
            ),
      ),
    );
  }

  ///
  /// Terminos y condiciones
  ///
  Widget _aceptarTerminosYcondiciones() {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: AnimatedBuilder(
        animation: _terminosYcondicionesEmpresaAnimationColorTween,
        builder: (context, child) {
          return Container(
            color: _terminosYcondicionesEmpresaAnimationColorTween?.value,
            child: Row(
              children: [
                StreamBuilder<bool>(
                  stream: _regsitroBloc.terminosYcondicionesEmpresa$,
                  initialData: _regsitroBloc.terminosYcondicionesEmpresa$.value,
                  builder: (context, snapshot) {
                    final active = snapshot.data ?? false;
                    return Checkbox(
                      activeColor: primaryColor,
                      checkColor: Colors.white,
                      value: active,
                      onChanged: _regsitroBloc.onChangedTerminosYcondicionesEmpresa
                    );
                  }
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w300
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'Al crear una cuenta aceptas nuestros '),
                        TextSpan(
                          text: 'términos y condiciones, políticas de privacidad y política de datos', 
                          style: new TextStyle(fontWeight: FontWeight.w500,color: electricVioletColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = (Platform.isIOS)
                              ? () => _mostrarCupertinoDialogIos()
                              : () => showAnimatedDialog()
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      ),
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
                    'Registrarse',
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
            )
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          color: primaryColor,
          elevation: 0.0,
          textColor: Colors.white,
          onPressed: () => _submit(_registroBloc)
          // onPressed: () => showAnimatedDialog()
        ),
      ),
    );
  }


  _submit(RegistroBloc registroBloc){
    
    final razonSocial = registroBloc.razonSocial$.value;
    final nit = registroBloc.nit$.value;
    final correoEmpresa = registroBloc.correoEmpresa$.value;
    final contrasenaEmpresa = registroBloc.contrasenaEmpresa$.value;
    final repetirContrasenaEmpresa = registroBloc.repetirContrasenaEmpresa$.value;
    final codigoDeVendedor = registroBloc.codigoDeVendedor$.value;
    final rut = registroBloc.rut$.value;
    final camaraDeComercio = registroBloc.camaraDeComercio$.value;
    final cedula = registroBloc.cedula$.value;
    final logo = registroBloc.logo$.value;
    final terminosYcondicionesEmpresa = registroBloc.terminosYcondicionesEmpresa$.value;
    RegExp regExp = new RegExp(pattern);
    
    bool isValidForm = true;
    if( razonSocial==null || razonSocial.length<2 ){
      razonSocialAnimationController.forward(from: 0.5);
      razonSocialColorAnimationController.reverse(from: 1.0);
      isValidForm = false;
    }
    if( nit==null || nit=='' || nit.length>13 ){
      nitAnimationController.forward(from: 0.5);
      nitColorAnimationController.reverse(from: 1.0);
      isValidForm = false;
    }
    if( correoEmpresa==null || !(regExp.hasMatch(correoEmpresa) && correoEmpresa.length >=1) ){
      correoEmpresaAnimationController.forward(from: 0.5);
      correoEmpresaColorAnimationController.reverse(from: 1.0);
      isValidForm = false;
    }
    if( contrasenaEmpresa==null || contrasenaEmpresa=='' ){
      contrasenaEmpresaAnimationController.forward(from: 0.5);
      contrasenaEmpresaColorAnimationController.reverse(from: 1.0);
      isValidForm = false;
    }
    if( repetirContrasenaEmpresa==null || repetirContrasenaEmpresa=='' || repetirContrasenaEmpresa!=contrasenaEmpresa ){
      repetirContrasenaAnimationController.forward(from: 0.5);
      repetirContrasenaColorAnimationController.reverse(from: 1.0);
      isValidForm = false;
    }
    if( codigoDeVendedor==null || codigoDeVendedor=='' ){
      codigoDeVendedorAnimationController.forward(from: 0.5);
      codigoDeVendedorColorAnimationController.reverse(from: 1.0);
      isValidForm = false;
    }
    if( rut==null ){
      rutFileAnimationController.forward(from: 0.5);
      rutFileColorAnimationController.reverse(from: 1.0);
      isValidForm = false;
    }
    if( camaraDeComercio==null ){
      camaraDeComercioFileAnimationController.forward(from: 0.5);
      camaraDeComercioFileColorAnimationController.reverse(from: 1.0);
      isValidForm = false;
    }
    if( cedula==null ){
      cedulaFileAnimationController.forward(from: 0.5);
      cedulaFileColorAnimationController.reverse(from: 1.0);
      isValidForm = false;
    }
    if( logo==null ){
      logoFileAnimationController.forward(from: 0.5);
      logoFileColorAnimationController.reverse(from: 1.0);
      isValidForm = false;
    }
    if( terminosYcondicionesEmpresa==null || !terminosYcondicionesEmpresa ){
      terminosYcondicionesEmpresaColorAnimationController.reverse(from: 1.0);
      isValidForm = false;
    }
    if( isValidForm ){
      registroBloc.onSubmit();
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
          _razonSocialSection(),
          _nitSection(),
          _correoEmpresaSection(),
          _contrasenaEmpresaSection(),
          _confirmarContrasenaEmpresaSection(),
          _codigoDeVendedor(),
          _rutSection(),
          _camaraDeComercioSection(),
          _cedulaSection(),
          _logoSection(),
          _aceptarTerminosYcondiciones(),
          _accederButton(),
        ],
      ),
    );
  }

  _showOptionsImagenDocument(){
    return CupertinoActionSheet(
      title: Text('¿Qué tipo de archivo deseas subir?'),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () => Navigator.of(context).pop('IMAGE'),
          child: Text('Imagen'),
        ),
        CupertinoActionSheetAction(
          onPressed: () => Navigator.of(context).pop('PDF'),
          child: Text('PDF'),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.of(context).pop(null),
        child: Text('Cancelar'),
        isDefaultAction: true,
      )
    );
  }

  _seleccionarDoc(String typeDoc) async {
    if( await Permission.storage.request().isGranted ){
      final _registroBloc =BlocProvider.of<RegistroBloc>(context);
      File result;
      if( Platform.isIOS ){
        final fileFormat  = await showCupertinoModalPopup(
          context: context, 
          builder: (context) => _showOptionsImagenDocument()
        );
        if( fileFormat!=null ){
          if( fileFormat == 'IMAGE' ){
            result = await FilePicker.getFile(type: FileType.image);
          }else{
            result = await FilePicker.getFile(
              type: FileType.custom,
              allowedExtensions: ['pdf'],
            );
          }
        }else{
          return;
        }
      }else{
        result = await FilePicker.getFile(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'png', 'pdf'],
        );
      }

      if(result != null) {
        File file = File(result.path);
        switch( typeDoc ) {
          case 'RUT':
            rutFile = File(file.path);
            rutFileName = rutFile.path.split('/').last;
            _registroBloc.onChangedRUT(rutFile);
            break;
          case 'CAMARADECOMERCIO':
            camaraDeComercioFile = File(file.path);
            camaraDeComercioFileName = camaraDeComercioFile.path.split('/').last;
            _registroBloc.onChangedCamaraDeComercio(camaraDeComercioFile);
            break;
          case 'CEDULA':
            cedulaFile = File(file.path);
            cedulaFileName = cedulaFile.path.split('/').last;
            _registroBloc.onChangedCedula(cedulaFile);
            break;
        }
        setState(() {});
      } else {
        // User canceled the picker
      }
    }
  }
  _seleccionarLogo() async {
    if( await Permission.storage.request().isGranted ){
      final _registroBloc =BlocProvider.of<RegistroBloc>(context);
      File result = await FilePicker.getFile(type: FileType.image);

      if(result != null) {
        File file = File(result.path);
        logoFile = File(file.path);
        // logoFileName = rutFile.path.split('/').last;
        _registroBloc.onChangedLogo(logoFile);
        setState(() {});
      } else {
        // User canceled the picker
      }
    }
  }


  void _mostrarCupertinoDialogIos() async {
    final action = await showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Terminos y políticas uso'),
          content: Text('Revisa o descarga nuestros terminos y políticas de uso de Pidos'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Términos y condiciones'),
              onPressed: () {
                Navigator.of(context).pop( TerminosYPoliticasDeUso.terminosYcondiones );
              },
            ),
            CupertinoDialogAction(
              child: Text('Políticas de privacidad'),
              onPressed: () {
                Navigator.of(context).pop( TerminosYPoliticasDeUso.politcasDePrivacidad );
              },
            ),
            CupertinoDialogAction(
              child: Text('Política de datos'),
              onPressed: () {
                Navigator.of(context).pop( TerminosYPoliticasDeUso.politicaDeDatos );
              },
            ),
          ],
        );
      },
    );

    if( action!=null ){
      String url = '';
      switch( action ) {
        case TerminosYPoliticasDeUso.terminosYcondiones:
          url = 'https://pidoscolombia.com/terminos-condiciones';
          break;
        case TerminosYPoliticasDeUso.politcasDePrivacidad:
          url = 'https://pidoscolombia.com/politica-privacidad';
          break;
        case TerminosYPoliticasDeUso.politicaDeDatos:
          url = 'https://pidoscolombia.com/politica-datos';
          break;
      }
      _launchURL(url);
    }

  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  showAnimatedDialog() async {
    final action = await showDialog(
      context: context,
      builder: (_) => TerminosYPoliticasDialog(),
    );
    if( action!=null ){
      String url = '';
      switch( action ) {
        case TerminosYPoliticasDeUso.terminosYcondiones:
          url = 'https://pidoscolombia.com/terminos-condiciones';
          break;
        case TerminosYPoliticasDeUso.politcasDePrivacidad:
          url = 'https://pidoscolombia.com/politica-privacidad';
          break;
        case TerminosYPoliticasDeUso.politicaDeDatos:
          url = 'https://pidoscolombia.com/politica-datos';
          break;
      }
      _launchURL(url);
    }
  }

  
}





