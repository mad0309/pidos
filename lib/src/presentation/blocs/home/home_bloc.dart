
import 'dart:async';

import 'package:meta/meta.dart';
import 'package:pidos/src/data/exceptions/network_exceptions.dart';
import 'package:pidos/src/domain/models/usuario.dart';
import 'package:pidos/src/domain/repository/usuario_repository.dart';
import 'package:pidos/src/presentation/blocs/provider/my_base_bloc.dart';
import 'package:pidos/src/presentation/states/result_state.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends MyBaseBloc {

  final ValueStream<ResultState<Usuario>> retornaSaldoState$;
  final Function retornaSaldo;

  HomeBloc._({
    this.retornaSaldoState$,
    this.retornaSaldo,
    //dispose
    @required Function dispose,
  }) : super(dispose);


  factory HomeBloc({
    UsuarioRepository usuarioRepository
  }) {
    //controller 
    final retornaSaldoController = PublishSubject<void>();
    

    //streams
    final retornaSaldoState$ = retornaSaldoController
      .startWith(null)
      .switchMap((_) => _retornaSaldo(usuarioRepository: usuarioRepository))
      .publishValueSeeded(ResultState.loading());



    //subscriptions
    final subscriptions = <StreamSubscription>[
      retornaSaldoState$.listen((value) => print('[HOME_BLOC] retornaSaldoState=$value')),
      
      retornaSaldoState$.connect(),
    ];


    ///Dispose
    final dispose = () async {
      await Future.wait(subscriptions.map((s) => s.cancel()));
      await Future.wait([
        retornaSaldoController.close(),
      ]);
      print('[HOME_BLOC] dispose');
    };

  return HomeBloc._(
    dispose: dispose,
    retornaSaldoState$: retornaSaldoState$,
    retornaSaldo: () => retornaSaldoController.add(null)
  );

  }


  //static methods
  static Stream<ResultState<Usuario>> _retornaSaldo({
    UsuarioRepository usuarioRepository
  }) {
    return usuarioRepository.retornasSaldo()
      .map((saldo) => ResultState.data(data: saldo))
      .onErrorReturnWith((error) => ResultState.error(error: NetworkExceptions.getDioException(error)))
      .startWith(ResultState.loading());
  }



}