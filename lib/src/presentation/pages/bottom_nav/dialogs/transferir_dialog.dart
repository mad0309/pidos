import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:flutter_provider/flutter_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:pidos/app/global_singleton.dart';
import 'package:pidos/src/data/local/preferencias_usuario.dart';
import 'package:pidos/src/domain/models/settings.dart';
import 'package:pidos/src/domain/models/usuario.dart';
import 'package:pidos/src/domain/repository/transferencia_repository.dart';
import 'package:pidos/src/presentation/blocs/home/home_bloc.dart';
import 'package:pidos/src/presentation/blocs/transferir_bloc.dart';
import 'package:pidos/src/presentation/states/result_state.dart';
import 'package:pidos/src/presentation/states/transferencia_message.dart';
import 'package:pidos/src/presentation/widgets/circle_color.dart';
import 'package:pidos/src/presentation/widgets/inputs_widgets/input_form_dialog.dart';
import 'package:pidos/src/presentation/widgets/inputs_widgets/input_form_pesos_dialog.dart';
import 'package:pidos/src/presentation/widgets/respuesta_dialog.dart';
import 'package:pidos/src/utils/colors.dart';

/// 
/// SE ELIMINO LOS RADIOBUTTONS
/// POR EL DESACOPLAMINETO DE PIDCASH DE LA APP
/// BY: MAD | 26/10/2020
/// 

