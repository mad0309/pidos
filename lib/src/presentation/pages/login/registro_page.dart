import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pidos/src/domain/models/usuario.dart';
import 'package:pidos/src/presentation/blocs/login/registro_bloc.dart';
import 'package:pidos/src/presentation/states/registro_message.dart';
import 'package:pidos/src/presentation/widgets/circle_color.dart';
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

  StreamSubscription cleanControllers$;

  bool isIos = false;

  /// Metodo de ciclo de vida
  @override
  void initState() { 
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
    // nroCelularController?.dispose();
    nombreController?.dispose();
    nroDocumentoController?.dispose();
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
              'Tus apellidos${isIos?'*':''}',
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
              'Correo electrónico${isIos?'*':''}',
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
              'Tu contraseña${isIos?'*':''}',
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
              'Confirma contraseña${isIos?'*':''}',
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
    if( Platform.isIOS ){
      if(
        (nombre!=null && nombre!='') &&
        (apellido!=null && apellido!='') &&
        (email!=null && email!='') && 
        // (nroDocumento!=null && nroDocumento!='') &&
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
    }else{
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

class __RegistroEmpresaFormState extends State<_RegistroEmpresaForm> {

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

  @override
  void initState() {
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
          InputLoginWidget(
            focusNode: widget.razonSocialFocus,
            textEditingController: razonSocialController,
            inputType: TextInputType.name,
            obscureText: false,
            placeholderText: 'Ingrese razón social',
            onChange: _regsitroBloc.onChangedRazonSocial
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
          InputLoginWidget(
            focusNode: widget.nitFocus,
            textEditingController: nitController,
            inputType: TextInputType.number,
            obscureText: false,
            placeholderText: 'Ingrese NIT',
            onChange: _regsitroBloc.onChangedNit,
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
          InputLoginWidget(
            focusNode: widget.correoEmpresaFocus,
            textEditingController: correoEmpresaController,
            inputType: TextInputType.emailAddress,
            obscureText: false,
            placeholderText: 'Ingrese correo empresa',
            onChange: _regsitroBloc.onChangedCorreoEmpresa,
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
          InputLoginWidget(
            focusNode: widget.contrasenaEmpresaFocus,
            textEditingController: contrasenaEmpresaController,
            inputType: TextInputType.text,
            obscureText: true,
            placeholderText: 'Ingrese contraseña',
            onChange: _regsitroBloc.onChangedContrasenaEmpresa,
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
          InputLoginWidget(
            focusNode: widget.repetirContrasenaEmpresaFocus,
            textEditingController: repetirContrasenaController,
            inputType: TextInputType.text,
            obscureText: true,
            placeholderText: 'Confirme contraseña',
            onChange: _regsitroBloc.onChangedRepetirContrasenaEmpresa,
          )
      ],
    );
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
          InputLoginWidget(
            focusNode: widget.codigoDeVendedorFocus,
            textEditingController: codigoDeVendedorController,
            inputType: TextInputType.number,
            obscureText: false,
            placeholderText: 'Ingrese codigo de vendedor',
            onChange: _regsitroBloc.onChangedcodigoDeVendedor
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
          GestureDetector(
            onTap: () => _seleccionarDoc('RUT'),
            child: _textDisabledContainer(rutFileName ?? '', 'Seleccione documento')
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
          GestureDetector(
            onTap: () => _seleccionarDoc('CAMARADECOMERCIO'),
            child: _textDisabledContainer(camaraDeComercioFileName ?? '', 'Seleccione documento')
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
          GestureDetector(
            onTap: () => _seleccionarDoc('CEDULA'),
            child: _textDisabledContainer(cedulaFileName ?? '', 'Seleccione documento')
          )
      ],
    );
  }

  /// input text disabled
  Widget _textDisabledContainer(String content, String placeHolder){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: secundaryColor,
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
          Column(
            children: [
              _subirUnaFotoButton(),
              _mostrarFoto()
            ],
          )
      ],
    );
  }


  Widget _subirUnaFotoButton(){
    return RaisedButton(
      onPressed: () => _seleccionarLogo(),
      color: primaryColor,
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
          onPressed: () => _registroBloc.onSubmit()
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
          _accederButton(),
        ],
      ),
    );
  }

  _seleccionarDoc(String typeDoc) async {
    if( await Permission.storage.request().isGranted ){
      final _registroBloc =BlocProvider.of<RegistroBloc>(context);
      File result = await FilePicker.getFile(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'pdf'],
      );

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
      File result = await FilePicker.getFile(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png'],
      );

      if(result != null) {
        File file = File(result.path);
        logoFile = File(file.path);
        logoFileName = rutFile.path.split('/').last;
        _registroBloc.onChangedLogo(logoFile);
        setState(() {});
      } else {
        // User canceled the picker
      }
    }
  }

  
}