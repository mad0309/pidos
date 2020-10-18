


import 'package:pidos/src/data/remote/api_result.dart';
import 'package:pidos/src/presentation/states/transferencia_message.dart';

abstract class TransferenciaRepository {

  Future<ApiResult<TransferenciaMessage>> tranferirPidPuntos({int pid,String documentDestination});
  Future<ApiResult<TransferenciaMessage>> tranferirPidCash({int pidCash,String documentDestination});


}