Future<dynamic> transferirDialog({
  @required BuildContext context,
  // @required String fromPage
}) async {
  return await showDialog(
    context: context,
    child: BlocProvider(
      initBloc: () => TranferirBloc(
        transferenciaRepository: Provider.of<TransferenciaRepository>(context),
      ),
      child: _SystemPadding(
        child: _TransferenciaDialog(),
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
  // final MiMonederoBloc miMonederoBloc;

  // const _TransferenciaDialog({
  //   this.miMonederoBloc
  // });

  @override
  __TransferenciaDialogState createState() => __TransferenciaDialogState();
}

class __TransferenciaDialogState extends State<_TransferenciaDialog> with TickerProviderStateMixin {

  AnimationController ingreseCantidadPidsAnimationController;
  AnimationController pidosIdAnimationController;
  Animation _ingreseCantidadPidsColorTween;
  Animation _pidosIdColorTween;

  TextEditingController cantidadPidsController;
  TextEditingController pidosIdController;
  TextEditingController pesosController;
  FocusNode cantidadPidsFocus;
  FocusNode pidosIdFocus;
  FocusNode pesosFocus;


  //label del boton
  String _buttonLabel;
  String _perfil;

  bool pidCash = true;
  bool puntosPids = false;

  TranferirBloc tranferirBloc;
  StreamSubscription transferenciaMessage$;
  HomeBloc homeBloc;

  double currentValuePidPuntos;
  // double currentValuePidCash;
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() { 
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    ingreseCantidadPidsAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    pidosIdAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _ingreseCantidadPidsColorTween = ColorTween(begin: Colors.transparent, end: Colors.red).animate(ingreseCantidadPidsAnimationController);
    _pidosIdColorTween = ColorTween(begin: Colors.transparent, end: Colors.red).animate(pidosIdAnimationController);
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();

    final _sharedPrefs = PreferenciasUsuario();
    final usuario = _sharedPrefs.getUsuario();
    _perfil = usuario.role;
    if( _perfil != roleUsuarioName[RoleUsuario.cliente] ){
      _buttonLabel = 'Transferir';
    }else{
      _buttonLabel = 'Transferir';
    }
    final contextApp = GlobalSingleton().contextApp;
    homeBloc = BlocProvider.of<HomeBloc>(contextApp);

    cantidadPidsController = TextEditingController(text: '');
    pidosIdController = TextEditingController(text: '');
    pesosController = TextEditingController(text: '');
    cantidadPidsFocus = FocusNode();
    pidosIdFocus = FocusNode();
    pesosFocus = FocusNode();
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
        homeBloc.retornaSaldo();
        Navigator.of(context).popAndPushNamed('/transferencia', arguments: {
          'status': true,
          'currentPidId': currentPidId,
          'destinationPidId': destinationPidId,
          'cantidadPidEnviada': cantidadPidEnviada
        });
      }
      if( message is TransferenciaErrorMessage ){
        homeBloc.retornaSaldo();
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
    ingreseCantidadPidsAnimationController?.dispose();
    pidosIdAnimationController?.dispose();
    super.dispose();
  }

  _unfocus(){
    cantidadPidsFocus.unfocus();
    pidosIdFocus.unfocus();
    pesosFocus.unfocus();
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
  /// construye el titulo con el input text disabled isLoading
  Widget _titlelWithInputDisabledLoading(String title){
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: Text(title, style: TextStyle(fontSize: 15.0, color: Color(0xFF666666))),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: _textDisabledContainerLoading()
        ),
      ],
    );
  }
  /// construye solo el input text disabled isLoading
  Widget _inputDisabledLoading(){
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: _textDisabledContainerLoading()
        ),
      ],
    );
  }

  /// construye solo el input text field
  Widget _inputTextFieldPid({
    TextEditingController textEditingController,
    FocusNode focusNode,
    String hintText = '',
    TextInputType textInputType,
    String sufix,
    String prefix,
    Function(String) onChanged,
    Color borderColor
  }){
    return Column(
      children: [
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
            borderColor: borderColor,
          )
        ),
      ],
    );
  }
  /// construye solo el input text field para pesos
  Widget _inputTextFieldPesos({
    TextEditingController textEditingController,
    FocusNode focusNode,
    String hintText = '',
    TextInputType textInputType,
    Function(String) onChanged,
    Color borderColor,
  }){
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: InputFormPesosDialog(
            textEditingController: textEditingController,
            focusNode: focusNode,
            placeholderText: hintText,
            inputType: textInputType,
            onChange: onChanged,
            borderColor: borderColor
          )
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
    Function(String) onChanged,
    Color borderColor
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
            borderColor: borderColor,
          )
        ),
      ],
    );
  }
  // /// construye el titulo con el input text field para PESOS
  // Widget _titlelWithInputForPesosTextField(String title,{
  //   TextEditingController textEditingController,
  //   FocusNode focusNode,
  //   String hintText = '',
  //   TextInputType textInputType,
  //   Function(String) onChanged
  // }){
  //   return Column(
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.symmetric(vertical: 5.0),
  //         child: Text(title, style: TextStyle(fontSize: 15.0, color: Color(0xFF666666))),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.symmetric(vertical: 5.0),
  //         child: InputFormPesosDialog(
  //           textEditingController: textEditingController,
  //           focusNode: focusNode,
  //           placeholderText: hintText,
  //           inputType: textInputType,
  //           onChange: onChanged,
  //         )
  //       ),
  //     ],
  //   );
  // }

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
  /// input text disabled
  Widget _textDisabledContainerLoading(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: secundaryColor,
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: SpinKitThreeBounce(
        size: 15.0,
        color: primaryColor.withOpacity(0.5)
      ),
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


  ///
  /// INGRESA CANTIDAD EN
  ///

  Widget _radioButtonRow(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<IngresaValorEn>(
            stream: tranferirBloc.ingresaValorEn$,
            initialData: tranferirBloc.ingresaValorEn$.value,
            builder: (context, snapshot) {
              final ingresaValorEn = snapshot.data;
              bool active = false;
              if( ingresaValorEn == IngresaValorEn.pids ){
                active = true;
              }else{
                active = false;
              }
              return _radioButtonWithLabel(ingresaValorEnNombre[IngresaValorEn.pids], active,IngresaValorEn.pids);
            }
          ),
          SizedBox(width: 40.0),
          StreamBuilder<IngresaValorEn>(
            stream: tranferirBloc.ingresaValorEn$,
            initialData: tranferirBloc.ingresaValorEn$.value,
            builder: (context, snapshot) {
              final ingresaValorEn = snapshot.data;
              bool active = false;
              if( ingresaValorEn == IngresaValorEn.pesos ){
                active = true;
              }else{
                active = false;
              }
              return _radioButtonWithLabel(ingresaValorEnNombre[IngresaValorEn.pesos], active, IngresaValorEn.pesos);
            }
          ),
        ],
      ),
    );
  }


  Widget _radioButtonWithLabel(String title, bool value, IngresaValorEn ingresaValorEn ){
    return GestureDetector(
      onTap: () async {
        if( tranferirBloc.ingresaValorEn$.value.toString() != ingresaValorEn.toString() ){
          cantidadPidsController.text = '';
          pesosController.text = '';
          _unfocus();
          // pidosIdController.text = '';
          await tranferirBloc.resetValues();
        }
        tranferirBloc.onChangedIngresaValorEn(ingresaValorEn);
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
  /// Cantidad en Pids INPUT
  ///
  Widget _cantidadEnPids(){
    return StreamBuilder<ResultState<List<Settings>>>(
      stream: tranferirBloc.valorActualPidEnPesos$,
      initialData: tranferirBloc.valorActualPidEnPesos$.value,
      builder: (context, snapshot) {
        final state = snapshot.data;
        return state.maybeWhen(
          loading: () => _inputDisabledLoading(),
          error: (e) => _titlelWithInputDisabled('Cantidad en PIDS:', 'No hay conexión, intentelo más tarde'),
          data: (lsSettings) { 
            currentValuePidPuntos = double.parse(lsSettings[1].value);
            // currentValuePidCash = double.parse(lsSettings[0].value);
            return AnimatedBuilder(
              animation: _ingreseCantidadPidsColorTween,
              builder: (context, snapshot) {
                return _inputTextFieldPid(
                  textEditingController: cantidadPidsController,
                  focusNode: cantidadPidsFocus,
                  hintText: 'Ingrese cantidad en pids',
                  textInputType: TextInputType.number,
                  sufix: '  pids',
                  onChanged: onChangePid,
                  borderColor: _ingreseCantidadPidsColorTween?.value
                );
              }
            );
          },
          orElse: () => Container()
        );
      }
    );
  }
  ///
  /// Cantidad en Pesos INPUT
  ///
  Widget _cantidadEnPesos(){
    return StreamBuilder<ResultState<List<Settings>>>(
      stream: tranferirBloc.valorActualPidEnPesos$,
      initialData: tranferirBloc.valorActualPidEnPesos$.value,
      builder: (context, snapshot) {
        final state = snapshot.data;
        return state.maybeWhen(
          loading: () => _inputDisabledLoading(),
          error: (e) => _titlelWithInputDisabled('Cantidad en Pesos:', 'No hay conexión, intentelo más tarde'),
          data: (lsSettings) { 
            currentValuePidPuntos = double.parse(lsSettings[1].value);
            return AnimatedBuilder(
              animation: _ingreseCantidadPidsColorTween,
              builder: (context, snapshot) {
                return _inputTextFieldPesos(
                  textEditingController: pesosController,
                  focusNode: pesosFocus,
                  hintText: 'Ingrese cantidad en pesos',
                  textInputType: TextInputType.number,
                  onChanged: onChangePesos,
                  borderColor: _ingreseCantidadPidsColorTween?.value
                );
              }
            );
          },
          orElse: () => Container()
        );
      }
    );
  }

  ///
  /// Cantidad en Pids DISABLED
  ///
  Widget _cantidadEnPidsDisabled(){
    return StreamBuilder<int>(
      stream: tranferirBloc.cantidadEnPids$,
      initialData: tranferirBloc.cantidadEnPids$.value,
      builder: (context, snapshot) {
        final cantidadEnPids = snapshot.data;
        return _titlelWithInputDisabled('Cantidad en Pids:', '$cantidadEnPids  pids');
      }
    );
  }

  ///
  /// Cantidad en Pesos DISABLED
  ///
  Widget _cantidadEnPesosDisabled(){
    return StreamBuilder<double>(
      stream: tranferirBloc.cantidadaEnPesos$,
      initialData: tranferirBloc.cantidadaEnPesos$.value,
      builder: (context, snapshot) {
        final cantidadEnPesos = snapshot.data;
        NumberFormat format = NumberFormat('#,###');
        String pesosString = format.format(cantidadEnPesos);
        if(cantidadEnPesos>=1000.0){
          pesosString =  pesosString.replaceAll(',', '.');
        }
        pesosString = '\$$pesosString,oo';
        return _titlelWithInputDisabled('Cantidad en Pesos:', (cantidadEnPesos>0.0) ? pesosString : '\$0,oo');
      }
    );
  }


  /// 
  /// build method
  /// 
  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: Dialog(
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
                  Text('Ingresa valor en: '),
                  _radioButtonRow(),
                  StreamBuilder<IngresaValorEn>(
                    stream: tranferirBloc.ingresaValorEn$,
                    initialData: tranferirBloc.ingresaValorEn$.value,
                    builder: (context, snapshot) {
                      final ingresaValorEn = snapshot.data;
                      if( ingresaValorEnNombre[ingresaValorEn] == 'Pids' ){
                        return _cantidadEnPids();
                      }else{
                        return _cantidadEnPesos();
                      }
                    }
                  ),
                  StreamBuilder<IngresaValorEn>(
                    stream: tranferirBloc.ingresaValorEn$,
                    initialData: tranferirBloc.ingresaValorEn$.value,
                    builder: (context, snapshot) {
                      final ingresaValorEn = snapshot.data;
                      if( ingresaValorEnNombre[ingresaValorEn] == 'Pids' ){
                        return _cantidadEnPesosDisabled();
                      }else{
                        return _cantidadEnPidsDisabled();
                      }
                    }
                  ),
                  StreamBuilder<ResultState<List<Settings>>>(
                    stream: tranferirBloc.valorActualPidEnPesos$,
                    initialData: tranferirBloc.valorActualPidEnPesos$.value,
                    builder: (context, snapshot) {
                      final state = snapshot.data;
                      return state.maybeWhen(
                        loading: () => _titlelWithInputDisabledLoading('Pidos ID:'),
                        error: (e) => _titlelWithInputDisabled('Pidos ID:', 'No hay conexión, intentelo más tarde'),
                        data: (lsSettings) { 
                          currentValuePidPuntos = double.parse(lsSettings[1].value);
                          // currentValuePidCash = double.parse(lsSettings[0].value);
                          return AnimatedBuilder(
                            animation: _pidosIdColorTween,
                            builder: (context, child) {
                              return _titlelWithInputTextField('Pidos ID:', 
                                textEditingController: pidosIdController,
                                focusNode: pidosIdFocus,
                                hintText: 'Ingrese ID',
                                textInputType: TextInputType.number,
                                prefix: 'PID - ',
                                onChanged: onChangePidId,
                                borderColor: _pidosIdColorTween?.value
                              );
                            }
                          );
                        },
                        orElse: () => Container()
                      );
                    }
                  ),
                  
                  _transferirButton()
                ],
              ),
            ),
          ),
        )
      ),
    );
  }

  void onChangePid(String value){
    final cantidadPidString = value.replaceAll('  pids', '');
    double currentValuePidInPesos = 0.0;
    if( tranferirBloc.tipoTransferencia$.value == TipoTransferencia.pidPuntos ){
      currentValuePidInPesos = currentValuePidPuntos;
    }
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
  void onChangePesos(String value){
    String pesosInString = value.replaceAll('\$', '');
    pesosInString = pesosInString.replaceAll(',oo', '');
    pesosInString = pesosInString.replaceFirst('.', '');
    if(value.length>0){
      final pesos = double.parse(pesosInString);

      final pesosRoundFloor = (pesos/currentValuePidPuntos).floor();
      tranferirBloc.cantidadaEnPesosSink$.add(pesos);
      tranferirBloc.onChangedcantidadEnPids(pesosRoundFloor);
    }else{
      tranferirBloc.cantidadaEnPesosSink$.add(0.0);
      tranferirBloc.onChangedcantidadEnPids(0);
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
    bool isValid = true;
    if( pidsToTransfer==null || pidsToTransfer <= 0 ){
      ingreseCantidadPidsAnimationController.reverse(from: 1.0);
      isValid = false;
    }
    if( destinationPidId==null || destinationPidId.length==0 ){
      pidosIdAnimationController.reverse(from: 1.0);
      isValid = false;
    }
    if( !isValid ){
      return null;
    }
    if( tranferirBloc.tipoTransferencia$.value == TipoTransferencia.pidPuntos ){
      currentPid = currtentPidPuntos;
      message = 'En este momento no cuentas con puntos pid disponibles para realizar esta acción';
    }
    // else{
    //   currentPid = currtentPidCash;
    //   message = 'En este momento no cuentas con pidcash disponibles para realizar esta acción';
    // }
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