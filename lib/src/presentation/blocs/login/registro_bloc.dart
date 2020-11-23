import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pidos/src/data/exceptions/network_exceptions.dart';
import 'package:pidos/src/domain/models/usuario.dart';
import 'package:pidos/src/domain/repository/usuario_repository.dart';
import 'package:pidos/src/presentation/blocs/provider/my_base_bloc.dart';
import 'package:pidos/src/presentation/blocs/validators/validator.dart';
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
<<<<<<< HEAD
  final Function(bool) onChangedTerminosYcondiciones;
  final Function(bool) onChangedTerminosYcondicionesEmpresa;
  
=======
>>>>>>> d85b15ece6c0f28f2fdf937ccf08f1a9a14e1e25

  final ValueStream<String> nombre$;
  final ValueStream<String> apellido$;
  final ValueStream<String> email$;
  final ValueStream<String> nroDocumento$;
  final ValueStream<String> contrasena$;
  final ValueStream<String> repetirContrasena$;
  final ValueStream<TipoRegistro> tipoRegistro$;
<<<<<<< HEAD
  final ValueStream<bool> terminosYcondiciones$;
  final ValueStream<bool> terminosYcondicionesEmpresa$;
  
  final Function cleanControllers;
  final Stream<void> cleanControllers$;

  final Stream<bool> isValidNombre$;
  final Stream<bool> isValidApellido$;
  final Stream<bool> isValidEmail$;
  final Stream<bool> isValidNroDocumento$;
  final Stream<bool> isValidContrasena$;

  final ValueStream<String> razonSocial$;
  final ValueStream<String> nit$;
  final ValueStream<String> correoEmpresa$;
  final ValueStream<String> contrasenaEmpresa$;
  final ValueStream<String> repetirContrasenaEmpresa$;
  final ValueStream<String> codigoDeVendedor$;
  final ValueStream<File> rut$;
  final ValueStream<File> camaraDeComercio$;
  final ValueStream<File> cedula$;
  final ValueStream<File> logo$;

  final Stream<bool> isValidRazonSocial$;
  final Stream<bool> isValidNit$;
  final Stream<bool> isValidCorreoEmpresa$;
  final Stream<bool> isValidContrasenaEmpresa$;
  final Stream<bool> isValidCodigoDeVendedor$;
  
 

=======

  final Function cleanControllers;
  final Stream<void> cleanControllers$;

>>>>>>> d85b15ece6c0f28f2fdf937ccf08f1a9a14e1e25
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
<<<<<<< HEAD
    this.onChangedTerminosYcondiciones,
    this.onChangedTerminosYcondicionesEmpresa,

=======
>>>>>>> d85b15ece6c0f28f2fdf937ccf08f1a9a14e1e25
    this.nombre$,
    this.apellido$,
    this.email$,
    this.nroDocumento$,
    this.contrasena$,
    this.repetirContrasena$,
    this.tipoRegistro$,
<<<<<<< HEAD
    this.terminosYcondiciones$,
    this.terminosYcondicionesEmpresa$,

