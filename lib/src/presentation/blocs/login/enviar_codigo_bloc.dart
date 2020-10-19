import 'dart:async';

import 'package:meta/meta.dart';
import 'package:pidos/src/data/exceptions/network_exceptions.dart';
import 'package:pidos/src/domain/models/usuario.dart';
import 'package:pidos/src/domain/repository/usuario_repository.dart';

import 'package:pidos/src/presentation/blocs/provider/my_base_bloc.dart';
import 'package:pidos/src/presentation/states/registro_message.dart';
import 'package:rxdart/rxdart.dart';

class EnviarCodigoBloc extends MyBaseBloc {
  final Function onSubmitEnviarCodigo;
  final Function(String) onChangedNroCelular;
  final Stream<bool> isLoadingEnviarCodigo$;
  final Stream<RegistroMessage> enviarCodigoMessage$;
  final ValueStream<String> nroCelular$;

  EnviarCodigoBloc._(
      {this.onSubmitEnviarCodigo,
      this.onChangedNroCelular,
      this.isLoadingEnviarCodigo$,
      this.enviarCodigoMessage$,
      this.nroCelular$,

      //dispose
      @required Function dispose})
      : super(dispose);

  factory EnviarCodigoBloc(
      {UsuarioRepository usuarioRepository, Usuario usuarioInit}) {
    //controller
    final onSubmitEnviarCodigoController = PublishSubject<void>();
    final isLoadingEnviarCodigoController = PublishSubject<bool>();
    final nroCelularController = BehaviorSubject<String>();

    //streams
    final enviarCodigoMessage$ = onSubmitEnviarCodigoController
        .exhaustMap((_) => _enviarCodigo(
            usuarioRepository: usuarioRepository,
            isLoadingSink$: isLoadingEnviarCodigoController.sink,
            id: usuarioInit.id,
            email: usuarioInit.email,
            nroCelular: nroCelularController.value))
        .share()
        .publish();
    final nroCelular$ = nroCelularController.shareValue();

    //subscriptions
    final subscriptions = <StreamSubscription>[
      // nroCelularController.listen((value) => print('[LOGIN_BLOC] nroCelular=$value')),
      nroCelular$.listen((value) => print('[LOGIN_BLOC] nroCelular=$value')),
      enviarCodigoMessage$.listen(
          (message) => print('[LOGIN_BLOC] messageEnviarCodigo=$message')),

      enviarCodigoMessage$.connect(),
    ];

    //Dispose
    final dispose = () async {
      await Future.wait(subscriptions.map((s) => s.cancel()));
      await Future.wait([
        onSubmitEnviarCodigoController.close(),
        isLoadingEnviarCodigoController.close(),
        nroCelularController.close(),
      ]);
      print('[LOGIN_BLOC] dispose');
    };

    return EnviarCodigoBloc._(
        dispose: dispose,
        onSubmitEnviarCodigo: () => onSubmitEnviarCodigoController.add(null),
        isLoadingEnviarCodigo$: isLoadingEnviarCodigoController.stream,
        onChangedNroCelular: nroCelularController.sink.add,
        enviarCodigoMessage$: enviarCodigoMessage$,
        nroCelular$: nroCelular$);
  }

  //static methods
  static Stream<RegistroMessage> _enviarCodigo(
      {UsuarioRepository usuarioRepository,
      Sink<bool> isLoadingSink$,
      String nroCelular,
      String email,
      int id}) async* {
    try {
      isLoadingSink$.add(true);
      final resp = await usuarioRepository.enviarCodigo(Usuario((b) => b
        ..id = id
        ..email = email
        ..nroCelular = '+57$nroCelular'));
      yield* resp.maybeWhen(success: (message) async* {
        yield message;
      }, orElse: () async* {
        yield const EnviarCodigoErrorMessage();
      });
    } catch (err) {
      String error = _handleExceptionMessage(err);
      yield EnviarCodigoErrorMessage(error);
    } finally {
      isLoadingSink$.add(false);
    }
  }

  //metodo que maneja excepciones
  static String _handleExceptionMessage(dynamic err) {
    final networkE = NetworkExceptions.getDioException(err);
    String error = '';
    networkE.maybeWhen(
        unauthorizedRequest: () => error = 'Credenciales invalidas',
        noInternetConnection: () => error = 'No hay conexion a internet',
        orElse: () {
          error = NetworkExceptions.getErrorMessage(networkE);
        });
    return error;
  }
}
