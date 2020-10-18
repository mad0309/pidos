import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pidos/src/presentation/blocs/provider/my_base_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:distinct_value_connectable_stream/distinct_value_connectable_stream.dart';

class MiMonederoBloc extends MyBaseBloc {

  final ValueStream<double> pidosDisponibles$;
  final ValueStream<double> pidoscashDisponibles$;
  final Sink<double> pidosDisponiblesSink$;
  final Sink<double> pidoscashDisponiblesSink$;


  MiMonederoBloc._({
    this.pidosDisponibles$,
    this.pidoscashDisponibles$,
    this.pidosDisponiblesSink$,
    this.pidoscashDisponiblesSink$,
    //dipose
    @required Function dispose,
  }) : super(dispose);


  factory MiMonederoBloc({
    double pidosDisponiblesInit,
    double pidoscashDisponiblesInit
  }){

    //Controllers
    final pidosDisponiblesController = PublishSubject<double>();
    final pidcashDisponiblesController = PublishSubject<double>();


    //Streams
    final pidosDisponibles$ = pidosDisponiblesController
      .shareValueSeededDistinct(seedValue: pidosDisponiblesInit);
    final pidoscashDisponibles$ = pidcashDisponiblesController
      .shareValueSeededDistinct(seedValue: pidoscashDisponiblesInit);
    
    //subscriptions
    final subscriptions = <StreamSubscription>[
      pidosDisponibles$.listen((value) => print('[MI_MONEDERO_BLOC] pidosDisponibles=$value')),
      pidoscashDisponibles$.listen((value) => print('[MI_MONEDERO_BLOC] pidoscashDisponibles=$value')),
      
      // loginaMessage$.connect(),
    ];


    ///Dispose
    final dispose = () async {
      await Future.wait(subscriptions.map((s) => s.cancel()));
      await Future.wait([
        pidosDisponiblesController.close(),
        pidcashDisponiblesController.close(),
      ]);
      print('[MI_MONEDERO_BLOC] dispose');
    };


    return MiMonederoBloc._(
      pidosDisponibles$: pidosDisponibles$,
      pidoscashDisponibles$: pidoscashDisponibles$,
      pidosDisponiblesSink$: pidosDisponiblesController.sink,
      pidoscashDisponiblesSink$: pidcashDisponiblesController.sink,
      //dipose
      dispose: dispose
    );
  }



  //static methods

}