=======
>>>>>>> d85b15ece6c0f28f2fdf937ccf08f1a9a14e1e25
    this.cleanControllers,
    this.cleanControllers$,

    this.isValidNombre$,
    this.isValidApellido$,
    this.isValidEmail$,
    this.isValidNroDocumento$,
    this.isValidContrasena$,

    this.razonSocial$,
    this.nit$,
    this.correoEmpresa$,
    this.contrasenaEmpresa$,
    this.repetirContrasenaEmpresa$,
    this.codigoDeVendedor$,
    this.rut$,
    this.camaraDeComercio$,
    this.cedula$,
    this.logo$,

    this.isValidRazonSocial$,
    this.isValidNit$,
    this.isValidCorreoEmpresa$,
    this.isValidContrasenaEmpresa$,
    this.isValidCodigoDeVendedor$,
    //dispose
    @required Function dispose,
  }) : super(dispose);

  factory RegistroBloc({
    UsuarioRepository usuarioRepository,
<<<<<<< HEAD
    Validators validators
  }){
    
=======
  }) {
>>>>>>> d85b15ece6c0f28f2fdf937ccf08f1a9a14e1e25
    //controllers
    final onSubmitController = PublishSubject<void>();

    final isLoadingController = PublishSubject<bool>();
    final nombreController = BehaviorSubject<String>();
    final apellidoController = BehaviorSubject<String>();
    final emailController = BehaviorSubject<String>();
    final nroDocumentoController = BehaviorSubject<String>();
    final contrasenaController = BehaviorSubject<String>();
    final repetirContrasenaController = BehaviorSubject<String>();
<<<<<<< HEAD
    final terminosYcondicionesController = BehaviorSubject<bool>.seeded(false);
    
    final tipoRegistroController = BehaviorSubject<TipoRegistro>.seeded(TipoRegistro.persona);
=======
    final tipoRegistroController =
        BehaviorSubject<TipoRegistro>.seeded(TipoRegistro.persona);
>>>>>>> d85b15ece6c0f28f2fdf937ccf08f1a9a14e1e25

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
    final terminosYcondicionesEmpresaController = BehaviorSubject<bool>.seeded(false);

    final cleanControllersController = PublishSubject<void>();

    //streams
    final registroMessage$ = onSubmitController
<<<<<<< HEAD
      .exhaustMap((_) {
        if( tipoRegistroController.value == TipoRegistro.persona ) {
          return _onSubmitForm(
            usuarioRepository: usuarioRepository,
            isLoadingSink$: isLoadingController.sink,
            nombre: nombreController.value,
            apellido: apellidoController.value,
            email: emailController.value,
            nroDocumento: nroDocumentoController.value,
            contrasena: contrasenaController.value,
            repetirContrasena: repetirContrasenaController.value,
            terminosYcondiciones: terminosYcondicionesController.value);
        }else{
          return _onSubmitFormEmpresa(
            usuarioRepository: usuarioRepository,
            isLoadingSink$: isLoadingController.sink,
            razonSocial: razonSocialController.value,
            nit: nitController.value,
            correoEmpresa: correoEmpresaController.value,
            contrasenaEmpresa: contrasenaEmpresaController.value,
            confirmarContrasenaEmpresa: repetirContrasenaEmpresaController.value,
            codigoDeVendedor: codigoDeVendedorController.value,
            rut: rutController.value,
            camaraDeComercio: camaraDeComercioController.value,
            cedula: cedulaController.value,
            logo: logoController.value,
            terminosYcondiciones: terminosYcondicionesEmpresaController.value);
        }
      })
      .share()
      .publish();
=======
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
>>>>>>> d85b15ece6c0f28f2fdf937ccf08f1a9a14e1e25
    final nombre$ = nombreController.shareValue();
    final apellido$ = apellidoController.shareValue();
    final email$ = emailController.shareValue();
    final nroDocumento$ = nroDocumentoController.shareValue();
    final contrasena$ = contrasenaController.shareValue();
    final repetirContrasena$ = repetirContrasenaController.shareValue();
    final tipoRegistro$ = tipoRegistroController.distinct().shareValue();
    final cleanControllers$ = cleanControllersController.share();

<<<<<<< HEAD
    final razonSocial$ = razonSocialController.shareValue();
    final nit$ = nitController.shareValue();
    final correoEmpresa$ = correoEmpresaController.shareValue();
    final contrasenaEmpresa$ = contrasenaEmpresaController.shareValue();
    final repetirContrasenaEmpresa$ = repetirContrasenaEmpresaController.shareValue();
    final codigoDeVendedor$ = codigoDeVendedorController.shareValue();
    final rut$ = rutController.shareValue();
    final camaraDeComercio$ = camaraDeComercioController.shareValue();
    final cedula$ = cedulaController.shareValue();
    final logo$ = logoController.shareValue();

    //Empresa
    final terminosYcondiciones$ = terminosYcondicionesController.shareValue();
    final terminosYcondicionesEmpresa$ = terminosYcondicionesEmpresaController.shareValue();


    //VALIDATORS
    final isValidNombre$ = nombre$.transform(validators.validatorNombre);
    final isValidApellido$ = apellido$.transform(validators.validatorApellido);
    final isValidEmail$ = email$.transform(validators.validatorEmail);
    final isValidNroDocumento$ = nroDocumento$.transform(validators.validatorNroDoucumento);
    final isValidContrasena$ = contrasena$.transform(validators.validatorContrasena);

    final isValidRazonSocial$ = razonSocial$.transform(validators.validatorNombre);
    final isValidNit$ = nit$.transform(validators.validatorNit);
    final isValidCorreoEmpresa$ = correoEmpresa$.transform(validators.validatorEmail);
    final isValidContrasenaEmpresa$ = contrasenaEmpresa$.transform(validators.validatorContrasena);
    final isValidCodigoDeVendedor$ = codigoDeVendedor$.transform(validators.validatorCodigoVendedor);
    
=======
>>>>>>> d85b15ece6c0f28f2fdf937ccf08f1a9a14e1e25
    //subscriptions
    final subscriptions = <StreamSubscription>[
      nombre$.listen((value) => print('[REGISTRO_BLOC] nombre=$value')),
      apellido$.listen((value) => print('[REGISTRO_BLOC] apellido=$value')),
      email$.listen((value) => print('[REGISTRO_BLOC] email=$value')),
      nroDocumento$
          .listen((value) => print('[REGISTRO_BLOC] nroDocumento=$value')),
      contrasena$.listen((value) => print('[REGISTRO_BLOC] contrasena=$value')),
<<<<<<< HEAD
      repetirContrasena$.listen((value) => print('[REGISTRO_BLOC] repetirContrasena=$value')),
      tipoRegistro$.listen((value) => print('[REGISTRO_BLOC] tipoRegistro=$value')),
      terminosYcondiciones$.listen((value) => print('[REGISTRO_BLOC] terminosYcondiciones=$value')),
      terminosYcondicionesEmpresa$.listen((value) => print('[REGISTRO_BLOC] terminosYcondicionesEmpresa=$value')),
      registroMessage$.listen((message) => print('[REGISTRO_BLOC] registroMessage=$message')),
      isValidNombre$.listen((value) => print('[REGISTRO_BLOC] isValidNombre=$value')),
      isValidApellido$.listen((value) => print('[REGISTRO_BLOC] isValidApellido=$value')),
      isValidEmail$.listen((value) => print('[REGISTRO_BLOC] isValidEmail=$value')),
      isValidNroDocumento$.listen((value) => print('[REGISTRO_BLOC] isValidNroDocumento=$value')),
      isValidContrasena$.listen((value) => print('[REGISTRO_BLOC] isValidContrasena=$value')),
      cleanControllers$.listen((_) => print('[REGISTRO_BLOC] cleanControllers executed')),

      razonSocial$.listen((value) => print('[REGISTRO_BLOC] razonSocial=$value')),
      nit$.listen((value) => print('[REGISTRO_BLOC] nit=$value')),
      correoEmpresa$.listen((value) => print('[REGISTRO_BLOC] correoEmpresa=$value')),
      contrasenaEmpresa$.listen((value) => print('[REGISTRO_BLOC] contrasenaEmpresa=$value')),
      repetirContrasenaEmpresa$.listen((value) => print('[REGISTRO_BLOC] repetirContrasenaEmpresa=$value')),
      codigoDeVendedor$.listen((value) => print('[REGISTRO_BLOC] codigoDeVendedor=$value')),
      rut$.listen((value) => print('[REGISTRO_BLOC] rut=${value?.path ?? ''}')),
      camaraDeComercio$.listen((value) => print('[REGISTRO_BLOC] camaraDeComercio=${value?.path ?? ''}')),
      cedula$.listen((value) => print('[REGISTRO_BLOC] cedula=${value?.path ?? ''}')),
      logo$.listen((value) => print('[REGISTRO_BLOC] logo=${value?.path ?? ''}')),

      isValidRazonSocial$.listen((value) => print('[REGISTRO_BLOC] isValidRazonSocial=$value')),
      isValidNit$.listen((value) => print('[REGISTRO_BLOC] isValidNit=$value')),
      isValidCorreoEmpresa$.listen((value) => print('[REGISTRO_BLOC] isValidCorreoEmpresa=$value')),
      isValidContrasenaEmpresa$.listen((value) => print('[REGISTRO_BLOC] isValidContrasenaEmpresa=$value')),
      isValidCodigoDeVendedor$.listen((value) => print('[REGISTRO_BLOC] isValidCodigoDeVendedor=$value')),
      
=======
      repetirContrasena$
          .listen((value) => print('[REGISTRO_BLOC] repetirContrasena=$value')),
      tipoRegistro$
          .listen((value) => print('[REGISTRO_BLOC] tipoRegistro=$value')),
      registroMessage$.listen(
          (message) => print('[REGISTRO_BLOC] registroMessage=$message')),
      cleanControllers$
          .listen((_) => print('[REGISTRO_BLOC] cleanControllers executed')),
>>>>>>> d85b15ece6c0f28f2fdf937ccf08f1a9a14e1e25
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
        terminosYcondicionesController.close(),
        terminosYcondicionesEmpresaController.close(),
      ]);
      print('[REGISTRO_BLOC] dispose');
    };

    return RegistroBloc._(
<<<<<<< HEAD
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
      onChangedTerminosYcondiciones: terminosYcondicionesController.sink.add,

      onChangedRazonSocial: razonSocialController.sink.add,
      onChangedNit: nitController.sink.add,
      onChangedCorreoEmpresa: correoEmpresaController.sink.add,
      onChangedContrasenaEmpresa: contrasenaEmpresaController.sink.add,
      onChangedRepetirContrasenaEmpresa: repetirContrasenaEmpresaController.sink.add,
      onChangedcodigoDeVendedor: codigoDeVendedorController.sink.add,
      onChangedRUT: rutController.sink.add,
      onChangedCamaraDeComercio: camaraDeComercioController.sink.add,
      onChangedCedula: cedulaController.sink.add,
      onChangedLogo: logoController.sink.add,
      onChangedTerminosYcondicionesEmpresa: terminosYcondicionesEmpresaController.sink.add,

      nombre$: nombre$,
      apellido$: apellido$,
      email$: email$,
      nroDocumento$: nroDocumento$,
      contrasena$: contrasena$,
      repetirContrasena$: repetirContrasena$,
      tipoRegistro$: tipoRegistro$,
      terminosYcondiciones$: terminosYcondiciones$,
      terminosYcondicionesEmpresa$: terminosYcondicionesEmpresa$,

      cleanControllers: () => cleanControllersController.add(null),
      cleanControllers$: cleanControllers$,
      
      isValidNombre$: isValidNombre$,
      isValidApellido$: isValidApellido$,
      isValidEmail$: isValidEmail$,
      isValidNroDocumento$: isValidNroDocumento$,
      isValidContrasena$: isValidContrasena$,

      razonSocial$: razonSocial$,
      nit$: nit$,
      correoEmpresa$: correoEmpresa$,
      contrasenaEmpresa$: contrasenaEmpresa$,
      repetirContrasenaEmpresa$: repetirContrasenaEmpresa$,
      codigoDeVendedor$: codigoDeVendedor$,
      rut$: rut$,
      camaraDeComercio$: camaraDeComercio$,
      cedula$: cedula$,
      logo$: logo$,

      isValidRazonSocial$: isValidRazonSocial$,
      isValidNit$: isValidNit$,
      isValidCorreoEmpresa$: isValidCorreoEmpresa$,
      isValidContrasenaEmpresa$: isValidContrasenaEmpresa$,
      isValidCodigoDeVendedor$: isValidCodigoDeVendedor$,
    );

