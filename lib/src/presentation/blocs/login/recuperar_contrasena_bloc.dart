
import 'dart:async';

import 'package:meta/meta.dart';
import 'package:pidos/src/data/exceptions/network_exceptions.dart';
import 'package:pidos/src/domain/repository/usuario_repository.dart';
import 'package:pidos/src/presentation/blocs/provider/my_base_bloc.dart';
import 'package:pidos/src/presentation/states/recuperar_contrasena_message.dart';
import 'package:rxdart/rxdart.dart';
// import 'package:distinct_value_connectable_stream/distinct_value_connectable_stream.dart';

class RecuperarContrasenaBloc extends MyBaseBloc {

  final Function(String) onChangedEmail;
  final ValueStream<String> email$;
  final Stream<bool> isLoading$;
  final Function onSubmit;
  final Stream<RecuperarContrasenaMessage> recuperarContrasenaMessage$;

  RecuperarContrasenaBloc._({
    this.onChangedEmail,
    this.email$, 
    this.isLoading$,
    this.onSubmit,
    this.recuperarContrasenaMessage$,
    //dispose
    @required Function dispose,
  }) : super(dispose);




  factory RecuperarContrasenaBloc({
    UsuarioRepository usuarioRepository,
  }) {
    //controllers
    final emailController = BehaviorSubject<String>();
    final onSubmitController = PublishSubject<void>();
    final isLoadingController = PublishSubject<bool>();

    //streams
    final recuperarContrasenaMessage$ = onSubmitController
      .exhaustMap((_) => _recuperarContrasena(
        usuarioRepository: usuarioRepository,
        isLoadingSink$: isLoadingController.sink,
        email: emailController.value))
      .share()
      .publish();

    final email$ = emailController.shareValue();

    //subscriptions
    final subscriptions = <StreamSubscription>[
      recuperarContrasenaMessage$.listen((message) => print('[RECUPERAR_CONTRASENA_BLOC] message=$message')),
      email$.listen((value) => print('[RECUPERAR_CONTRASENA_BLOC] email=$value')),
      
      recuperarContrasenaMessage$.connect(),
    ];

    ///Dispose
    final dispose = () async {
      await Future.wait(subscriptions.map((s) => s.cancel()));
      await Future.wait([
        emailController.close(),
        onSubmitController.close(),
        isLoadingController.close(),
      ]);
      print('[RECUPERAR_CONTRASENA_BLOC] dispose');
    };

    return RecuperarContrasenaBloc._(
      dispose: dispose,
      email$: email$,
      isLoading$: isLoadingController.stream,
      onChangedEmail: emailController.sink.add,
      onSubmit: () => onSubmitController.add(null),
      recuperarContrasenaMessage$: recuperarContrasenaMessage$
    );

  }

  //static methods
  static Stream<RecuperarContrasenaMessage> _recuperarContrasena({
    UsuarioRepository usuarioRepository,
    Sink<bool> isLoadingSink$,
    String email,
  }) async* {
    try{
      isLoadingSink$.add(true);
      final response = await usuarioRepository.recuperarContrasena(email);
      if( response!=null ){
        yield* response.maybeWhen(
          success: (message) async* {
            yield message;
          },
          orElse: () async * {
            yield const RecuperarContrasenaErrorMessage();
          }
        );
      }else{
        yield const RecuperarContrasenaErrorMessage();
      }
    }catch(err){ 
      String error = _handleExceptionMessage(err);
      yield RecuperarContrasenaErrorMessage(error);
    }finally{
      isLoadingSink$.add(false);
    }
  }


  //metodo que maneja excepciones
  static String _handleExceptionMessage(dynamic err){
    final networkE = NetworkExceptions.getDioException(err);
    String error = '';
    networkE.maybeWhen(
      // unauthorizedRequest: () => error = 'Credenciales invalidas',
      noInternetConnection: () => error = 'No hay conexion a internet',
      orElse: () {
        error = NetworkExceptions.getErrorMessage(err);
      }
    );
    return error;
  }




}