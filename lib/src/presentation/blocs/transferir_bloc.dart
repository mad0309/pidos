
import 'dart:async';

import 'package:meta/meta.dart';
import 'package:pidos/src/data/exceptions/network_exceptions.dart';
import 'package:pidos/src/data/remote/api_result.dart';
import 'package:pidos/src/domain/repository/transferencia_repository.dart';
import 'package:pidos/src/presentation/blocs/provider/my_base_bloc.dart';
import 'package:pidos/src/presentation/states/transferencia_message.dart';
import 'package:rxdart/rxdart.dart';

enum TipoTransferencia {
  pidPuntos,
  pidCash
}

final Map<TipoTransferencia, String> tipoTranferenciaNombre = {
  TipoTransferencia.pidPuntos: 'Puntos Pids',
  TipoTransferencia.pidCash: 'Pid Cash'
};

class TranferirBloc extends MyBaseBloc {

  final Function onSubmitTransferencia;
  final Function(int) onChangedcantidadEnPids;
  final Function(TipoTransferencia) onChangedtipoTransferecnia;
  final ValueStream<TipoTransferencia> tipoTransferencia$;
  final ValueStream<double> cantidadaEnPesos$;
  final ValueStream<int> cantidadEnPids$;
  final ValueStream<String> destinationPidId$;
  final Sink<double> cantidadaEnPesosSink$;
  final Function(String) onChangeDestinationPidId;
  final Stream<TransferenciaMessage> transferenciaMessage$;


  final Stream<bool> isLoadingTransferencia$;

  TranferirBloc._({
    this.onSubmitTransferencia,
    this.onChangedcantidadEnPids,
    this.onChangedtipoTransferecnia,
    this.onChangeDestinationPidId,
    this.isLoadingTransferencia$,
    this.tipoTransferencia$,
    this.cantidadaEnPesos$,
    this.cantidadaEnPesosSink$,
    this.cantidadEnPids$,
    this.destinationPidId$,
    this.transferenciaMessage$,

    //dispose
    @required Function dispose,
  }) : super(dispose);


  factory TranferirBloc({
    TransferenciaRepository transferenciaRepository
  }) {

    //controller 
    final onSubmitTransferenciaController = PublishSubject<void>();
    final isLoadingTransferenciaController = PublishSubject<bool>();
    final cantidadEnPidsController = BehaviorSubject<int>();
    final tipoTransferecniaController = BehaviorSubject<TipoTransferencia>.seeded(TipoTransferencia.pidPuntos);
    final cantidadaEnPesosController = PublishSubject<double>();
    final destinationPidIdController = BehaviorSubject<String>();
    

    //streams
    final transferenciaMessage$ = onSubmitTransferenciaController
      .exhaustMap((_) => _realizarTransferencia(
        transferenciaRepository: transferenciaRepository,
        isLoadingSink$: isLoadingTransferenciaController.sink,
        tipoTransferencia: tipoTransferecniaController.value,
        cantidadEnPids: cantidadEnPidsController.value,
        destinationPidId: destinationPidIdController.value))
      .share()
      .publish();
    final tipoTransferencia$ = tipoTransferecniaController.shareValue();
    final cantidadaEnPesos$ = cantidadaEnPesosController.shareValueSeeded(0.0);
    final cantidadEnPids$ = cantidadEnPidsController.shareValueSeeded(0);
    final destinationPidId$ = destinationPidIdController.shareValue();


    //subscriptions
    final subscriptions = <StreamSubscription>[
      transferenciaMessage$.listen((message) => print('[TRANSFERIR_BLOC] message=$message')),
      tipoTransferencia$.listen((value) => print('[TRANSFERIR_BLOC] tipoTransferencia=$value')),
      cantidadEnPidsController.listen((value) => print('[TRANSFERIR_BLOC] cantidadEnPids=$value')),
      destinationPidIdController.listen((value) => print('[TRANSFERIR_BLOC] destinationPidId=$value')),
      cantidadaEnPesos$.listen((value) => print('[TRANSFERIR_BLOC] cantidadaEnPesos=$value')),
      cantidadEnPids$.listen((value) => print('[TRANSFERIR_BLOC] cantidadEnPids=$value')),
      destinationPidId$.listen((value) => print('[TRANSFERIR_BLOC] destinationPidId=$value')),
      
      transferenciaMessage$.connect(),
    ];


    ///Dispose
    final dispose = () async {
      await Future.wait(subscriptions.map((s) => s.cancel()));
      await Future.wait([
        onSubmitTransferenciaController.close(),
        cantidadEnPidsController.close(),
        tipoTransferecniaController.close(),
        cantidadaEnPesosController.close(),
        destinationPidIdController.close(),
        isLoadingTransferenciaController.close(),
      ]);
      print('[TRANFERIR_BLOC] dispose');
    };

    return TranferirBloc._(
      dispose: dispose,
      onSubmitTransferencia: () => onSubmitTransferenciaController.add(null),
      onChangedcantidadEnPids: cantidadEnPidsController.sink.add,
      onChangedtipoTransferecnia: tipoTransferecniaController.sink.add,
      onChangeDestinationPidId: destinationPidIdController.sink.add,
      isLoadingTransferencia$: isLoadingTransferenciaController.stream,
      tipoTransferencia$: tipoTransferencia$,
      cantidadaEnPesos$: cantidadaEnPesos$,
      cantidadaEnPesosSink$: cantidadaEnPesosController.sink,
      cantidadEnPids$: cantidadEnPids$,
      destinationPidId$: destinationPidId$,
      transferenciaMessage$: transferenciaMessage$
    );

  }


  //static methods
  static Stream<TransferenciaMessage> _realizarTransferencia({
    TransferenciaRepository transferenciaRepository,
    Sink<bool> isLoadingSink$,
    TipoTransferencia tipoTransferencia,
    String destinationPidId,
    int cantidadEnPids
  }) async* {
    try{
      isLoadingSink$.add(true);
      ApiResult<TransferenciaMessage> resp;
      if( tipoTransferencia == TipoTransferencia.pidPuntos ){
        resp = await transferenciaRepository.tranferirPidPuntos(
          pid: cantidadEnPids,
          documentDestination: destinationPidId
        );
      }else{
        resp = await transferenciaRepository.tranferirPidCash(
          pidCash: cantidadEnPids,
          documentDestination: destinationPidId
        );
      }
      yield* resp.maybeWhen(
        success: (message) async* {
          yield message;
        },
        orElse: () async * {
          yield const TransferenciaErrorMessage();
        }
      );

    }catch(err){
      String error = _handleExceptionMessage(err);
      yield TransferenciaErrorMessage(error);
    }finally{
      isLoadingSink$.add(false);
    }
  }

   //metodo que maneja excepciones
  static String _handleExceptionMessage(dynamic err){
    final networkE = NetworkExceptions.getDioException(err);
    String error = '';
    networkE.maybeWhen(
      noInternetConnection: () => error = 'No hay conexion a internet',
      unauthorizedRequest: () => error = 'Credenciales invalidas',
      orElse: () {
        error = NetworkExceptions.getErrorMessage(networkE);
      }
    );
    return error;
  }



}