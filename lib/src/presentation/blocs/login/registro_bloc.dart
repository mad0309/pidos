import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pidos/src/data/exceptions/network_exceptions.dart';
import 'package:pidos/src/domain/models/usuario.dart';
import 'package:pidos/src/domain/repository/usuario_repository.dart';
import 'package:pidos/src/presentation/blocs/provider/my_base_bloc.dart';
import 'package:pidos/src/presentation/states/registro_message.dart';
import 'package:rxdart/rxdart.dart';

class RegistroBloc extends MyBaseBloc {
  final Function onSubmit;
  final Stream<bool> isLoading$;
  final Stream<RegistroMessage> registroMessage$;

  final Function(String) onChangedNombre;
  final Function(String) onChangedApellido;
  final Function(String) onChangedEmail;
  final Function(String) onChangedNroDocumento;
  final Function(String) onChangedContrasena;
  final Function(String) onChangedRepetirContrasena;
  final Function(TipoRegistro) onChangedTipoRegistro;
  final Function(String) onChangedRazonSocial;
  final Function(String) onChangedNit;
  final Function(String) onChangedCorreoEmpresa;
  final Function(String) onChangedContrasenaEmpresa;
  final Function(String) onChangedRepetirContrasenaEmpresa;
  final Function(String) onChangedcodigoDeVendedor;
  final Function(File) onChangedRUT;
  final Function(File) onChangedCamaraDeComercio;
  final Function(File) onChangedCedula;
  final Function(File) onChangedLogo;

  final ValueStream<String> nombre$;
  final ValueStream<String> apellido$;
  final ValueStream<String> email$;
  final ValueStream<String> nroDocumento$;
  final ValueStream<String> contrasena$;
  final ValueStream<String> repetirContrasena$;
  final ValueStream<TipoRegistro> tipoRegistro$;

