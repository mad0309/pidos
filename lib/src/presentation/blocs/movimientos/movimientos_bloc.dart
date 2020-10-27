
import 'dart:async';

import 'package:meta/meta.dart';
import 'package:pidos/src/domain/models/movimientos.dart';
import 'package:pidos/src/domain/repository/movimientos_repository.dart';

import 'package:pidos/src/presentation/blocs/provider/my_base_bloc.dart';
import 'package:pidos/src/presentation/states/result_state.dart';
import 'package:rxdart/rxdart.dart';


class MovimientosBloc extends MyBaseBloc {

  final ValueStream<ResultState<List<Movimientos>>> listarMovimientos$;

  MovimientosBloc._({
    this.listarMovimientos$,
    //dipose
    @required Function dispose
  }) : super(dispose);


  factory MovimientosBloc({
    MovimientosRepository movimientosRepository
  }){


    //controllers 
    final listarMovimientosController = PublishSubject<void>();

    
    //strams
    final listarMovimientos$ = listarMovimientosController
      .startWith(null)
      .switchMap((page) => _listarMovimientos( movimientosRepository: movimientosRepository ))
      .distinct()
      .publishValueSeeded(ResultState.loading());

    ////subscriptions
    final subscriptions = <StreamSubscription>[
      listarMovimientos$.listen((state) => print('[MOVIMIENTOS_BLOC] lsMovimientos=$state')),
      
      listarMovimientos$.connect(),
    ];


    //Dispose
    final dispose = () async {
      await Future.wait(subscriptions.map((s) => s.cancel()));
      await Future.wait([
        listarMovimientosController.close(),
      ]);
      print('[MOVIMIENTOS_BLOC] dispose');
    };

    return MovimientosBloc._(
      dispose: dispose,
      listarMovimientos$: listarMovimientos$,
    );


  }


  //static methods
  static Stream<ResultState<List<Movimientos>>> _listarMovimientos({
    MovimientosRepository movimientosRepository
  }){
    return movimientosRepository.listarMovimientos()
    .map((lsMovimientos) => ResultState.data(data: lsMovimientos))
    .onErrorReturnWith((e) => ResultState.error(error: e))
    .startWith(ResultState.loading());



  }


  
}