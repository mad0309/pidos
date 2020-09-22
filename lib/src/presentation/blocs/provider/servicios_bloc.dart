import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pidos/src/data/local/preferencias_usuario.dart';
import 'package:pidos/src/presentation/blocs/provider/my_base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class ServiciosBloc extends MyBaseBloc {

  final ValueStream<bool> isPidChasActive$;
  Sink<bool> isPidChasActiveSink$;


  ServiciosBloc._({
    this.isPidChasActive$,
    this.isPidChasActiveSink$,
    @required Function dispose
  }) : super(dispose);


  factory ServiciosBloc({
    PreferenciasUsuario preferenciasUsuario,
    bool initActive
  }) {


    //controller
    final isPidChasActiveController = PublishSubject<bool>();


    final isPidChasActive$ = isPidChasActiveController
      .startWith(initActive)
      .switchMap((value) => checkPidCash(preferenciasUsuario: preferenciasUsuario,value: value))
      .publishValueSeeded(false);



    //subscriptions
    final subscriptions = <StreamSubscription>[
      isPidChasActive$.listen((value) => print(value)),
      isPidChasActive$.connect(),
    ];


    ///Dispose
    final dispose = () async {
      await Future.wait(subscriptions.map((s) => s.cancel()));
      await Future.wait([
        isPidChasActiveController.close()
      ]);
      print('[LOGIN_BLOC] dispose');
    };

    return ServiciosBloc._(
      isPidChasActive$: isPidChasActive$,
      isPidChasActiveSink$: isPidChasActiveController.sink,
      //dipose
      dispose: dispose
    );
  }


  static Stream<bool> checkPidCash({
    PreferenciasUsuario preferenciasUsuario,
    bool value
  }) async* {
    preferenciasUsuario.setBool(StorageKeys.pidCash, value);
    // final active =  preferenciasUsuario.getBool(StorageKeys.pidCash);
    yield value;
  }


}