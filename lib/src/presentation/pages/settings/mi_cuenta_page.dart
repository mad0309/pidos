import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:pidos/src/data/local/preferencias_usuario.dart';
import 'package:pidos/src/domain/models/usuario.dart';
import 'package:pidos/src/presentation/blocs/settings/mi_cuenta_bloc.dart';
import 'package:pidos/src/presentation/widgets/button_submit.dart';
import 'package:pidos/src/presentation/widgets/circle_avatar_name.dart';
import 'package:pidos/src/presentation/widgets/drawer_nav.dart';
import 'package:pidos/src/presentation/widgets/inputs_widgets/input_form.dart';
import 'package:pidos/src/presentation/widgets/inputs_widgets/input_form_leading_icon.dart';
import 'package:pidos/src/presentation/widgets/inputs_widgets/input_form_prefix_icon.dart';
import 'package:pidos/src/utils/colors.dart';


class MiCuentapPage extends StatefulWidget {

  final Usuario usuarioInit;

  const MiCuentapPage({Key key, this.usuarioInit}) : super(key: key);

  @override
  _MiCuentapPageState createState() => _MiCuentapPageState();
}

class _MiCuentapPageState extends State<MiCuentapPage> {

  GlobalKey<ScaffoldState> _scaffoldKey;
  String _perfil = '';
  String _shortName = '';

  TextEditingController nombreController;
  TextEditingController apellidosController;
  TextEditingController nroCelularController;
  TextEditingController emailController;
  TextEditingController nroDocumentoController;
  TextEditingController generoController;
  TextEditingController estadoCivilController;
  TextEditingController contrasenaController;
  TextEditingController confirmarContrasenaController;

  FocusNode nombreFocus;
  FocusNode apellidosFocus;
  FocusNode nroCelularFocus;
  FocusNode emailFocus;
  FocusNode nroDocumentoFocus;
  FocusNode generoFocus;
  FocusNode estadoCivilFocus;
  FocusNode contrasenaFocus;
  FocusNode confirmarContrasenaFocus;


  @override
  void initState() { 
    /// ======== get localtion storage ======= ///
    final _sharedPrefs = PreferenciasUsuario();
    final usuario = _sharedPrefs.getUsuario();
    _perfil = usuario.role;
    _shortName = usuario.shortName;
    /// ======== get localtion storage ======= ///
    _scaffoldKey = new GlobalKey();

    nombreController = TextEditingController(text: widget.usuarioInit?.name ?? '');
    apellidosController = TextEditingController(text: '');
    nroCelularController = TextEditingController(text: widget.usuarioInit?.nroCelular ?? '');
    emailController = TextEditingController(text: widget.usuarioInit?.email ?? '');
    nroDocumentoController = TextEditingController(text: widget.usuarioInit?.document.toString() ?? '');
    generoController = TextEditingController(text: '');
    estadoCivilController = TextEditingController(text: '');
    contrasenaController = TextEditingController(text: '');
    confirmarContrasenaController = TextEditingController(text: '');

    nombreFocus = FocusNode();
    apellidosFocus = FocusNode();
    nroCelularFocus = FocusNode();
    emailFocus = FocusNode();
    nroDocumentoFocus = FocusNode();
    generoFocus = FocusNode();
    estadoCivilFocus = FocusNode();
    contrasenaFocus = FocusNode();
    confirmarContrasenaFocus = FocusNode();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }


  _unfocus(){
    nombreFocus.unfocus();
    apellidosFocus.unfocus();
    nroCelularFocus.unfocus();
    emailFocus.unfocus();
    nroDocumentoFocus.unfocus();
    generoFocus.unfocus();
    estadoCivilFocus.unfocus();
    contrasenaFocus.unfocus();
    confirmarContrasenaFocus.unfocus();
  }


