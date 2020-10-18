import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:flutter_provider/flutter_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pidos/src/data/constanst.dart';
import 'package:pidos/src/data/local/preferencias_usuario.dart';
import 'package:pidos/src/domain/models/usuario.dart';
import 'package:pidos/src/domain/repository/transferencia_repository.dart';
import 'package:pidos/src/presentation/blocs/mi_monedero/mi_monedero_bloc.dart';
import 'package:pidos/src/presentation/blocs/servicios_bloc.dart';
import 'package:pidos/src/presentation/blocs/transferir_bloc.dart';
import 'package:pidos/src/presentation/states/transferencia_message.dart';
import 'package:pidos/src/presentation/widgets/circle_color.dart';
import 'package:pidos/src/presentation/widgets/inputs_widgets/input_form_dialog.dart';
import 'package:pidos/src/presentation/widgets/respuesta_dialog.dart';
import 'package:pidos/src/utils/colors.dart';



Future<dynamic> transferirDialog({
  @required BuildContext context,
  @required String fromPage
}) async {
  MiMonederoBloc _miMonederoBloc;
  if( fromPage != '/' ){
    _miMonederoBloc = BlocProvider.of<MiMonederoBloc>(context);
  }
  return await showDialog(
    context: context,
    child: BlocProvider(
      initBloc: () => TranferirBloc(
        transferenciaRepository: Provider.of<TransferenciaRepository>(context),
      ),
      child: _SystemPadding(
        child: _TransferenciaDialog(
          miMonederoBloc: _miMonederoBloc,
        ),
      ),
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
  final MiMonederoBloc miMonederoBloc;

  const _TransferenciaDialog({
    this.miMonederoBloc
  });

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

  TranferirBloc tranferirBloc;
  StreamSubscription transferenciaMessage$;

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

  @override
  void didChangeDependencies() {
    tranferirBloc ??= BlocProvider.of<TranferirBloc>(context);
    transferenciaMessage$ ??= BlocProvider.of<TranferirBloc>(context).transferenciaMessage$.listen((message) async {
      final usuario = PreferenciasUsuario().getUsuario();
      final currentPidId = usuario.document;
      final destinationPidId = tranferirBloc.destinationPidId$.value;
      final cantidadPidEnviada = tranferirBloc.cantidadEnPids$.value;
      if( message is TransferenciaSuccessMessage ){
        if( widget.miMonederoBloc!=null ){
          if(tranferirBloc.tipoTransferencia$.value == TipoTransferencia.pidPuntos){
            widget.miMonederoBloc.pidosDisponiblesSink$.add(usuario.pid);
          }else{
            widget.miMonederoBloc.pidosDisponiblesSink$.add(usuario.pidcash);
          }
        }
        Navigator.of(context).popAndPushNamed('/transferencia', arguments: {
          'status': true,
          'currentPidId': currentPidId,
          'destinationPidId': destinationPidId,
          'cantidadPidEnviada': cantidadPidEnviada
        });
      }
      if( message is TransferenciaErrorMessage ){
        Navigator.of(context).popAndPushNamed('/transferencia', arguments: {
          'status': false,
          'currentPidId': currentPidId,
          'destinationPidId': destinationPidId,
          'cantidadPidEnviada': cantidadPidEnviada
        });
      }
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() { 
    transferenciaMessage$?.cancel();
    super.dispose();
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
    Function(String) onChanged
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
            onChange: onChanged,
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
            child: StreamBuilder<bool>(
              stream: tranferirBloc.isLoadingTransferencia$,
              initialData: false,
              builder: (context, snapshot) {
                final isLoading = snapshot.data ?? false;
                if( !isLoading ){
                  return Text(
                    _buttonLabel,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0
                    )
                  );
                }else{
                  return SpinKitWave(
                    color: Colors.white,
                    size: 19.0,
                  );
                }
              }
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
            _onTaptransferir();
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
          StreamBuilder<TipoTransferencia>(
            stream: tranferirBloc.tipoTransferencia$,
            initialData: tranferirBloc.tipoTransferencia$.value,
            builder: (context, snapshot) {
              final tipoTransferencia = snapshot.data;
              bool active = false;
              if( tipoTransferencia == TipoTransferencia.pidCash ){
                active = true;
              }else{
                active = false;
              }
              return _radioButtonWithLabel('Pid Cash', active,TipoTransferencia.pidCash);
            }
          ),
          SizedBox(width: 15.0),
          StreamBuilder<TipoTransferencia>(
            stream: tranferirBloc.tipoTransferencia$,
            initialData: tranferirBloc.tipoTransferencia$.value,
            builder: (context, snapshot) {
              final tipoTransferencia = snapshot.data;
              bool active = false;
              if( tipoTransferencia == TipoTransferencia.pidPuntos ){
                active = true;
              }else{
                active = false;
              }
              return _radioButtonWithLabel('Puntos Pidos', active, TipoTransferencia.pidPuntos);
            }
          ),
        ],
      ),
    );
  }


  Widget _radioButtonWithLabel(String title, bool value, TipoTransferencia tipoTransferencia ){
    return GestureDetector(
      onTap: () => tranferirBloc.onChangedtipoTransferecnia(tipoTransferencia),
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
                  sufix: '  pids',
                  onChanged: onChangePid
                ),
                StreamBuilder<double>(
                  stream: tranferirBloc.cantidadaEnPesos$,
                  initialData: tranferirBloc.cantidadaEnPesos$.value,
                  builder: (context, snapshot) {
                    final cantidadEnPesos = snapshot.data;
                    return _titlelWithInputDisabled('Cantidad en Pesos:', '\$$cantidadEnPesos');
                  }
                ),
                // _titlelWithInputDisabled('Pidos ID:', 'PID-123456789 - Ricardo Castro'),
                _titlelWithInputTextField('Pidos ID:', 
                  textEditingController: pidosIdController,
                  focusNode: pidosIdFocus,
                  hintText: 'Ingrese ID',
                  textInputType: TextInputType.number,
                  prefix: 'PID - ',
                  onChanged: onChangePidId
                ),
                _transferirButton()
              ],
            ),
          ),
        ),
      )
    );
  }

  void onChangePid(String value){
    final cantidadPidString = value.replaceAll('  pids', '');
    if(value.length>0){
      final cantidadPidNumber = num.parse(cantidadPidString);
      final canitdadEnPesos = cantidadPidNumber.toInt() * currentValuePidInPesos; 
      tranferirBloc.onChangedcantidadEnPids(cantidadPidNumber);
      tranferirBloc.cantidadaEnPesosSink$.add(canitdadEnPesos.toDouble());
    }else{
      tranferirBloc.onChangedcantidadEnPids(0);
      tranferirBloc.cantidadaEnPesosSink$.add(0.0);
    }
  }
  void onChangePidId(String value){
    final pidIdString = value.replaceAll('PID - ', '');
    if(value.length>0){
      tranferirBloc.onChangeDestinationPidId(pidIdString);
    }else{
      tranferirBloc.onChangeDestinationPidId(null);
    }
  }

  _onTaptransferir() async {
    _unfocus();
    final pidsToTransfer = tranferirBloc.cantidadEnPids$.value;
    final destinationPidId = tranferirBloc.destinationPidId$.value;
    final usuario = PreferenciasUsuario().getUsuario();
    final currtentPidPuntos = usuario.pid;
    final currtentPidCash = usuario.pidcash;
    double currentPid = 0.0;
    String message = '';
    if( pidsToTransfer==null || pidsToTransfer <= 0 ){
      return respuestaDialog(
        context: context, 
        message: 'Ingrese una cantidad de Pids valida', 
        title: 'Campos incompletos', 
        icon: Icon(Icons.warning, color: electricVioletColor, size: 30.0)
      );
    }else{
      if( destinationPidId==null || destinationPidId.length==0 ){
        return respuestaDialog(
          context: context, 
          message: 'Ingrese PidID valido', 
          title: 'Campos incompletos', 
          icon: Icon(Icons.warning, color: electricVioletColor, size: 30.0)
        );
      }
    }
    if( tranferirBloc.tipoTransferencia$.value == TipoTransferencia.pidPuntos ){
      currentPid = currtentPidPuntos;
      message = 'En este momento no cuentas con puntos pid disponibles para realizar esta acción';
    }else{
      currentPid = currtentPidCash;
      message = 'En este momento no cuentas con pidcash disponibles para realizar esta acción';
    }
    if( currentPid > 0.0 ){
      // print('TODO OK');
      tranferirBloc.onSubmitTransferencia();
    }else{
      Navigator.of(context).popAndPushNamed(
        '/action_not_avaible', 
        arguments: message
      );
    }

  }

}