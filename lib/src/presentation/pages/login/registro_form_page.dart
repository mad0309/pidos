import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pidos/src/presentation/widgets/button_submit.dart';
import 'package:pidos/src/presentation/widgets/inputs_widgets/input_form.dart';
import 'package:pidos/src/presentation/widgets/inputs_widgets/input_form_leading_icon.dart';
import 'package:pidos/src/presentation/widgets/inputs_widgets/input_form_prefix_icon.dart';
import 'package:pidos/src/utils/colors.dart';


class RegistroFormPage extends StatefulWidget {

  @override
  _RegistroFormPageState createState() => _RegistroFormPageState();
}

class _RegistroFormPageState extends State<RegistroFormPage> {

  /// variable para controller el progrss bar
  double _progressPercent = 0.2; 


  // void onTextChange(String value){
  //   if(value.length > 0){
  //     _progressPercent = _progressPercent + 0.11;
  //   }else{
      
  //   }
  // }

  /// contruye el titulo del input con el input
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

  /// contruye el titulo del input con el input de numero de celular
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
  /// Formulario de registro
  ///
  Widget _formRegistro(){
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
          inputType: TextInputType.number,
          documentType: 'C.C.'
        ),
        _titleWithInputForm(
          title: 'Tu Género',
          placeholderText: 'Ingrese genero',
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
          title: 'Conforma contraseña',
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
      backgroundColor: secundaryColor,
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(top: 35.0, bottom: 10.0, left: 60.0, right: 60.0),
                  child: Text('Completa tu registro',textAlign: TextAlign.center, style: TextStyle(color: primaryColor, fontSize: 30.0,fontWeight: FontWeight.w700)),
                ),
              ),
              //progress bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0,vertical: 8.0),
                child: LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 100.0,
                  lineHeight: 13.0,
                  percent: _progressPercent,
                  progressColor: electricVioletColor,
                ),
              ),
              _formRegistro(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 50.0),
                child: ButtonSubmit(
                  color: electricVioletColor,
                  textColor: Colors.white,
                  title: 'Guardar',
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