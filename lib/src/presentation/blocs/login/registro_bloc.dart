

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pidos/src/data/exceptions/network_exceptions.dart';
import 'package:pidos/src/domain/models/usuario.dart';
import 'package:pidos/src/domain/repository/usuario_repository.dart';
import 'package:pidos/src/presentation/blocs/provider/my_base_bloc.dart';
import 'package:pidos/src/presentation/states/registro_message.dart';
import 'package:rxdart/rxdart.dart';

class RegistroBloc extends MyBaseBloc {

  final Function  onSubmit;
  final Stream<bool> isLoading$;
  final Stream<RegistroMessage> registroMessage$;

  final Function(String) onChangedNombre;
  final Function(String) onChangedApellido;
  final Function(String) onChangedEmail;
  final Function(String) onChangedNroDocumento;
  final Function(String) onChangedContrasena;
  final Function(String) onChangedRepetirContrasena;

  final ValueStream<String> nombre$;
  final ValueStream<String> apellido$;
  final ValueStream<String> email$;
  final ValueStream<String> nroDocumento$;
  final ValueStream<String> contrasena$;
  final ValueStream<String> repetirContrasena$;
  


  RegistroBloc._({
    this.onSubmit,
    this.isLoading$,
    this.registroMessage$,

    this.onChangedNombre,
    this.onChangedApellido,
    this.onChangedEmail,
    this.onChangedNroDocumento,
    this.onChangedContrasena,
    this.onChangedRepetirContrasena,

    this.nombre$,
    this.apellido$,
    this.email$,
    this.nroDocumento$,
    this.contrasena$,
    this.repetirContrasena$,
    //dispose
    @required Function dispose,
  }) : super(dispose);

  factory RegistroBloc({
    UsuarioRepository usuarioRepository,
  }){
    
    //controllers
    final onSubmitController = PublishSubject<void>();
    final isLoadingController = PublishSubject<bool>();
    final nombreController = BehaviorSubject<String>();
    final apellidoController = BehaviorSubject<String>();
    final emailController = BehaviorSubject<String>();
    final nroDocumentoController = BehaviorSubject<String>();
    final contrasenaController = BehaviorSubject<String>();
    final repetirContrasenaController = BehaviorSubject<String>();


    //streams
    final registroMessage$ = onSubmitController
      .exhaustMap((_) => _onSubmitForm(
        usuarioRepository: usuarioRepository,
        isLoadingSink$: isLoadingController.sink,
        nombre: nombreController.value,
        apellido: apellidoController.value,
        email: emailController.value,
        nroDocumento: nroDocumentoController.value,
        contrasena: contrasenaController.value,
        repetirContrasena: repetirContrasenaController.value))
      .share()
      .publish();
    final nombre$ = nombreController.shareValue();
    final apellido$ = apellidoController.shareValue();
    final email$ = emailController.shareValue();
    final nroDocumento$ = nroDocumentoController.shareValue();
    final contrasena$ = contrasenaController.shareValue();
    final repetirContrasena$ = repetirContrasenaController.shareValue();
    
    
    //subscriptions
    final subscriptions = <StreamSubscription>[
      nombre$.listen((value) => print('[LOGIN_BLOC] nombre=$value')),
      apellido$.listen((value) => print('[LOGIN_BLOC] apellido=$value')),
      email$.listen((value) => print('[LOGIN_BLOC] email=$value')),
      nroDocumento$.listen((value) => print('[LOGIN_BLOC] nroDocumento=$value')),
      contrasena$.listen((value) => print('[LOGIN_BLOC] contrasena=$value')),
      repetirContrasena$.listen((value) => print('[LOGIN_BLOC] repetirContrasena=$value')),
      registroMessage$.listen((message) => print('[LOGIN_BLOC] registroMessage=$message')),
      registroMessage$.connect(),
    ];


    ///Dispose
    final dispose = () async {
      await Future.wait(subscriptions.map((s) => s.cancel()));
      await Future.wait([
        onSubmitController.close(),
        isLoadingController.close(),
        nombreController.close(),
        apellidoController.close(),
        emailController.close(),
        nroDocumentoController.close(),
        contrasenaController.close(),
        repetirContrasenaController.close(),
      ]);
      print('[LOGIN_BLOC] dispose');
    };

    return RegistroBloc._(
      dispose: dispose,
      onSubmit: () => onSubmitController.add(null),
      isLoading$: isLoadingController.stream,
      registroMessage$: registroMessage$,
      onChangedNombre: nombreController.sink.add,
      onChangedApellido: apellidoController.sink.add,
      onChangedEmail: emailController.sink.add,
      onChangedNroDocumento: nroDocumentoController.sink.add,
      onChangedContrasena: contrasenaController.sink.add,
      onChangedRepetirContrasena: repetirContrasenaController.sink.add,

      nombre$: nombre$,
      apellido$: apellido$,
      email$: email$,
      nroDocumento$: nroDocumento$,
      contrasena$: contrasena$,
      repetirContrasena$: repetirContrasena$,
    );

  }


  //static method
  static Stream<RegistroMessage> _onSubmitForm({
    UsuarioRepository usuarioRepository,
    Sink<bool> isLoadingSink$,
    String nombre,
    String apellido,
    String email,
    String nroDocumento,
    String contrasena,
    String repetirContrasena,
  }) async* {
    try{
      isLoadingSink$.add(true);
      final resp = await usuarioRepository.registroUsuario(Usuario((b) => b
        ..firstName = nombre
        ..lastName = apellido
        ..email = email
        ..document = num.parse(nroDocumento)
        ..contrasena = contrasena));

      yield* resp.maybeWhen(
        success: (message) async* {
          yield message;
        },
        orElse: () async * {
          yield const RegistroErrorMessage();
        }
      );
      
    }catch(err){
      String error = _handleExceptionMessage(err);
      yield RegistroErrorMessage(error);
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
        error = NetworkExceptions.getErrorMessage(networkE);
      }
    );
    return error;
  }

}