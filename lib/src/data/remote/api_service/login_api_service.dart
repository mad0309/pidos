

import 'package:pidos/src/data/exceptions/network_exceptions.dart';
import 'package:pidos/src/data/remote/api_result.dart';
import 'package:pidos/src/data/remote/network_utils.dart';
import 'package:pidos/src/domain/models/usuario.dart';

class LoginApiService {
  final NetworkUtil networkUtil;
  const LoginApiService(this.networkUtil);


  Future<String> login(Usuario user) async {
    try{
      final resp = await networkUtil.post(url: '/auth/login', data: {
        "email": user.nroCelular,
        "password": user.contrasena
      });
      // if (resp.statusCode < 200 || resp.statusCode >= 300) {
      //   throw NetworkException(resp.statusCode, resp.statusMessage);
      // }
      return resp.data['access_token'];
    }catch(err){
      // throw ApiResult.failure(error: NetworkExceptions.getDioException(err));
      throw err;
    }
  }

  Future<Usuario> retornaUsuario() async {
    try{
      final resp = await networkUtil.post(url: '/me', data: {});
      return Usuario.fromJson(resp.data);
    }catch(err){
      // throw ApiResult.failure(error: NetworkExceptions.getDioException(err));
      throw err;
    }
  }


}