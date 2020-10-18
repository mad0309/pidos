

import 'dart:convert';

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
  Future<Usuario> crearUsuario(Usuario usuario) async {
    try{
      final resp = await networkUtil.post(url: '/client/create', data: {
        "first_name": usuario.firstName,
        "last_name": usuario.lastName,
        "email": usuario.email,
        "document": usuario.document,
        "password": usuario.contrasena
      });
      return Usuario.fromJson(resp.data);
    }catch(err){
      // throw ApiResult.failure(error: NetworkExceptions.getDioException(err));
      throw err;
    }
  }
  Future<dynamic> enviarCodigo(Usuario usuario) async {
    try{
      final resp = await networkUtil.post(url: '/verify', data: {
        "id": usuario.id,
        "phone": usuario.nroCelular,
        "email": usuario.email,
      });
      return resp.data;
    }catch(err){
      // throw ApiResult.failure(error: NetworkExceptions.getDioException(err));
      throw err;
    }
  }
  Future<dynamic> checkCode(Usuario usuario, String code) async {
    try{
      final resp = await networkUtil.post(url: '/verify/checkcode', data: {
        "id": usuario.id,
        "email": usuario.email,
        "code": code,
      });
      return resp.data;
    }catch(err){
      // throw ApiResult.failure(error: NetworkExceptions.getDioException(err));
      throw err;
    }
  }


}