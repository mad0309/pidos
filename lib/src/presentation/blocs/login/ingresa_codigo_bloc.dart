

import 'dart:async';

import 'package:meta/meta.dart';
import 'package:pidos/src/data/exceptions/network_exceptions.dart';
import 'package:pidos/src/domain/models/usuario.dart';
import 'package:pidos/src/domain/repository/usuario_repository.dart';
import 'package:pidos/src/presentation/blocs/provider/my_base_bloc.dart';
import 'package:pidos/src/presentation/states/registro_message.dart';
import 'package:rxdart/rxdart.dart';

class IngresaCodigoBloc extends MyBaseBloc {

  final Stream<bool> isLoaindgIngresaCodigo$;
  final Stream<RegistroMessage> ingresarCodigoMessage$;

  final Function(String) onChangedPrimerDigito;
  final Function(String) onChangedSegundoDigito;
  final Function(String) onChangedTercerDigito;
  final Function(String) onChangedCuartoDigito;
  final Function(String) onChangedQuintoDigito;
  final Function(String) onChangedSextoDigito;

  IngresaCodigoBloc._({
    this.isLoaindgIngresaCodigo$,
    this.ingresarCodigoMessage$,
    this.onChangedPrimerDigito,
    this.onChangedSegundoDigito,
    this.onChangedTercerDigito,
    this.onChangedCuartoDigito,
    this.onChangedQuintoDigito,
    this.onChangedSextoDigito,

    //dipose
    @required Function dispose
  }) : super(dispose);

  factory IngresaCodigoBloc({
    UsuarioRepository usuarioRepository,
    Usuario usuarioInit,
  }) {

    //controller
    final onSubmitCodigoIngresadoController = PublishSubject<void>();
    final isLoadingCodigoIngresadoController = PublishSubject<bool>();
    final primerDigitoController = BehaviorSubject<String>();
    final segundoDigitoController = BehaviorSubject<String>();
    final tercerDigitoController = BehaviorSubject<String>();
    final cuartoDigitoController = BehaviorSubject<String>();
    final quintoDigitoController = BehaviorSubject<String>();
    final sextoDigitoController = BehaviorSubject<String>();

    //streams
    final isValidCode$ = Rx.combineLatest6(
      primerDigitoController, 
      segundoDigitoController, 
      tercerDigitoController, 
      cuartoDigitoController, 
      quintoDigitoController, 
      sextoDigitoController, 
      (a, b, c, d, e, f) {
        if( (a!=null && a.length>0) && (b!=null && b.length>0) && (c!=null && c.length>0) && (d!=null && d.length>0) && (e!=null && e.length>0) && (f!=null && f.length>0) )
        {
          onSubmitCodigoIngresadoController.add(null);
          return true;
        }else{
          return false;
        }
      }).shareValue();

    final ingresarCodigoMessage$ = onSubmitCodigoIngresadoController
      .exhaustMap((_) => checkCodigoIngresado(
        usuarioRepository: usuarioRepository,
        usuario: usuarioInit,
        isLoadingSink$: isLoadingCodigoIngresadoController.sink,
        primerDigito: primerDigitoController.value,
        segundoDigito: segundoDigitoController.value,
        tercerDigito: tercerDigitoController.value,
        cuartoDigito: cuartoDigitoController.value,
        quintoDigito: quintoDigitoController.value,
        sextoDigito: sextoDigitoController.value))
      .share()
      .publish();


    //subscriptions
    final subscriptions = <StreamSubscription>[
      ingresarCodigoMessage$.listen((message) => print('[INSGRESA_CODIGO_BLOC] ingresaCodigoMessage=$message')),
      isValidCode$.listen((value) => print('[INSGRESA_CODIGO_BLOC] isValidCode=$value')),
      primerDigitoController.listen((value) => print('[INSGRESA_CODIGO_BLOC] primerDigito=$value')),
      segundoDigitoController.listen((value) => print('[INSGRESA_CODIGO_BLOC] segundoDigito=$value')),
      tercerDigitoController.listen((value) => print('[INSGRESA_CODIGO_BLOC] tercerDigito=$value')),
      cuartoDigitoController.listen((value) => print('[INSGRESA_CODIGO_BLOC] cuartoDigito=$value')),
      quintoDigitoController.listen((value) => print('[INSGRESA_CODIGO_BLOC] quintoDigito=$value')),
      sextoDigitoController.listen((value) => print('[INSGRESA_CODIGO_BLOC] sextoDigito=$value')),
      
      ingresarCodigoMessage$.connect(),
    ];


    //Dispose
    final dispose = () async {
      await Future.wait(subscriptions.map((s) => s.cancel()));
      await Future.wait([
        primerDigitoController.close(),
        segundoDigitoController.close(),
        tercerDigitoController.close(),
        cuartoDigitoController.close(),
        quintoDigitoController.close(),
        sextoDigitoController.close(),
        onSubmitCodigoIngresadoController.close(),
        isLoadingCodigoIngresadoController.close(),
      ]);
      print('[INSGRESA_CODIGO_BLOC] dispose');
    };

    return IngresaCodigoBloc._(
      dispose: dispose,
      ingresarCodigoMessage$: ingresarCodigoMessage$,
      isLoaindgIngresaCodigo$: isLoadingCodigoIngresadoController.stream,
      onChangedPrimerDigito: primerDigitoController.sink.add,
      onChangedSegundoDigito: segundoDigitoController.sink.add,
      onChangedTercerDigito: tercerDigitoController.sink.add,
      onChangedCuartoDigito: cuartoDigitoController.sink.add,
      onChangedQuintoDigito: quintoDigitoController.sink.add,
      onChangedSextoDigito: sextoDigitoController.sink.add,
    );
  


  }

  void cleanControllers(){
    onChangedPrimerDigito('');
    onChangedSegundoDigito('');
    onChangedTercerDigito('');
    onChangedCuartoDigito('');
    onChangedQuintoDigito('');
    onChangedSextoDigito('');
  }


  //static methods
  static Stream<RegistroMessage> checkCodigoIngresado({
    UsuarioRepository usuarioRepository,
    Usuario usuario,
    Sink<bool> isLoadingSink$,
    String primerDigito,
    String segundoDigito,
    String tercerDigito,
    String cuartoDigito,
    String quintoDigito,
    String sextoDigito,
  }) async* {
    try{
      isLoadingSink$.add(true);
      final codigo = primerDigito + segundoDigito + tercerDigito + cuartoDigito + quintoDigito + sextoDigito;
      print('codigo Ingresado =$codigo');
      final resp = await usuarioRepository.checkCodigoInsertado(usuario, codigo);
      yield* resp.maybeWhen(
        success: (message) async* {
          yield message;
        },
        orElse: () async * {
          yield const CodigoIngresadoErrorMessage();
        }
      );
    }catch(err){  
      String error = _handleExceptionMessage(err);
      yield CodigoIngresadoErrorMessage(error);
    }finally{
      isLoadingSink$.add(false);
    }
    
  }


  //metodo que maneja excepciones
  static String _handleExceptionMessage(dynamic err){
    final networkE = NetworkExceptions.getDioException(err);
    String error = '';
    networkE.maybeWhen(
      unauthorizedRequest: () => error = 'Credenciales invalidas',
      noInternetConnection: () => error = 'No hay conexion a internet',
      orElse: () {
        error = 'Codigo Invalido';
      }
    );
    return error;
  }

}