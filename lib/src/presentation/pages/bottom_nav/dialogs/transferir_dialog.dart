import 'package:flutter/material.dart';
import 'package:pidos/src/data/local/preferencias_usuario.dart';
import 'package:pidos/src/presentation/widgets/muy_pronto_dialog.dart';
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

  //label del boton
  String _buttonLabel;
  String _perfil;

  @override
  void initState() { 
    final _sharedPrefs = PreferenciasUsuario();
    _perfil = _sharedPrefs.get(StorageKeys.perfil);
    if( _perfil == 'CLIENTE' ){
      _buttonLabel = 'Transferir';
    }else{
      _buttonLabel = 'Redimir';
    }
    super.initState();
  }

  /// construye el titulo con el input text
  Widget _titlelWithInput(String title, String content){
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

  /// input text
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
          onPressed:() => muyProntoDialog(context: context)
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      insetPadding: EdgeInsets.all(15.0),
      child: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _titlelWithInput('Cantidad en PIDS:', '300 pids'),
            _titlelWithInput('Cantidad en Pesos:', '\$100.0 pids'),
            _titlelWithInput('Pidos ID:', 'PID-123456789 - Ricardo Castro'),
            _transferirButton()
          ],
        ),
      )
    );
  }
}