  final Function cleanControllers;
  final Stream<void> cleanControllers$;

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
    this.onChangedTipoRegistro,
    this.onChangedRazonSocial,
    this.onChangedNit,
    this.onChangedCorreoEmpresa,
    this.onChangedContrasenaEmpresa,
    this.onChangedRepetirContrasenaEmpresa,
    this.onChangedcodigoDeVendedor,
    this.onChangedRUT,
    this.onChangedCamaraDeComercio,
    this.onChangedCedula,
    this.onChangedLogo,
    this.nombre$,
    this.apellido$,
    this.email$,
    this.nroDocumento$,
    this.contrasena$,
    this.repetirContrasena$,
    this.tipoRegistro$,
    this.cleanControllers,
    this.cleanControllers$,
    //dispose
    @required Function dispose,
  }) : super(dispose);

  factory RegistroBloc({
    UsuarioRepository usuarioRepository,
  }) {
    //controllers
    final onSubmitController = PublishSubject<void>();
    final isLoadingController = PublishSubject<bool>();
    final nombreController = BehaviorSubject<String>();
    final apellidoController = BehaviorSubject<String>();
    final emailController = BehaviorSubject<String>();
    final nroDocumentoController = BehaviorSubject<String>();
    final contrasenaController = BehaviorSubject<String>();
    final repetirContrasenaController = BehaviorSubject<String>();
    final tipoRegistroController =
        BehaviorSubject<TipoRegistro>.seeded(TipoRegistro.persona);

    final razonSocialController = BehaviorSubject<String>();
    final nitController = BehaviorSubject<String>();
    final correoEmpresaController = BehaviorSubject<String>();
    final contrasenaEmpresaController = BehaviorSubject<String>();
    final repetirContrasenaEmpresaController = BehaviorSubject<String>();
    final codigoDeVendedorController = BehaviorSubject<String>();
    final rutController = BehaviorSubject<File>();
    final camaraDeComercioController = BehaviorSubject<File>();
    final cedulaController = BehaviorSubject<File>();
    final logoController = BehaviorSubject<File>();

    final cleanControllersController = PublishSubject<void>();

    //streams
    final registroMessage$ = onSubmitController
        .exhaustMap((_) {
          if (tipoRegistroController.value == TipoRegistro.persona) {
            return _onSubmitForm(
                usuarioRepository: usuarioRepository,
                isLoadingSink$: isLoadingController.sink,
                nombre: nombreController.value,
                apellido: apellidoController.value,
                email: emailController.value,
                nroDocumento: nroDocumentoController.value,
                contrasena: contrasenaController.value,
                repetirContrasena: repetirContrasenaController.value);
          } else {
            return _onSubmitFormEmpresa(
                usuarioRepository: usuarioRepository,
                isLoadingSink$: isLoadingController.sink,
                razonSocial: razonSocialController.value,
                nit: nitController.value,
                correoEmpresa: correoEmpresaController.value,
                contrasenaEmpresa: contrasenaEmpresaController.value,
                confirmarContrasenaEmpresa:
                    repetirContrasenaEmpresaController.value,
                codigoDeVendedor: codigoDeVendedorController.value,
                rut: rutController.value,
                camaraDeComercio: camaraDeComercioController.value,
                cedula: cedulaController.value,
                logo: logoController.value);
          }
        })
        .share()
        .publish();
    final nombre$ = nombreController.shareValue();
    final apellido$ = apellidoController.shareValue();
    final email$ = emailController.shareValue();
    final nroDocumento$ = nroDocumentoController.shareValue();
    final contrasena$ = contrasenaController.shareValue();
    final repetirContrasena$ = repetirContrasenaController.shareValue();
    final tipoRegistro$ = tipoRegistroController.distinct().shareValue();
    final cleanControllers$ = cleanControllersController.share();

    //subscriptions
    final subscriptions = <StreamSubscription>[
      nombre$.listen((value) => print('[REGISTRO_BLOC] nombre=$value')),
      apellido$.listen((value) => print('[REGISTRO_BLOC] apellido=$value')),
      email$.listen((value) => print('[REGISTRO_BLOC] email=$value')),
      nroDocumento$
          .listen((value) => print('[REGISTRO_BLOC] nroDocumento=$value')),
      contrasena$.listen((value) => print('[REGISTRO_BLOC] contrasena=$value')),
      repetirContrasena$
          .listen((value) => print('[REGISTRO_BLOC] repetirContrasena=$value')),
      tipoRegistro$
          .listen((value) => print('[REGISTRO_BLOC] tipoRegistro=$value')),
      registroMessage$.listen(
          (message) => print('[REGISTRO_BLOC] registroMessage=$message')),
      cleanControllers$
          .listen((_) => print('[REGISTRO_BLOC] cleanControllers executed')),
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
        tipoRegistroController.close(),
        cleanControllersController.close(),
        razonSocialController.close(),
        nitController.close(),
        correoEmpresaController.close(),
        contrasenaEmpresaController.close(),
        repetirContrasenaEmpresaController.close(),
        codigoDeVendedorController.close(),
        rutController.close(),
        camaraDeComercioController.close(),
        cedulaController.close(),
        logoController.close(),
      ]);
      print('[REGISTRO_BLOC] dispose');
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
        onChangedTipoRegistro: tipoRegistroController.sink.add,
        onChangedRazonSocial: razonSocialController.sink.add,
        onChangedNit: nitController.sink.add,
        onChangedCorreoEmpresa: correoEmpresaController.sink.add,
        onChangedContrasenaEmpresa: contrasenaEmpresaController.sink.add,
        onChangedRepetirContrasenaEmpresa:
            repetirContrasenaEmpresaController.sink.add,
        onChangedcodigoDeVendedor: codigoDeVendedorController.sink.add,
        onChangedRUT: rutController.sink.add,
        onChangedCamaraDeComercio: camaraDeComercioController.sink.add,
        onChangedCedula: cedulaController.sink.add,
        onChangedLogo: logoController.sink.add,
        nombre$: nombre$,
        apellido$: apellido$,
        email$: email$,
        nroDocumento$: nroDocumento$,
        contrasena$: contrasena$,
        repetirContrasena$: repetirContrasena$,
        tipoRegistro$: tipoRegistro$,
        cleanControllers: () => cleanControllersController.add(null),
        cleanControllers$: cleanControllers$);
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
    try {
      isLoadingSink$.add(true);
      final resp = await usuarioRepository.registroUsuario(Usuario((b) => b
        ..firstName = nombre
        ..lastName = apellido
        ..email = email
        ..document = nroDocumento == null ? null : num.parse(nroDocumento)
        ..contrasena = contrasena));

      yield* resp.maybeWhen(success: (message) async* {
        yield message;
      }, orElse: () async* {
        yield const RegistroErrorMessage();
      });
    } catch (err) {
      String error = _handleExceptionMessage(err);
      yield RegistroErrorMessage(error);
    } finally {
      isLoadingSink$.add(false);
    }
  }

  //static method
  static Stream<RegistroMessage> _onSubmitFormEmpresa(
      {UsuarioRepository usuarioRepository,
      Sink<bool> isLoadingSink$,
      String razonSocial,
      String nit,
      String correoEmpresa,
      String contrasenaEmpresa,
      String confirmarContrasenaEmpresa,
      String codigoDeVendedor,
      File rut,
      File camaraDeComercio,
      File cedula,
      File logo}) async* {
    try {
      isLoadingSink$.add(true);
      final resp = await usuarioRepository.registroEmpresa(
        razonSocial: razonSocial,
        nit: nit,
        correoEmpresa: correoEmpresa,
        contrasena: contrasenaEmpresa,
        codigoDeVendedor: codigoDeVendedor,
        rut: rut,
        camaraDeComercio: camaraDeComercio,
        cedula: cedula,
        logo: logo,
      );

      yield* resp.maybeWhen(success: (message) async* {
        yield message;
      }, orElse: () async* {
        yield const RegistroEmpresaErrorMessage();
      });
    } catch (err) {
      String error = _handleExceptionMessage(err);
      yield RegistroEmpresaErrorMessage(error);
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

  //Functions
  void cleanInputsText() {
    onChangedNombre('');
    onChangedApellido('');
    onChangedEmail('');
    onChangedNroDocumento('');
    onChangedContrasena('');
    onChangedRepetirContrasena('');

    // clean textEditingsControllers
    cleanControllers();
  }
}
