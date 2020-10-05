import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pidos/src/data/exceptions/network_exceptions.dart';
import 'package:pidos/src/domain/models/usuario.dart';
import 'package:pidos/src/domain/repository/usuario_repository.dart';
import 'package:pidos/src/presentation/blocs/provider/my_base_bloc.dart';
import 'package:pidos/src/presentation/states/login_message.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends MyBaseBloc {

  final Function doLogin;
  final Function logout;
  final Function(String) onChangeNroCelular;
  final Function(String) onChangeContrasena;
  final Stream<bool> isLoading$;
  final Stream<LoginMessage> loginMessage$;

  LoginBloc._({
    this.doLogin,
    this.logout,
    this.onChangeNroCelular,
    this.onChangeContrasena,
    this.isLoading$,
    this.loginMessage$,
    //dipose
    @required Function dispose
  }) : super(dispose);




  factory LoginBloc({
    UsuarioRepository usuarioRepository
  }){

    //controllers
    final _doLoginController = PublishSubject<void>();
    final _loguoutController = PublishSubject<void>();
    final nroCelularController = BehaviorSubject<String>.seeded('');
    final contrasenaController = BehaviorSubject<String>.seeded('');
    final isLoadingController = PublishSubject<bool>();

    //streams
    final loginaMessage$ = _doLoginController
      .exhaustMap((_) => _doLoginHandle(
        usuarioRepository: usuarioRepository,
        nroCelular: nroCelularController.value,
        contrasena: contrasenaController.value,
        isLoadingSink: isLoadingController.sink))
      .share()
      .publish();

    final _logutMessage$ = _loguoutController
      .exhaustMap((value) => _logout(usuarioRepository: usuarioRepository))
      .share()
      .publish();



    //subscriptions
    final subscriptions = <StreamSubscription>[
      nroCelularController.listen((value) => print('[LOGIN_BLOC] nroCelular=$value')),
      contrasenaController.listen((value) => print('[LOGIN_BLOC] contrasena=$value')),
      loginaMessage$.listen((message) => print('[LOGIN_BLOC] message$message')),
      _logutMessage$.listen((message) => print('[LOGIN_BLOC] message$message')),
      
      loginaMessage$.connect(),
      _logutMessage$.connect(),
    ];


    ///Dispose
    final dispose = () async {
      await Future.wait(subscriptions.map((s) => s.cancel()));
      await Future.wait([
        _doLoginController.close(),
        nroCelularController.close(),
        contrasenaController.close(),
        isLoadingController.close(),
        _loguoutController.close(),
      ]);
      print('[LOGIN_BLOC] dispose');
    };

    return LoginBloc._(
      doLogin: () => _doLoginController.add(null),
      onChangeNroCelular: nroCelularController.sink.add,
      onChangeContrasena: contrasenaController.sink.add,
      isLoading$: isLoadingController.stream,
      loginMessage$: loginaMessage$,
      logout: () => _loguoutController.add(null),
      dispose: dispose
    );

  }


  

  //static methods
  static Stream<LoginMessage> _doLoginHandle({
    UsuarioRepository usuarioRepository,
    String nroCelular,
    String contrasena,
    Sink<bool> isLoadingSink
  }) async* { 
    try{
      isLoadingSink.add(true);
      final response = await usuarioRepository.login(
        Usuario((b) => b
          ..nroCelular = nroCelular
          ..contrasena = contrasena)
      );
      yield* response.maybeWhen(
        success: (message) async* {
          yield message;
        },
        orElse: () async * {
          yield const LoginErrorMessage();
        }
      );
      // yield response;
    }catch(err){
      String error = _handleExceptionMessage(err);
      yield LoginErrorMessage(error);
    }finally{
      isLoadingSink.add(false);
    }
  }

  static Stream<LoginMessage> _logout({
    UsuarioRepository usuarioRepository
  }) async* {
    try{
      final result = await usuarioRepository.logut();
      if(result){
        yield const LogoutSuccessMessage();
      }else{
        yield const LogoutErrorMessage();
      }
    }catch(err){
      yield LogoutErrorMessage(err);
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
        error = NetworkExceptions.getErrorMessage(err);
      }
    );
    return error;
  }



}