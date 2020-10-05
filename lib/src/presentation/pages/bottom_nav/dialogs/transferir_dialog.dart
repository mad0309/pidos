import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:pidos/src/data/local/preferencias_usuario.dart';
import 'package:pidos/src/domain/models/usuario.dart';
import 'package:pidos/src/presentation/blocs/servicios_bloc.dart';
import 'package:pidos/src/presentation/widgets/circle_color.dart';
import 'package:pidos/src/presentation/widgets/inputs_widgets/input_form_dialog.dart';
import 'package:pidos/src/utils/colors.dart';



Future<dynamic> transferirDialog({
  @required BuildContext context,
}) async {
  return await showDialog(
    context: context,
    child: _SystemPadding(
      child: _TransferenciaDialog(),
    )

  );
}


class _SystemPadding extends StatelessWidget {
  final Widget child;

   _SystemPadding({
    this.child
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: MediaQuery.of(context).viewPadding,
      duration: Duration(milliseconds: 500),
      child: child,
    );
  }
}


class _TransferenciaDialog extends StatefulWidget {

  @override
  __TransferenciaDialogState createState() => __TransferenciaDialogState();
}

class __TransferenciaDialogState extends State<_TransferenciaDialog> {


  TextEditingController cantidadPidsController;
  TextEditingController pidosIdController;
  FocusNode cantidadPidsFocus;
  FocusNode pidosIdFocus;


  //label del boton
  String _buttonLabel;
  String _perfil;

  bool pidCash = true;
  bool puntosPids = false;

  @override
  void initState() { 
    final _sharedPrefs = PreferenciasUsuario();
    final usuario = _sharedPrefs.getUsuario();
    _perfil = usuario.role;
    if( _perfil != roleUsuarioName[RoleUsuario.cliente] ){
      _buttonLabel = 'Transferir';
    }else{
      _buttonLabel = 'Transferir';
    }

    cantidadPidsController = TextEditingController(text: '');
    pidosIdController = TextEditingController(text: '');
    cantidadPidsFocus = FocusNode();
    pidosIdFocus = FocusNode();
    super.initState();
  }

  _unfocus(){
    cantidadPidsFocus.unfocus();
    pidosIdFocus.unfocus();
  }

  /// construye el titulo con el input text disabled
  Widget _titlelWithInputDisabled(String title, String content){
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: Text(title, style: TextStyle(fontSize: 15.0, color: Color(0xFF666666))),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: _textDisabledContainer(content)
        ),
      ],
    );
  }
  /// construye el titulo con el input text field
  Widget _titlelWithInputTextField(String title,{
    TextEditingController textEditingController,
    FocusNode focusNode,
    String hintText = '',
    TextInputType textInputType,
    String sufix,
    String prefix,
  }){
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: Text(title, style: TextStyle(fontSize: 15.0, color: Color(0xFF666666))),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: InputFormDialog(
            textEditingController: textEditingController,
            focusNode: focusNode,
            placeholderText: hintText,
            inputType: textInputType,
            sufix: sufix,
            prefix: prefix,
          )
        ),
      ],
    );
  }

  /// input text disabled
  Widget _textDisabledContainer(String content){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: secundaryColor,
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Text(content, textAlign: TextAlign.center,style: TextStyle(fontSize: 15.0, color: Color(0xFF666666))),
    );
  }

  //input Textfield
  // Widget _textInput({
    
  // }){
  //   return Padding(
  //     padding:  EdgeInsets.symmetric(vertical: 10.0),
  //     child: InputFormDialog(
  //       textEditingController: textEditingController,
  //       focusNode: focusNode,
  //       placeholderText: hintText,
  //     ),
  //   );
  // }


  /// 
  /// boton de transferir
  /// 
  Widget _transferirButton(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          child: Container( 
            padding: EdgeInsets.symmetric( vertical: 10.0 ),
            child: Text(
              _buttonLabel,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20.0
              )
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          color: electricVioletColor,
          elevation: 0.0,
          textColor: cyanColor,
          // onPressed:() => muyProntoDialog(context: context)
          // onPressed:() => Navigator.of(context).popAndPushNamed('/transferencia', arguments: false),
          onPressed:() {
            _unfocus();
            Navigator.of(context).popAndPushNamed(
              '/action_not_avaible', 
              arguments: 'En este momento no cuentas con Pidos disponibles para realizar esta acción'
            );

          } 
        ),
      ),
    );
  }
  Widget _titulo(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Text('Transferir', style: TextStyle(fontFamily: 'Raleway', fontSize: 30.0, color: primaryColor, fontWeight: FontWeight.w600)),
    );
  }

  Widget _radioButtonRow(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _radioButtonWithLabel('Pid Cash', pidCash),
          SizedBox(width: 15.0),
          _radioButtonWithLabel('Puntos Pidos', puntosPids),
        ],
      ),
    );
  }


  Widget _radioButtonWithLabel(String title, bool value){
    return GestureDetector(
      onTap: () {
        setState(() {
          if(!value){
            pidCash = !pidCash;
            puntosPids = !puntosPids;
          }
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _radioButton(value),
          SizedBox(width: 5.0),
          Text(title, style: TextStyle(fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

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


  /// 
  /// build method
  /// 
  @override
  Widget build(BuildContext context) {
    return Dialog(
      // contentPadding: EdgeInsets.all(0.0),
      // scrollable: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      insetPadding: EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: _unfocus,
        child: Container(
          padding: EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                _titulo(),
                StreamBuilder<bool>(
                  stream: BlocProvider.of<ServiciosBloc>(context).isPidChasActive$,
                  initialData: BlocProvider.of<ServiciosBloc>(context).isPidChasActive$.value,
                  builder: (context, snapshot) {
                    final isActive = snapshot.data ?? false;
                    if(isActive){
                      return _radioButtonRow(); 
                    }else{
                      return Container();
                    }
                  }
                ),
                // _titlelWithInputDisabled('Cantidad en PIDS:', '300 pids'),
                _titlelWithInputTextField('Cantidad en PIDS:',
                  textEditingController: cantidadPidsController,
                  focusNode: cantidadPidsFocus,
                  hintText: 'Ingrese la cantidad',
                  textInputType: TextInputType.number,
                  sufix: '  pids' ),
                _titlelWithInputDisabled('Cantidad en Pesos:', '\$100.0 pids'),
                // _titlelWithInputDisabled('Pidos ID:', 'PID-123456789 - Ricardo Castro'),
                _titlelWithInputTextField('Pidos ID:', 
                  textEditingController: pidosIdController,
                  focusNode: pidosIdFocus,
                  hintText: 'Ingrese ID',
                  textInputType: TextInputType.number,
                  prefix: 'PID - '),
                _transferirButton()
              ],
            ),
          ),
        ),
      )
    );
  }
}