  /// construye el titlo con su input
  Widget _titleWithInputForm({
    String title,
    TextInputType inputType,
    bool obscureText,
    String placeholderText,
    TextEditingController textEditingController,
    FocusNode focusNode
  }){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(title, style: TextStyle(color: primaryColor, fontSize: 15.0,fontWeight: FontWeight.w700)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal:50.0),
          child: InputForm(
            obscureText: obscureText,
            inputType: inputType,
            placeholderText: placeholderText,
            textEditingController: textEditingController,
            focusNode: focusNode,
          )
        ),
      ],
    );
  }

  /// construye el titlo con su input para nro de celular
  Widget _titleWithInputFormWithPrefix({
    String title,
    TextInputType inputType,
    String placeholderText,
    String postalCode,
    TextEditingController textEditingController,
    FocusNode focusNode
  }){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(title, style: TextStyle(color: primaryColor, fontSize: 15.0,fontWeight: FontWeight.w700)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal:50.0),
          child: InputFormPrefixIcon(
            inputType: inputType,
            placeholderText: placeholderText,
            postalCode: postalCode,
            textEditingController: textEditingController,
            focusNode: focusNode,
          )
        ),
      ],
    );
  }

  /// construye el titlo con su input para nro de documento
  Widget _titleWithInputFormWithLeading({
    String title,
    TextInputType inputType,
    String placeholderText,
    String documentType,
    TextEditingController textEditingController,
    FocusNode focusNode
  }){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(title, style: TextStyle(color: primaryColor, fontSize: 15.0,fontWeight: FontWeight.w700)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal:50.0),
          child: InputFormLeadingIcon(
            inputType: inputType,
            placeholderText: placeholderText,
            documentType: documentType,
            textEditingController: textEditingController,
            focusNode: focusNode,
          )
        ),
      ],
    );
  }

  ///
  /// construye el formulario para el perfil [Cliente]
  /// 
  Widget _formPerfilComerciante(){
    return Column(
      children: [
        _titleWithInputForm(
          title: 'Razon Social',
          placeholderText: 'Ingrese razon social',
          inputType: TextInputType.text,
          obscureText: false,
        ),
        _titleWithInputForm(
          title: 'Actividad Comercial',
          placeholderText: 'Ingrese actividad comercial',
          inputType: TextInputType.text,
          obscureText: false,
        ),
        _titleWithInputFormWithLeading(
          title: 'Nº de Documento',
          placeholderText: 'Ingrese nro de documento',
          inputType: TextInputType.number,
          documentType: 'NIT'
        ),
        _titleWithInputFormWithPrefix(
          title: 'Nº Celular de la empresa',
          placeholderText: 'Ingrese nro de celular',
          inputType: TextInputType.number,
          postalCode: '57'
        ),
        _titleWithInputForm(
          title: 'Nº teléfono de la empresa',
          placeholderText: 'Ingrese nro teléfono de la empresa',
          inputType: TextInputType.number,
          obscureText: false,
        ),
        _titleWithInputForm(
          title: 'Correo electrónico de la empresa',
          placeholderText: 'Ingerese correo electrónico',
          inputType: TextInputType.number,
          obscureText: false,
        )
      ],
    );
  }

  ///
  /// construye el formulario para el perfil [Comerciante]
  /// 
  Widget _formPerfilCliente(){
    return Column(
      children: [
        _titleWithInputForm(
          title: 'Tus Nombres',
          placeholderText: 'Ingrese nombre',
          inputType: TextInputType.text,
          obscureText: false,
          textEditingController: nombreController,
          focusNode: nombreFocus
        ),
        _titleWithInputForm(
          title: 'Tus Apellidos',
          placeholderText: 'Ingrese apellido',
          inputType: TextInputType.text,
          obscureText: false,
          textEditingController: apellidosController,
          focusNode: apellidosFocus
        ),
        _titleWithInputFormWithPrefix(
          title: 'Nº Celular',
          placeholderText: 'Ingrese nro de celular',
          inputType: TextInputType.number,
          postalCode: '57',
          textEditingController: nroCelularController,
          focusNode: nroCelularFocus
        ),
        _titleWithInputForm(
          title: 'Correo electrónico',
          placeholderText: 'Ingrese correo',
          inputType: TextInputType.emailAddress,
          obscureText: false,
          textEditingController: emailController,
          focusNode: emailFocus
        ),
        _titleWithInputFormWithLeading(
          title: 'Nº de Documento',
          placeholderText: 'Ingrese nro de documento',
          inputType: TextInputType.text,
          documentType: 'C.C.',
          textEditingController: nroDocumentoController,
          focusNode: nroDocumentoFocus
        ),
        _titleWithInputForm(
          title: 'Tu Género',
          placeholderText: 'Ingrese sexo',
          inputType: TextInputType.text,
          obscureText: false,
          textEditingController: generoController,
          focusNode: generoFocus
        ),
        _titleWithInputForm(
          title: 'Estado Civil',
          placeholderText: 'Ingrese estado civil',
          inputType: TextInputType.text,
          obscureText: false,
          textEditingController: estadoCivilController,
          focusNode: estadoCivilFocus
        ),
        _titleWithInputForm(
          title: 'Tu contraseña',
          placeholderText: 'Ingrese contraseña',
          inputType: TextInputType.text,
          obscureText: true,
          textEditingController: contrasenaController,
          focusNode: contrasenaFocus
        ),
        _titleWithInputForm(
          title: 'Confirma contraseña',
          placeholderText: 'Repetir contraseña',
          inputType: TextInputType.text,
          obscureText: true,
          textEditingController: confirmarContrasenaController,
          focusNode: confirmarContrasenaFocus
        ),
      ],
    );
  }

  ///
  /// metodo build
  ///
  @override
  Widget build(BuildContext context) {
    final _prefs = PreferenciasUsuario();
    final idNewUser = _prefs.get(StorageKeys.newAccountFirstLogin);
    bool isFirstLogin = false;
    if( idNewUser!=null ) isFirstLogin=true;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: (isFirstLogin) ? Container() : IconButton(
          icon: Icon(Icons.arrow_back_ios,color: cyanColor),
          onPressed:()  => Navigator.of(context).pop(), 
        ),
        actions: [
          (isFirstLogin)
          ? Container()
          : InkResponse(
              onTap: () => _scaffoldKey.currentState.openEndDrawer(),
              child: Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: CircleAvatarName(
                  diameterOutside: 40.0,
                  diameterInside: 25.0,
                  shortName: _shortName,
                  textSize: 10.0,
                ),
              ),
            )
        ],
      ),
      endDrawer: DrawerNav(),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: GestureDetector(
            onTap: _unfocus,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 40.0, bottom: 20.0),
                  child: Text('Mi cuenta', style: TextStyle(fontFamily: 'Raleway',color: primaryColor, fontSize: 30.0,fontWeight: FontWeight.w700)),
                ),
                ( _perfil != roleUsuarioName[RoleUsuario.cliente] )
                  ? _formPerfilComerciante()
                  : _formPerfilCliente(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 50.0),
                  child: ButtonSubmit(
                    color: electricVioletColor,
                    textColor: Colors.white,
                    title: ( isFirstLogin )  ? 'Siguiente' : 'Editar',
                    onPressed: ( isFirstLogin ) 
                      ? () {
                          _prefs.remove(StorageKeys.newAccountFirstLogin);
                          Navigator.of(context).pushReplacementNamed('/home');
                        }
                      : (){}
                  ),
                ),
                SizedBox(height: 50.0)
              ],
            ),
          ),
        ),
      ),
    );
  }


}