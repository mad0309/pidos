import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pidos/src/data/local/preferencias_usuario.dart';
class AppInterceptor implements Interceptor {
  
  @override
  Future onRequest(RequestOptions options) async  {
    final prefs = new PreferenciasUsuario();
    Map<String,dynamic> customHeaders = {};
    if( !( options.uri.toString().contains('auth/') ) ){
      final token = prefs.get(StorageKeys.token);
      customHeaders = {
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };
    }
    options.headers.addAll(customHeaders);
    options.responseType = ResponseType.json;
    return options;
  }

  @override
  Future onError(DioError err) async  {
    return err;
  }

  @override
  Future onResponse(Response response) async {
    return response;
  }

}