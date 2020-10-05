import 'package:flutter/material.dart';
import 'package:pidos/src/data/local/preferencias_usuario.dart';
import 'package:pidos/src/domain/models/usuario.dart';
import 'package:pidos/src/presentation/widgets/button_submit.dart';
import 'package:pidos/src/presentation/widgets/circle_avatar_name.dart';
import 'package:pidos/src/presentation/widgets/drawer_nav.dart';
import 'package:pidos/src/presentation/widgets/inputs_widgets/input_form.dart';
import 'package:pidos/src/presentation/widgets/inputs_widgets/input_form_leading_icon.dart';
import 'package:pidos/src/presentation/widgets/inputs_widgets/input_form_prefix_icon.dart';
import 'package:pidos/src/utils/colors.dart';


class MiCuentapPage extends StatefulWidget {

  @override
  _MiCuentapPageState createState() => _MiCuentapPageState();
}

class _MiCuentapPageState extends State<MiCuentapPage> {

  GlobalKey<ScaffoldState> _scaffoldKey;
  String _perfil = '';
  String _shortName = '';

  @override
  void initState() { 
    /// ======== get localtion storage ======= ///
    final _sharedPrefs = PreferenciasUsuario();
    final usuario = _sharedPrefs.getUsuario();
    _perfil = usuario.role;
    _shortName = usuario.shortName;
    /// ======== get localtion storage ======= ///
    _scaffoldKey = new GlobalKey();
    super.initState();
  }


  /// construye el titlo con su input
  Widget _titleWithInputForm({
    String title,
    TextInputType inputType,
    bool obscureText,
    String placeholderText
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
    String postalCode
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
            postalCode: postalCode
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
    String documentType
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
        ),
        _titleWithInputForm(
          title: 'Tus Apellidos',
          placeholderText: 'Ingrese apellido',
          inputType: TextInputType.text,
          obscureText: false,
        ),
        _titleWithInputFormWithPrefix(
          title: 'Nº Celular',
          placeholderText: 'Ingrese nro de celular',
          inputType: TextInputType.number,
          postalCode: '57'
        ),
        _titleWithInputForm(
          title: 'Correo electrónico',
          placeholderText: 'Ingrese correo',
          inputType: TextInputType.emailAddress,
          obscureText: false,
        ),
        _titleWithInputFormWithLeading(
          title: 'Nº de Documento',
          placeholderText: 'Ingrese nro de documento',
          inputType: TextInputType.text,
          documentType: 'C.C.'
        ),
        _titleWithInputForm(
          title: 'Tu Género',
          placeholderText: 'Ingrese sexo',
          inputType: TextInputType.text,
          obscureText: false,
        ),
        _titleWithInputForm(
          title: 'Estado Civil',
          placeholderText: 'Ingrese estado civil',
          inputType: TextInputType.text,
          obscureText: false,
        ),
        _titleWithInputForm(
          title: 'Tu contraseña',
          placeholderText: 'Ingrese contraseña',
          inputType: TextInputType.text,
          obscureText: true,
        ),
        _titleWithInputForm(
          title: 'Confirma contraseña',
          placeholderText: 'Repetir contraseña',
          inputType: TextInputType.text,
          obscureText: true,
        ),
      ],
    );
  }

  ///
  /// metodo build
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: cyanColor),
          onPressed:()  => Navigator.of(context).pop(), 
        ),
        actions: [
          InkResponse(
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
                  title: 'Editar',
                  onPressed: (){},
                ),
              ),
              SizedBox(height: 50.0)
            ],
          ),
        ),
      ),
    );
  }


}