=======
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
>>>>>>> d85b15ece6c0f28f2fdf937ccf08f1a9a14e1e25
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
    bool terminosYcondiciones
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
<<<<<<< HEAD
  static Stream<RegistroMessage> _onSubmitFormEmpresa({
    UsuarioRepository usuarioRepository,
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
    File logo,
    bool terminosYcondiciones
  }) async* {
    try{
=======
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
>>>>>>> d85b15ece6c0f28f2fdf937ccf08f1a9a14e1e25
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
<<<<<<< HEAD
  void cleanInputsText(){
    onChangedNombre(null);
    onChangedApellido(null);
    onChangedEmail(null);
    onChangedNroDocumento(null);
    onChangedContrasena(null);
    onChangedRepetirContrasena(null);
    onChangedTerminosYcondiciones(false);

    onChangedRazonSocial(null);
    onChangedNit(null);
    onChangedCorreoEmpresa(null);
    onChangedContrasenaEmpresa(null);
    onChangedRepetirContrasenaEmpresa(null);
    onChangedcodigoDeVendedor(null);
    onChangedRUT(null);
    onChangedCamaraDeComercio(null);
    onChangedCedula(null);
    onChangedLogo(null);
    onChangedTerminosYcondicionesEmpresa(false);
=======
  void cleanInputsText() {
    onChangedNombre('');
    onChangedApellido('');
    onChangedEmail('');
    onChangedNroDocumento('');
    onChangedContrasena('');
    onChangedRepetirContrasena('');
>>>>>>> d85b15ece6c0f28f2fdf937ccf08f1a9a14e1e25

    // clean textEditingsControllers
    cleanControllers();
  }
}
