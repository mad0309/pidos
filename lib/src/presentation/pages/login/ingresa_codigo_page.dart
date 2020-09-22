import 'package:flutter/material.dart';
import 'package:pidos/src/presentation/widgets/login/verification_input.dart';
import 'package:pidos/src/utils/colors.dart';
import 'package:pidos/src/utils/screen_aware_size.dart';


class IngresaCodigoPage extends StatefulWidget {

  @override
  _IngresaCodigoPageState createState() => _IngresaCodigoPageState();
}

class _IngresaCodigoPageState extends State<IngresaCodigoPage> {

  double screenSizeHeight;
  double screenSizeWidth;

  /// controller
  TextEditingController _primerDigitoController;
  TextEditingController _segundoDigitoController;
  TextEditingController _terceroDigitoController;
  TextEditingController _cuartoDigitoController;
  TextEditingController _quintoDigitoController;

  /// Focusnode
  FocusNode _primerDigitoFocus;
  FocusNode _segundoDigitoFocus;
  FocusNode _terceroDigitoFocus;
  FocusNode _cuartoDigitoFocus;
  FocusNode _quintoDigitoFocus;
  


  @override
  void initState() { 
    /// ====== inicilazar controllers ====== ///
    _primerDigitoController = TextEditingController(text: '');
    _segundoDigitoController = TextEditingController(text: '');
    _terceroDigitoController = TextEditingController(text: '');
    _cuartoDigitoController = TextEditingController(text: '');
    _quintoDigitoController = TextEditingController(text: '');

    /// ====== inicilazar foscusNode ====== ///
    _primerDigitoFocus = FocusNode();
    _segundoDigitoFocus = FocusNode();
    _terceroDigitoFocus = FocusNode();
    _cuartoDigitoFocus = FocusNode();
    _quintoDigitoFocus = FocusNode();
    super.initState();
  }


  /// metodo dispose
  @override
  void dispose() { 
    _primerDigitoController?.dispose();
    _segundoDigitoController?.dispose();
    _terceroDigitoController?.dispose();
    _cuartoDigitoController?.dispose();
    _quintoDigitoController?.dispose();
    super.dispose();
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              VerificationInput(
                textEditingController: _primerDigitoController,
                focusNode: _primerDigitoFocus,
                onSubmit: _onSubmit,
              ),
              VerificationInput(
                textEditingController: _segundoDigitoController,
                focusNode: _segundoDigitoFocus,
                onSubmit: _onSubmit,
              ),
              VerificationInput(
                textEditingController: _terceroDigitoController,
                focusNode: _terceroDigitoFocus,
                onSubmit: _onSubmit,
              ),
              VerificationInput(
                textEditingController: _cuartoDigitoController,
                focusNode: _cuartoDigitoFocus,
                onSubmit: _onSubmit,
              ),
              VerificationInput(
                textEditingController: _quintoDigitoController,
                focusNode: _quintoDigitoFocus,
                onSubmit: _onSubmit,
              ),
            ],
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
      ],
    );
  }

  ///
  /// on submit function
  ///
  void _onSubmit(String value){
    Navigator.of(context).pushNamed('/registro_form');
  }


///
/// metodo build
///
  @override
  Widget build(BuildContext context) {
    screenSizeHeight = MediaQuery.of(context).size.height;
    screenSizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _logoImage(),
              _creaTuCuentSection(),
              _ingresaCodigoSection()
            ],
          ),
        ),
      )
    );
  }
}