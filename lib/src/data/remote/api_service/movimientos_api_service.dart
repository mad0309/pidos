

import 'package:pidos/src/data/remote/network_utils.dart';

class MovimientosApiService {

  final NetworkUtil networkUtil;

  const  MovimientosApiService(this.networkUtil); 

  Future<dynamic> retornaValorActualDelPid({int page}) async {
    try{
      final resp = await networkUtil.post(url: '/user/history', data: {
        'page': page
      });
      return resp.data;
    }catch(err){
      // throw ApiResult.failure(error: NetworkExceptions.getDioException(err));
      throw err;
    }
  }

}