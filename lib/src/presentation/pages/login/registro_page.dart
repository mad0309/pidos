import 'package:flutter/material.dart';
import 'package:pidos/src/presentation/widgets/login/input_login_widget.dart';
import 'package:pidos/src/utils/colors.dart';


class RegistroPage extends StatefulWidget {
  

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {

  ///
  /// Imagen de fondo
  ///
  Widget _backgroundImage(){
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image(
        image: AssetImage('assets/img/fondo.jpg'),
        fit: BoxFit.cover,
      ),
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
            SizedBox(height: 40.0),
            Image(
              image: AssetImage('assets/img/logo_blank.png'),
              fit: BoxFit.cover,
              width: 80.0,
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
      padding: EdgeInsets.symmetric(vertical: 25.0),
      child: Text(
        'Crea tu cuenta', 
        style: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
          fontWeight: FontWeight.w700
        ),
      )
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _backgroundImage(),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _logoImage(),
                _creaTuCuentSection(),
                _RegistroForm(),
              ],
            )
          ),
        ],
      ),
    );
  }
}

class _RegistroForm extends StatefulWidget {
  

  @override
  __RegistroFormState createState() => __RegistroFormState();
}

class __RegistroFormState extends State<_RegistroForm> {


  /// controllers
  TextEditingController nroCelularController;
  TextEditingController nombreController;

  /// Metodo de ciclo de vida
  @override
  void initState() { 
    nroCelularController = TextEditingController(text: '');
    nombreController = TextEditingController(text: '');
    super.initState();
  }
  /// Metodo de ciclo de vida
  @override
  void dispose() { 
    nroCelularController?.dispose();
    nombreController?.dispose();
    super.dispose();
  }

  ///
  /// Caja de texto para ingresar numero de celular
  ///
  Widget _nameSection(){
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              'Tus nombres',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.w600
              )),
          ),
          // SizedBox(height: 10.0),
          InputLoginWidget(
            textEditingController: nombreController,
            inputType: TextInputType.text,
            obscureText: false,
            placeholderText: 'Ingeresa su nombre',
          )
      ],
    );
  }

  ///
  /// Caja de texto para ingresar contraseña
  ///
  Widget _phoneSection(){
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              'Tu número de celular',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.w600
              )),
          ),
          InputLoginWidget(
            textEditingController: nroCelularController,
            inputType: TextInputType.number,
            obscureText: false, 
            placeholderText: 'Ingeresa tu numero',
            prefixIcon: Container(
              child: Padding(
                padding: EdgeInsets.only(top: 0.0,left: 10.0),
                child: Text('+57 |',style: TextStyle(
                  fontSize: 18.0,
                  color: Color(0xFF666666)
                )),
              ),
            ),
          )
      ],
    );
  }

  ///
  /// Boton de logeo
  ///
  Widget _accederButton(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0 ),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          child: Container( 
            padding: EdgeInsets.symmetric( vertical: 10.0 ),
            child: Text(
              'Siguiente',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20.0
              )
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          color: primaryColor,
          elevation: 0.0,
          textColor: Colors.white,
          onPressed: () => Navigator.of(context).pushNamed('/ingresa_codigo')
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0.0,left: 40.0, right: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _nameSection(),
          _phoneSection(),
          _accederButton()
        ],
      ),
    );
  }
}