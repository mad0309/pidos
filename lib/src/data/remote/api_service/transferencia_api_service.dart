

import 'package:pidos/src/data/remote/network_utils.dart';

class TransferenciaApiService {
  
  final NetworkUtil networkUtil;

  const  TransferenciaApiService(this.networkUtil); 

  Future<dynamic> trasferirPidPuntos({
    int pid,
    String documentDestination
  }) async {
    try{
      final resp = await networkUtil.post(url: '/user/pid/transfer', data: {
        "amount": pid,
        "destination": documentDestination,
      });
      return resp.data;
    }catch(err){
      // throw ApiResult.failure(error: NetworkExceptions.getDioException(err));
      throw err;
    }

  }

  Future<dynamic> trasferirPidCash({
    int pidCash,
    String documentDestination
  }) async {
    try{
      final resp = await networkUtil.post(url: '/user/pidcash/transfer', data: {
        "amount": pidCash,
        "destination": documentDestination,
      });
      return resp.data;
    }catch(err){
      // throw ApiResult.failure(error: NetworkExceptions.getDioException(err));
      throw err;
    }

  }


}