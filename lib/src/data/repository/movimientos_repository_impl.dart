import 'package:pidos/src/data/exceptions/network_exceptions.dart';
import 'package:pidos/src/data/remote/api_service/movimientos_api_service.dart';
import 'package:pidos/src/domain/models/movimientos.dart';
import 'package:pidos/src/domain/repository/movimientos_repository.dart';



class MovimientosRepositoryImpl implements MovimientosRepository {

  final MovimientosApiService movimientosApiService;

  const MovimientosRepositoryImpl({this.movimientosApiService});

  @override
  Stream<List<Movimientos>> listarMovimientos() async* {
    try{
      // int page;
      List<Movimientos> lsMovimientos = List();
      final resp = await movimientosApiService.retornaValorActualDelPid(page: null);
      if( resp['data']!=null && resp['data'].length>0 ){
        lsMovimientos.add(Movimientos.fromJson(resp['data'][0]));
        if( resp['total'] > 1 ){
          for( var i=2; i<=resp['total'];i++ ){
            final respPerPage = await movimientosApiService.retornaValorActualDelPid(page: i);
            if( respPerPage['data']!=null && respPerPage['data'].length>0 ){
              lsMovimientos.add(Movimientos.fromJson(respPerPage['data'][0]));
            }
          }
        }
      }
      yield lsMovimientos;
    }catch(err){
      print('[MOVIMIENTOS_REPOSITORY][listarMovimientos()] ERROR => $err');
      throw NetworkExceptions.getDioException(err);
    }
  }

}