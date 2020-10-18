
import 'dart:async';

import 'package:meta/meta.dart';
import 'package:pidos/src/domain/models/usuario.dart';
import 'package:pidos/src/presentation/blocs/provider/my_base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class MiCuentaBloc extends MyBaseBloc {

  final Function(String) onChangedNombres;
  final Function(String) onChangedApellidos;
  final Function(String) onChangedNroCelular;
  final Function(String) onChangedEmail;
  final Function(String) onChangedNroDocumento;
  final Function(String) onChangedGenero;
  final Function(String) onChangedEstadoCivil;
  final Function(String) onChangedContrasena;
  final Function(String) onChangedConfirmarContrasena;

  final ValueStream<String> nombres$;
  final ValueStream<String> apellidos$;
  final ValueStream<String> nroCelular$;
  final ValueStream<String> email$;
  final ValueStream<String> nroDocumento$;
  final ValueStream<String> genero$;
  final ValueStream<String> estadoCivil$;
  final ValueStream<String> contrasena$;
  final ValueStream<String> confirmarContrasena$;

  MiCuentaBloc._({
    this.onChangedNombres,
    this.onChangedApellidos,
    this.onChangedNroCelular,
    this.onChangedEmail,
    this.onChangedNroDocumento,
    this.onChangedGenero,
    this.onChangedEstadoCivil,
    this.onChangedContrasena,
    this.onChangedConfirmarContrasena,

    this.nombres$,
    this.apellidos$,
    this.nroCelular$,
    this.email$,
    this.nroDocumento$,
    this.genero$,
    this.estadoCivil$,
    this.contrasena$,
    this.confirmarContrasena$,
    //disepose
    @required dispose
  }) : super(dispose);

  factory MiCuentaBloc({
    Usuario usuarioInit
  }){

    //Controllers
    final nombresController = BehaviorSubject<String>.seeded(usuarioInit?.name ?? '');
    final apellidosController = BehaviorSubject<String>.seeded('');
    final nroCelularController = BehaviorSubject<String>.seeded(usuarioInit?.nroCelular ?? '');
    final emailController = BehaviorSubject<String>.seeded(usuarioInit.email ?? '');
    final nroDocumentoController = BehaviorSubject<String>.seeded(usuarioInit?.document.toString() ?? '');
    final generoController = BehaviorSubject<String>.seeded('');
    final estadoCivilController = BehaviorSubject<String>.seeded('');
    final contrasenaController = BehaviorSubject<String>.seeded('');
    final confirmarContrasenaController = BehaviorSubject<String>.seeded('');

    //streams
    final nombres$ = nombresController.shareValue();
    final apellidos$ = apellidosController.shareValue();
    final nroCelular$ = nroCelularController.shareValue();
    final email$ = emailController.shareValue();
    final nroDocumento$ = nroDocumentoController.shareValue();
    final genero$ = generoController.shareValue();
    final estadoCivil$ = estadoCivilController.shareValue();
    final contrasena$ = contrasenaController.shareValue();
    final confirmarContrasena$ = confirmarContrasenaController.shareValue();
    

    //subscriptions
    final subscriptions = <StreamSubscription>[
      nombresController.listen((value) => print('[HOME_BLOC] nombres=$value')),
      apellidosController.listen((value) => print('[HOME_BLOC] apellidos=$value')),
      nroCelularController.listen((value) => print('[HOME_BLOC] nroCelular=$value')),
      emailController.listen((value) => print('[HOME_BLOC] email=$value')),
      nroDocumentoController.listen((value) => print('[HOME_BLOC] nroDocumento=$value')),
      generoController.listen((value) => print('[HOME_BLOC] genero=$value')),
      estadoCivilController.listen((value) => print('[HOME_BLOC] estadoCivil=$value')),
      contrasenaController.listen((value) => print('[HOME_BLOC] contrasena=$value')),
      confirmarContrasenaController.listen((value) => print('[HOME_BLOC] confirmarContrasena=$value')),
      
      // loginaMessage$.connect(),
    ];

    //Dispose
    final dispose = () async {
      await Future.wait(subscriptions.map((s) => s.cancel()));
      await Future.wait([
        nombresController.close(),
        apellidosController.close(),
        nroCelularController.close(),
        emailController.close(),
        nroDocumentoController.close(),
        generoController.close(),
        estadoCivilController.close(),
        contrasenaController.close(),
        confirmarContrasenaController.close(),
      ]);
      print('[HOME_BLOC] dispose');
    };


    return MiCuentaBloc._(
      dispose: dispose,
      onChangedNombres: nombresController.sink.add,
      onChangedApellidos: apellidosController.sink.add,
      onChangedNroCelular: nroCelularController.sink.add,
      onChangedEmail: emailController.sink.add,
      onChangedNroDocumento: nroDocumentoController.sink.add,
      onChangedGenero: generoController.sink.add,
      onChangedEstadoCivil: estadoCivilController.sink.add,
      onChangedContrasena: contrasenaController.sink.add,
      onChangedConfirmarContrasena: confirmarContrasenaController.sink.add,
      
      nombres$: nombres$,
      apellidos$: apellidos$,
      nroCelular$: nroCelular$,
      email$: email$,
      nroDocumento$: nroDocumento$,
      genero$: genero$,
      estadoCivil$: estadoCivil$,
      contrasena$: contrasena$,
      confirmarContrasena$: confirmarContrasena$,

    );

  }

}